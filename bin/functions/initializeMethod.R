#' @title Initialize Method
#' @description This function initializes the `nipalsImpute` field with the 
#'              provided median-normalized data.
#' @author Jea Park
#' @date 6/21/2024
#' @details The function sets the `nipalsImpute` field of the object to the 
#'          provided `dfMedian` data, preparing it for further processing.
#' @param dfMedian A matrix containing the median-normalized data to be 
#'                 used for imputation.
#' @return This function does not return a value. It initializes the 
#'         `nipalsImpute` field of the object.

initializeMethod <- function(dfMedian) {
  # Initialize the nipalsImpute field with the provided dfMedian data
  self$nipalsImpute <- dfMedian
}
