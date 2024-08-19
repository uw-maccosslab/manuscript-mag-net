# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6bGenerator R6 class, which 
#              processes data from elib files, generates run-level FDR counts,
#              merges metadata, and creates a plot for peptide detections.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "DBI", "RSQLite", "readr", "ggplot2")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source class definitions
source("classes/Fig6bDataProcessor.R")
source("classes/Fig6bWrangleData.R")
source("classes/Fig6bProcessFilePath.R")
source("classes/Fig6bWriteRunLevelFDRCount.R")
source("classes/Fig6bReadRunLevelFDRCount.R")
source("classes/Fig6bMergeData.R")
source("classes/Fig6bCreatePlot.R")

#' Fig6bGenerator Class
#'
#' The Fig6bGenerator class processes data from elib files, generates 
#' run-level FDR counts, merges metadata, and creates a plot for 
#' peptide detections.
#'
#' @field filepath A character vector of file paths to elib files.
#' @field newFileName A character vector of processed file names.
#' @field runLevelFDRCount A data frame of run-level FDR counts.
#' @field dat A data frame of input data.
#' @field meta_dt A data frame of metadata.
#' @field temp A temporary data frame for processing.
#' @field metaDT A data frame of merged metadata.
#' @field p0 A ggplot object for visualizing peptide detections.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(elib_path, csv_output_path, csv_input_path1, 
#'                          csv_input_path2, pattern = "*.mzML.elib$")}}{
#'     Initializes the object with file paths and processes data.
#'   }
#'   \item{\code{extractRunLevelFDRCount()}}{
#'     Extracts run-level FDR counts from elib files.
#'   }
#' }

Fig6bGenerator <- R6Class("Fig6bGenerator",
                          public = list(
                            filepath = NULL,
                            newFileName = NULL,
                            runLevelFDRCount = NULL,
                            dat = NULL,
                            meta_dt = NULL,
                            temp = NULL,
                            metaDT = NULL,
                            p0 = NULL,
                            
                            #' Initialize the Fig6bGenerator object
                            #'
                            #' @param elib_path Path to the directory containing the elib files.
                            #' @param csv_output_path Output path for the run-level FDR count CSV.
                            #' @param csv_input_path1 Path to the input CSV file containing peptide 
                            #'        total areas.
                            #' @param csv_input_path2 Path to the input CSV file containing metadata.
                            #' @param pattern File name pattern for the elib files (default is 
                            #'        "*.mzML.elib$").
                            #' 
                            #' @return A new Fig6bGenerator object.
                            initialize = function(elib_path, csv_output_path, csv_input_path1, 
                                                  csv_input_path2, pattern = "*.mzML.elib$") {
                              self$filepath <- list.files(path = elib_path, pattern = pattern, 
                                                          full.names = TRUE)
                              
                              # Process file paths
                              filePathProcessor <- Fig6bProcessFilePath$new(self$filepath)
                              self$newFileName <- filePathProcessor$newFileName
                              
                              # Extract run-level FDR counts
                              self$extractRunLevelFDRCount()
                              
                              # Write run-level FDR counts to CSV
                              Fig6bWriteRunLevelFDRCount$new(self$runLevelFDRCount, csv_output_path)
                              
                              # Read input data
                              dataReader <- Fig6bReadRunLevelFDRCount$new(csv_input_path1, 
                                                                          csv_input_path2)
                              self$dat <- dataReader$dat
                              self$meta_dt <- dataReader$meta_dt
                              
                              # Process data
                              dataProcessor <- Fig6bDataProcessor$new(self$dat, self$meta_dt)
                              self$dat <- dataProcessor$dat
                              self$meta_dt <- dataProcessor$meta_dt
                              
                              # Merge data
                              dataMerger <- Fig6bMergeData$new(self$meta_dt, self$runLevelFDRCount)
                              self$metaDT <- dataMerger$metaDT
                              
                              # Wrangle data
                              wrangleData <- Fig6bWrangleData$new(self$dat, self$metaDT)
                              self$temp <- wrangleData$temp
                              self$metaDT <- wrangleData$meta_dt
                              
                              # Create plot
                              plotCreator <- Fig6bCreatePlot$new(self$temp, self$metaDT)
                              self$p0 <- plotCreator$p0
                            },
                            
                            #' Extract Run-Level FDR Counts
                            #'
                            #' This method extracts run-level FDR counts from elib files.
                            #'
                            #' @return A data frame of run-level FDR counts.
                            extractRunLevelFDRCount = function() {
                              `Chris ID` <- sapply(strsplit(self$newFileName, "_"), "[", 5)
                              Linkcode <- sapply(strsplit(self$newFileName, "_"), "[", 6)
                              WellNo <- sapply(strsplit(self$newFileName, "_"), "[", 7)
                              `Run Order` <- sapply(strsplit(sapply(strsplit(self$newFileName, "_"), 
                                                                    "[", 8), ".", fixed = TRUE), 
                                                    "[", 1)
                              RunLevelCount <- numeric()
                              
                              # Loop through file paths to extract run-level FDR counts
                              for (i in 1:length(self$filepath)) {
                                con <- dbConnect(RSQLite::SQLite(), self$filepath[i])
                                print(paste0("Processing file #", i))
                                dbListTables(con)
                                
                                # Check if 'entries' table exists and extract data
                                if ("entries" %in% dbListTables(con)) {
                                  RunLevelCount <- c(RunLevelCount, nrow(dbReadTable(con, "entries")))
                                } else {
                                  RunLevelCount <- c(RunLevelCount, NA)
                                  print(paste0("Warning: No 'entries' table in file ", 
                                               self$filepath[i]))
                                }
                                print(paste0("Finished file #", i))
                                dbDisconnect(con)
                              }
                              
                              # Combine extracted data into a data frame
                              self$runLevelFDRCount <- cbind(`Chris ID`, Linkcode, WellNo, 
                                                             `Run Order`, RunLevelCount, 
                                                             self$filepath)
                            }
                          )
)
