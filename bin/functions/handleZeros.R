handleZeros <- function() {
  self$df[self$df == 0] <- NA
}