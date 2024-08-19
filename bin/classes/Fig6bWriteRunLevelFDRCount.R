# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6bWriteRunLevelFDRCount R6 class, 
#              which writes run-level FDR counts to a CSV file.

# Ensure the required packages are installed and loaded
required_packages <- c("R6")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' Fig6bWriteRunLevelFDRCount Class
#'
#' The Fig6bWriteRunLevelFDRCount class writes run-level FDR counts to a CSV 
#' file.
#'
#' @field runLevelFDRCount A data frame containing the run-level FDR counts.
#' @field output_path A character string specifying the path to the output 
#'        CSV file.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(runLevelFDRCount, output_path)}}{
#'     Initializes the object with run-level FDR counts and output path, 
#'     then writes the data to a CSV file.
#'   }
#'   \item{\code{writeCSV()}}{
#'     Writes the run-level FDR counts to the specified CSV file.
#'   }
#' }

Fig6bWriteRunLevelFDRCount <- R6Class("Fig6bWriteRunLevelFDRCount",
                                      public = list(
                                        runLevelFDRCount = NULL,
                                        output_path = NULL,
                                        
                                        #' Initialize the Fig6bWriteRunLevelFDRCount object
                                        #'
                                        #' @param runLevelFDRCount A data frame containing the run-level FDR counts.
                                        #' @param output_path A character string specifying the path to the output 
                                        #'        CSV file.
                                        #' 
                                        #' @return A new Fig6bWriteRunLevelFDRCount object.
                                        initialize = function(runLevelFDRCount, output_path) {
                                          self$runLevelFDRCount <- runLevelFDRCount
                                          self$output_path <- output_path
                                          self$writeCSV()
                                        },
                                        
                                        #' Write Run-Level FDR Counts to CSV
                                        #'
                                        #' This method writes the run-level FDR counts to the specified CSV file.
                                        #'
                                        #' @return NULL
                                        writeCSV = function() {
                                          write.csv(self$runLevelFDRCount, self$output_path, 
                                                    row.names = FALSE, col.names = TRUE)
                                        }
                                      )
)
