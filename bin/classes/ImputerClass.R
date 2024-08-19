# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Imputer R6 class, which handles 
#              data imputation using external functions for initialization 
#              and imputation methods.

# Load necessary libraries
library(R6)
library(pcaMethods)

# Source external functions
source("functions/initializeMethod.R")  # Function for initialization method
source("functions/imputeConditionMethod.R")  # Function for imputation condition method

#' Imputer Class
#'
#' The Imputer class handles data imputation using external functions for 
#' initialization and imputation methods.
#'
#' @field metaDat A data frame containing the metadata.
#' @field cutoff A numeric value for the cutoff threshold (default is 0.4).
#' @field nipalsImpute A placeholder for NIPALS imputation method.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize()}}{
#'     Initializes the object using the external initialization method.
#'   }
#'   \item{\code{imputeCondition()}}{
#'     Handles the condition-based imputation using the external method.
#'   }
#' }

Imputer <- R6Class(
  "Imputer",
  public = list(
    metaDat = NULL,      # Metadata data frame
    cutoff = 0.4,        # Cutoff threshold for imputation
    nipalsImpute = NULL, # Placeholder for NIPALS imputation method
    
    #' Initialize the Imputer object
    #'
    #' This method initializes the Imputer object using an external 
    #' initialization method.
    #'
    #' @param ... Additional arguments passed to the initialization method.
    #'
    #' @return NULL
    initialize = initializeMethod,
    
    #' Impute Condition
    #'
    #' This method handles condition-based imputation using an external method.
    #'
    #' @param ... Additional arguments passed to the imputation method.
    #'
    #' @return NULL
    imputeCondition = imputeConditionMethod
  )
)
