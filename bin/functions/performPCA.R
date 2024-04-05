performPCA <- function(dataMatrix, nPcs = 2) {
  if (ncol(dataMatrix) < nPcs) {
    stop("Not enough columns in the data matrix for the requested number of principal components.")
  }
  pcaResult <- pcaMethods::pca(t(dataMatrix), nPcs = nPcs, method = "nipals")
  completedData <- completeObs(pcaResult)
  return(t(completedData))
}