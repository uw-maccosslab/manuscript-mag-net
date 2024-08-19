# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6bProcessFilePath R6 class, 
#              which processes file paths for batch files.

# Ensure the required packages are installed and loaded
required_packages <- c("R6")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' Fig6bProcessFilePath Class
#'
#' The Fig6bProcessFilePath class processes file paths for batch files.
#'
#' @field filepath A character vector containing the original file paths.
#' @field newFileName A character vector containing the processed file paths.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(filepath)}}{
#'     Initializes the object with the original file paths and processes them.
#'   }
#'   \item{\code{processFilepath()}}{
#'     Processes the file paths to generate new file names.
#'   }
#' }

Fig6bProcessFilePath <- R6Class("Fig6bProcessFilePath",
                                public = list(
                                  filepath = NULL,
                                  newFileName = NULL,
                                  
                                  #' Initialize the Fig6bProcessFilePath object
                                  #'
                                  #' @param filepath A character vector containing the original file paths.
                                  #' 
                                  #' @return A new Fig6bProcessFilePath object.
                                  initialize = function(filepath) {
                                    self$filepath <- filepath
                                    self$processFilepath()
                                  },
                                  
                                  #' Process File Paths
                                  #'
                                  #' This method processes the file paths to generate new file names.
                                  #'
                                  #' @return NULL
                                  processFilepath = function() {
                                    tempidx <- grep("Batch", self$filepath)
                                    temp <- strsplit(self$filepath[tempidx], "_")
                                    self$newFileName <- self$filepath
                                    for (i in 1:length(temp)) {
                                      self$newFileName[tempidx[i]] <- paste0(temp[[i]][1], "_",
                                                                             temp[[i]][2], "_",
                                                                             temp[[i]][3], "_",
                                                                             temp[[i]][4], "_",
                                                                             temp[[i]][6], "_",
                                                                             temp[[i]][5], "_",
                                                                             temp[[i]][5], "_",
                                                                             temp[[i]][7])
                                    }
                                  }
                                )
)
