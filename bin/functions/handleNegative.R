#' @title Handle Negative Values
#' @description This function replaces negative Log2-transformed values in the 
#'              data with NA.
#' @author Jea Park
#' @date 6/21/2024
#' @details The function identifies negative values in the Log2-transformed 
#'          data and replaces them with NA.
#' @return None

handleNegative <- function() {
  # Replace negative Log2-transformed values with NA
  self$df[log2(self$df) < 0] <- NA
}
