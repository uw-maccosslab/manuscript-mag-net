# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the CompleteDataProcessor R6 class, which 
#              processes data through normalization, imputation, and batch 
#              effect removal steps using external classes.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "limma")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source external R scripts
source("classes/DataNormalizerClass.R")  # Class for data normalization
source("classes/ImputerClass.R")  # Class for data imputation
source("classes/BatchEffectRemoverClass.R")  # Class for batch effect removal

#' CompleteDataProcessor Class
#'
#' The CompleteDataProcessor class processes data through normalization, 
#' imputation, and batch effect removal steps.
#'
#' @field dat A data frame containing the raw data.
#' @field metaDt A data frame containing the metadata.
#' @field normalizedData A data frame containing the normalized data.
#' @field imputedData A data frame containing the imputed data.
#' @field batchEffectRemovedData A data frame containing the batch effect 
#' removed data.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(dat, metaDt)}}{
#'     Initializes the object with raw data and metadata, and processes the data.
#'   }
#'   \item{\code{processData()}}{
#'     Processes the data through normalization, imputation, and batch effect 
#'     removal steps.
#'   }
#'   \item{\code{getDat()}}{
#'     Returns the raw data.
#'   }
#'   \item{\code{getNormalizedData()}}{
#'     Returns the normalized data.
#'   }
#'   \item{\code{getImputedData()}}{
#'     Returns the imputed data.
#'   }
#'   \item{\code{getBatchEffectRemovedData()}}{
#'     Returns the batch effect removed data.
#'   }
#'   \item{\code{getMetaDt()}}{
#'     Returns the metadata.
#'   }
#' }

CompleteDataProcessor <- R6Class("CompleteDataProcessor",
                                 public = list(
                                   dat = NULL,  # Raw data
                                   metaDt = NULL,  # Metadata
                                   normalizedData = NULL,  # Normalized data
                                   imputedData = NULL,  # Imputed data
                                   batchEffectRemovedData = NULL,  # Batch effect removed data
                                   
                                   #' Initialize the CompleteDataProcessor object
                                   #'
                                   #' @param dat A data frame containing the raw data.
                                   #' @param metaDt A data frame containing the metadata.
                                   #' 
                                   #' @return A new CompleteDataProcessor object.
                                   initialize = function(dat, metaDt) {
                                     self$dat <- dat
                                     self$metaDt <- metaDt
                                     self$processData()
                                   },
                                   
                                   #' Process Data
                                   #'
                                   #' This method processes the data through normalization, imputation, and 
                                   #' batch effect removal steps.
                                   #'
                                   #' @return NULL
                                   processData = function() {
                                     # Data normalization
                                     dataNormalizer <- DataNormalizer$new(self$dat)
                                     self$normalizedData <- dataNormalizer$dfMedian
                                     
                                     # Imputation
                                     imputerInstance <- Imputer$new(self$normalizedData)
                                     imputerInstance$metaDat <- self$metaDt
                                     self$imputedData <- imputerInstance$imputeCondition()
                                     
                                     # Batch effect removal
                                     batchEffectRemover <- BatchEffectRemover$new(self$imputedData, self$metaDt)
                                     batchEffectRemover$removeControls()
                                     batchEffectRemover$removeBatchEffect()
                                     self$batchEffectRemovedData <- batchEffectRemovedData <- batchEffectRemover$nobatchProt
                                   },
                                   
                                   #' Get Raw Data
                                   #'
                                   #' This method returns the raw data.
                                   #'
                                   #' @return A data frame containing the raw data.
                                   getDat = function() {
                                     return(self$dat)
                                   },
                                   
                                   #' Get Normalized Data
                                   #'
                                   #' This method returns the normalized data.
                                   #'
                                   #' @return A data frame containing the normalized data.
                                   getNormalizedData = function() {
                                     return(self$normalizedData)
                                   },
                                   
                                   #' Get Imputed Data
                                   #'
                                   #' This method returns the imputed data.
                                   #'
                                   #' @return A data frame containing the imputed data.
                                   getImputedData = function() {
                                     return(self$imputedData)
                                   },
                                   
                                   #' Get Batch Effect Removed Data
                                   #'
                                   #' This method returns the batch effect removed data.
                                   #'
                                   #' @return A data frame containing the batch effect removed data.
                                   getBatchEffectRemovedData = function() {
                                     return(self$batchEffectRemovedData)
                                   },
                                   
                                   #' Get Metadata
                                   #'
                                   #' This method returns the metadata.
                                   #'
                                   #' @return A data frame containing the metadata.
                                   getMetaDt = function() {
                                     return(self$metaDt)
                                   }
                                 )
)
