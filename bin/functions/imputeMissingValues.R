imputeMissingValues <- function(dataMatrix, cutoff) {
  for (j in 1:nrow(dataMatrix)) {
    rowSum <- sum(is.na(dataMatrix[j, ]))
    if (rowSum / ncol(dataMatrix) > cutoff) {
      dataMatrix[j, ][is.na(dataMatrix[j, ])] <- 0
    }
  }
  return(dataMatrix)
}