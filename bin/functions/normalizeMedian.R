normalizeMedian <- function() {
  dfMed <- apply(as.matrix(self$dfRaw), 2, median, na.rm = TRUE)
  dfMedLoc <- dfMed - median(dfMed)
  self$dfMedian <- t(t(self$dfRaw) - dfMedLoc)
}