# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6bWrangleData R6 class, which wrangles
#              data for Fig6b generation.

# Ensure the required packages are installed and loaded
required_packages <- c("R6")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' Fig6bWrangleData Class
#'
#' The Fig6bWrangleData class wrangles data for Fig6b figure generation.
#'
#' @field dat A data frame containing the input data.
#' @field meta_dt A data frame containing the metadata.
#' @field temp A data frame containing the wrangled data.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(dat, meta_dt)}}{
#'     Initializes the object with input data and metadata, then wrangles them.
#'   }
#'   \item{\code{wrangleData()}}{
#'     Wrangles the input data and metadata for figure generation.
#'   }
#' }

Fig6bWrangleData <- R6Class("Fig6bWrangleData",
                            public = list(
                              dat = NULL,
                              meta_dt = NULL,
                              temp = NULL,
                              
                              #' Initialize the Fig6bWrangleData object
                              #'
                              #' @param dat A data frame containing the input data.
                              #' @param meta_dt A data frame containing the metadata.
                              #' 
                              #' @return A new Fig6bWrangleData object.
                              initialize = function(dat, meta_dt) {
                                self$dat <- dat
                                self$meta_dt <- meta_dt
                                self$wrangleData()
                              },
                              
                              #' Wrangle Data and Metadata
                              #'
                              #' This method wrangles the input data and metadata for figure generation.
                              #'
                              #' @return NULL
                              wrangleData = function() {
                                # Extract run order from metadata
                                runOrder <- self$meta_dt$`Run Order`
                                
                                # Match sample IDs between data and metadata
                                raw <- as.matrix(self$dat)[, match(self$meta_dt$SampleID, 
                                                                   colnames(self$dat))]
                                
                                # Assign class label to metadata
                                self$meta_dt$class <- "Run Level FDR"
                                rownames(self$meta_dt) <- self$meta_dt$SampleID
                                
                                # Create temporary data frame with peptide detections
                                temp <- rbind(
                                  rbind(cbind(`Peptide Detections` = colSums(raw == 0),
                                              SampleID = colnames(raw), class = "Zero"),
                                        cbind(`Peptide Detections` = colSums(raw != 0) - 
                                                colSums(raw == 0),
                                              SampleID = colnames(raw), class = "Non-zero"),
                                        cbind(`Peptide Detections` = colSums(raw == 0),
                                              SampleID = colnames(raw), class = "Experiment Level FDR"))
                                )
                                
                                # Merge temporary data with metadata
                                temp <- merge(temp, self$meta_dt[, c("SampleID", "Condition", 
                                                                     "Chris ID", "RunOrder")], 
                                              by = "SampleID")
                                
                                # Convert columns to appropriate data types
                                temp$`Peptide Detections` <- as.numeric(temp$`Peptide Detections`)
                                temp$SampleID <- factor(temp$SampleID)
                                temp$Condition <- factor(temp$Condition, 
                                                         levels = c("ADD", "HCN", "PDD", "PDCN", 
                                                                    "Quality Control", 
                                                                    "Reference Control"))
                                temp$SampleID <- gsub("CP0", "QC0", temp$SampleID)
                                self$meta_dt$SampleID <- gsub("CP0", "QC0", self$meta_dt$SampleID)
                                
                                # Assign wrangled data to the temp field
                                self$temp <- temp
                              }
                            )
)
