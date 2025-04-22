#' @title Impute Missing Values
#' @description This function imputes missing values in a data matrix based on 
#'              a specified cutoff.
#' @author Jea Park
#' @date 6/21/2024
#' @details The function iterates through each row of the data matrix and 
#'          replaces missing values (NAs) with zeros if the proportion of 
#'          missing values in that row exceeds the specified cutoff.
#' @param dataMatrix A matrix containing the data with potential missing values.
#' @param cutoff A numeric value specifying the proportion of missing values 
#'               allowed per row before imputation is applied.
#' @return A matrix with missing values imputed based on the specified cutoff.

imputeMissingValues <- function(dataMatrix, cutoff) {
  # Iterate through each row of the data matrix
  for (j in 1:nrow(dataMatrix)) {
    # Calculate the proportion of missing values in the row
    rowSum <- sum(is.na(dataMatrix[j, ]))
    # Impute missing values with zero if the proportion exceeds the cutoff
    if (rowSum / ncol(dataMatrix) > cutoff) {
      dataMatrix[j, ][is.na(dataMatrix[j, ])] <- 0
    }
  }
  return(dataMatrix)
}
