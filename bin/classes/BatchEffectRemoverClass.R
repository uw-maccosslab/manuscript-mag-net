# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the BatchEffectRemover R6 class, which handles
#              the removal of batch effects from a dataset using external functions.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "limma")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source external R scripts
source("functions/initializeBatchEffectRemover.R")  # Function to initialize the BatchEffectRemover object
source("functions/removeControls.R")  # Function to remove control samples from the dataset
source("functions/removeBatchEffect.R")  # Function to perform batch effect removal from the dataset

#' BatchEffectRemover Class
#'
#' The BatchEffectRemover class handles the removal of batch effects from a dataset
#' using external functions for initialization, control removal, and batch effect removal.
#'
#' @field imputedData A data frame containing the imputed data.
#' @field metaDt A data frame containing the metadata.
#' @field protGrp A data frame containing the protein groups.
#' @field nobatchMeta A data frame containing the metadata without batch effects.
#' @field nobatchProt A data frame containing the protein groups without batch effects.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize()}}{
#'     Initializes the object using an external initialization method.
#'   }
#'   \item{\code{removeControls()}}{
#'     Removes control samples from the dataset using an external method.
#'   }
#'   \item{\code{removeBatchEffect()}}{
#'     Removes batch effects from the dataset using an external method.
#'   }
#' }

BatchEffectRemover <- R6Class("BatchEffectRemover",
                              public = list(
                                imputedData = NULL,  # Data frame containing the imputed data
                                metaDt = NULL,  # Data frame containing the metadata
                                protGrp = NULL,  # Data frame containing the protein groups
                                nobatchMeta = NULL,  # Data frame containing metadata without batch effects
                                nobatchProt = NULL,  # Data frame containing protein groups without batch effects
                                
                                #' Initialize the BatchEffectRemover object
                                #'
                                #' This method initializes the BatchEffectRemover object using an external 
                                #' initialization method.
                                #'
                                #' @param ... Additional arguments passed to the initialization method.
                                #'
                                #' @return NULL
                                initialize = initializeBatchEffectRemover,
                                
                                #' Remove Control Samples
                                #'
                                #' This method removes control samples from the dataset using an external method.
                                #'
                                #' @param ... Additional arguments passed to the control removal method.
                                #'
                                #' @return NULL
                                removeControls = removeControls,
                                
                                #' Remove Batch Effects
                                #'
                                #' This method removes batch effects from the dataset using an external method.
                                #'
                                #' @param ... Additional arguments passed to the batch effect removal method.
                                #'
                                #' @return NULL
                                removeBatchEffect = removeBatchEffect
                              )
)
