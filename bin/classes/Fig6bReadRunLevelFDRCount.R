# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6bReadRunLevelFDRCount R6 class, 
#              which reads data and metadata from run-level FDR counts.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "readr")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' Fig6bReadRunLevelFDRCount Class
#'
#' The Fig6bReadRunLevelFDRCount class reads data and metadata from CSV files.
#'
#' @field input_path1 A character string specifying the path to the data CSV file.
#' @field input_path2 A character string specifying the path to the metadata 
#'        CSV file.
#' @field dat A data frame containing the data from the CSV file.
#' @field meta_dt A data frame containing the metadata from the CSV file.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(input_path1, input_path2)}}{
#'     Initializes the object with paths to the data and metadata CSV files, 
#'     then reads the data.
#'   }
#'   \item{\code{readData()}}{
#'     Reads data and metadata from the specified CSV files.
#'   }
#' }

Fig6bReadRunLevelFDRCount <- R6Class("Fig6bReadRunLevelFDRCount",
                                     public = list(
                                       input_path1 = NULL,
                                       input_path2 = NULL,
                                       dat = NULL,
                                       meta_dt = NULL,
                                       
                                       #' Initialize the Fig6bReadRunLevelFDRCount object
                                       #'
                                       #' @param input_path1 A character string specifying the path to the 
                                       #'        data CSV file.
                                       #' @param input_path2 A character string specifying the path to the 
                                       #'        metadata CSV file.
                                       #' 
                                       #' @return A new Fig6bReadRunLevelFDRCount object.
                                       initialize = function(input_path1, input_path2) {
                                         self$input_path1 <- input_path1
                                         self$input_path2 <- input_path2
                                         self$readData()
                                       },
                                       
                                       #' Read Data and Metadata from CSV Files
                                       #'
                                       #' This method reads data and metadata from the specified CSV files.
                                       #'
                                       #' @return NULL
                                       readData = function() {
                                         self$dat <- read_csv(self$input_path1)
                                         self$meta_dt <- read_csv(self$input_path2)
                                         self$meta_dt[self$meta_dt == "na"] <- NA
                                       }
                                     )
)
