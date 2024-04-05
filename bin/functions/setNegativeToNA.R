setNegativeToNA <- function() {
  self$dfMedian[self$dfMedian < 0] <- NA
}