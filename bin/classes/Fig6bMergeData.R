# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6bMergeData R6 class, which merges
#              metadata with run-level FDR counts.

# Ensure the required packages are installed and loaded
required_packages <- c("R6")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' Fig6bMergeData Class
#'
#' The Fig6bMergeData class merges metadata with run-level FDR counts.
#'
#' @field meta_dt A data frame containing the metadata.
#' @field runLevelFDRCount A data frame containing the run-level FDR counts.
#' @field metaDT A data frame containing the merged metadata and run-level 
#'        FDR counts.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(meta_dt, runLevelFDRCount)}}{
#'     Initializes the object with metadata and run-level FDR counts, 
#'     then merges them.
#'   }
#'   \item{\code{mergeData()}}{
#'     Merges metadata with run-level FDR counts.
#'   }
#' }

Fig6bMergeData <- R6Class("Fig6bMergeData",
                          public = list(
                            meta_dt = NULL,
                            runLevelFDRCount = NULL,
                            metaDT = NULL,
                            
                            #' Initialize the Fig6bMergeData object
                            #'
                            #' @param meta_dt A data frame containing the metadata.
                            #' @param runLevelFDRCount A data frame containing the run-level FDR counts.
                            #' 
                            #' @return A new Fig6bMergeData object.
                            initialize = function(meta_dt, runLevelFDRCount) {
                              self$meta_dt <- meta_dt
                              self$runLevelFDRCount <- runLevelFDRCount
                              self$mergeData()
                            },
                            
                            #' Merge Metadata with Run-Level FDR Counts
                            #'
                            #' This method merges the metadata with the run-level FDR counts.
                            #'
                            #' @return A data frame containing the merged metadata and run-level 
                            #'         FDR counts.
                            mergeData = function() {
                              self$metaDT <- merge(self$meta_dt, 
                                                   self$runLevelFDRCount[, c("Chris ID", 
                                                                             "RunLevelCount")], 
                                                   by = "Chris ID")
                            }
                          )
)
