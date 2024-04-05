source("functions/imputeMissingValues.R")
source("functions/performPCA.R")  

imputeConditionMethod <- function() {
  for (i in 1:length(levels(as.factor(self$metaDat$Condition)))) {
    idx <- which(self$metaDat$Condition == levels(as.factor(self$metaDat$Condition))[i])
    if(length(idx) > 0) {
      imputeTemp <- self$nipalsImpute[, idx, drop = FALSE]
      
      # Apply missing value imputation
      imputeTemp <- imputeMissingValues(imputeTemp, self$cutoff)
      
      # Update the original data with imputed values before PCA
      self$nipalsImpute[, idx] <- imputeTemp
      
      # Apply PCA on the condition-specific subset after all row-specific imputations are done
      self$nipalsImpute[, idx] <- performPCA(imputeTemp)
    }
  }
  
  # Replace 0 with NA after processing all conditions and completing PCA
  self$nipalsImpute[self$nipalsImpute == 0] <- NA
  return(self$nipalsImpute)
}