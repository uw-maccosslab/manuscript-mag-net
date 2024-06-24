#' @title Handle Zeros in Data
#' @description This function replaces zeros in the data with NA.
#' @author Jea Park
#' @date 6/21/2024
#' @details The function identifies zeros in the dataset and replaces them with 
#'          NA.
#' @return None

handleZeros <- function() {
  # Replace zeros with NA
  self$df[self$df == 0] <- NA
}
