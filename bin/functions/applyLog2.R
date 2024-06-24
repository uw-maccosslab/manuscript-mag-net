#' @title Apply Log2 Transformation
#' @description This function applies a Log2 transformation to the raw data.
#' @author Jea Park
#' @date 6/21/2024
#' @details The function takes the raw data stored in the `df` field and 
#'          applies a Log2 transformation to it. The transformed data is then
#'          stored in the `dfRaw` field of the object.
#' @return None

applyLog2 <- function() {
  # Apply Log2 transformation to the raw data
  self$dfRaw <- log2(self$df)
}
