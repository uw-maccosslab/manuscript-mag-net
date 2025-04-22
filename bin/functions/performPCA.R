#' @title Perform PCA
#' @description This function performs Principal Component Analysis (PCA) on 
#'              the given data matrix using the NIPALS algorithm and returns 
#'              the completed data matrix.
#' @author Jea Park (jpark623@uw.edu)
#' @date 6/21/2024
#'
#' @details This function uses the `pca` function from the pcaMethods package 
#'          to perform PCA on the transposed data matrix. It uses the NIPALS 
#'          algorithm for PCA and returns the completed data matrix with the 
#'          specified number of principal components. If the number of columns 
#'          in the data matrix is less than the requested number of principal 
#'          components, the function stops with an error message.
#'
#' @param dataMatrix A numeric matrix with samples in columns and features in rows.
#' @param nPcs An integer specifying the number of principal components to retain.
#'             Default is 2.
#'
#' @return A numeric matrix with the completed data after PCA, transposed to have 
#'         samples in columns and features in rows.
#'
#' @importFrom pcaMethods

performPCA <- function(dataMatrix, nPcs = 2) {
  if (ncol(dataMatrix) < nPcs) {
    stop("Not enough columns in the data matrix for the requested number of principal components.")
  }
  pcaResult <- pcaMethods::pca(t(dataMatrix), nPcs = nPcs, method = "nipals")
  completedData <- completeObs(pcaResult)
  return(t(completedData))
}
