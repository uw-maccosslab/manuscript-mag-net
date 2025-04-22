# Load necessary functions
source("functions/imputeMissingValues.R")
source("functions/performPCA.R")

#' @title Impute Missing Values and Perform PCA by Condition
#' @description This function imputes missing values and performs PCA on the 
#'              data subset for each condition specified in the metadata.
#' @details This function iterates over each unique condition in the metadata, 
#'          extracts the corresponding data subset, imputes missing values, 
#'          and performs PCA. The imputed and PCA-processed data subsets are 
#'          then combined to update the original data. After processing all 
#'          conditions, zeros in the data are replaced with NAs.
#' @author Jea Park
#' @date 6/21/2024
#' 
#' @importFrom pcaMethods
#'
#' @return A matrix with imputed and PCA-processed data.
#'
#' @seealso \code{\link{imputeMissingValues}}, \code{\link{performPCA}}

imputeConditionMethod <- function() {
  # Iterate over each unique condition in the metadata
  for (i in 1:length(levels(as.factor(self$metaDat$Condition)))) {
    # Get indices of the current condition in the metadata
    idx <- which(self$metaDat$Condition == levels(as.factor(self$metaDat$Condition))[i])
    
    # Check if there are any indices for the current condition
    if (length(idx) > 0) {
      # Extract the subset of data corresponding to the current condition
      imputeTemp <- self$nipalsImpute[, idx, drop = FALSE]
      
      # Apply missing value imputation to the subset
      imputeTemp <- imputeMissingValues(imputeTemp, self$cutoff)
      
      # Update the original data with imputed values before PCA
      self$nipalsImpute[, idx] <- imputeTemp
      
      # Apply PCA on the condition-specific subset after all row-specific imputations are done
      self$nipalsImpute[, idx] <- performPCA(imputeTemp)
    }
  }
  
  # Replace 0 with NA after processing all conditions and completing PCA
  self$nipalsImpute[self$nipalsImpute == 0] <- NA
  
  # Return the imputed and PCA-processed data matrix
  return(self$nipalsImpute)
}
