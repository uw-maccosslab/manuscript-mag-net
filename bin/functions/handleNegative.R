handleNegative <- function() {
  self$df[log2(self$df) < 0] <- NA
}