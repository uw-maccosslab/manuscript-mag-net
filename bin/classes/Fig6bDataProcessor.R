# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6bDataProcessor R6 class, 
#              which processes data and metadata for Fig6b figure generation.

# Ensure the required packages are installed and loaded
required_packages <- c("R6")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' Fig6bDataProcessor Class
#'
#' The Fig6bDataProcessor class processes data and metadata for Fig6b figure generation.
#'
#' @field dat A data frame containing the input data.
#' @field meta_dt A data frame containing the metadata.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(dat, meta_dt)}}{
#'     Initializes the object with input data and metadata, then processes them.
#'   }
#'   \item{\code{processData()}}{
#'     Processes the input data and metadata for figure generation.
#'   }
#' }

Fig6bDataProcessor <- R6Class("Fig6bDataProcessor",
                              public = list(
                                dat = NULL,
                                meta_dt = NULL,
                                
                                #' Initialize the Fig6bDataProcessor object
                                #'
                                #' @param dat A data frame containing the input data.
                                #' @param meta_dt A data frame containing the metadata.
                                #' 
                                #' @return A new Fig6bDataProcessor object.
                                initialize = function(dat, meta_dt) {
                                  self$dat <- dat
                                  self$meta_dt <- meta_dt
                                  self$processData()
                                },
                                
                                #' Process Data and Metadata
                                #'
                                #' This method processes the input data and metadata for figure generation.
                                #'
                                #' @return NULL
                                processData = function() {
                                  # Generate row names for the data
                                  rnames <- paste0(self$dat$`Peptide Modified Sequence`, "@", 
                                                   self$dat$Protein)
                                  
                                  # Remove unnecessary columns from the data
                                  self$dat <- self$dat[,-c(1:6)]
                                  
                                  # Rename columns by removing "Normalized Area"
                                  colnames(self$dat) <- gsub(" Normalized Area", "", colnames(self$dat))
                                  
                                  # Process batch columns
                                  temp.idx <- grep("Batch", colnames(self$dat))
                                  dat.sub.id <- colnames(self$dat[, temp.idx])
                                  dat.sub.id <- paste0(sapply(strsplit(dat.sub.id, "_"), "[", 1), "_",
                                                       sapply(strsplit(dat.sub.id, "_"), "[", 2), "_",
                                                       "XX_",
                                                       sapply(strsplit(dat.sub.id, "_"), "[", 3))
                                  colnames(self$dat)[temp.idx] <- dat.sub.id
                                  
                                  # Generate sample IDs and other columns
                                  SampleID <- paste0(sapply(strsplit(colnames(self$dat), "_"), "[", 1), 
                                                     "-", sapply(strsplit(colnames(self$dat), "_"), "[", 2))
                                  Linkcode <- sapply(strsplit(colnames(self$dat), "_"), "[", 2)
                                  WellNo <- sapply(strsplit(colnames(self$dat), "_"), "[", 3)
                                  RunOrder <- sapply(strsplit(colnames(self$dat), "_"), "[", 4)
                                  
                                  # Process metadata
                                  self$meta_dt$Linkcode[is.na(self$meta_dt$Linkcode)] <- 
                                    self$meta_dt$SampleID[is.na(self$meta_dt$Linkcode)]
                                  self$meta_dt$Condition[grep("KP", self$meta_dt$SampleID)] <- 
                                    "Reference Control"
                                  self$meta_dt$Condition[grep("CP", self$meta_dt$SampleID)] <- 
                                    "Quality Control"
                                  self$meta_dt$RunOrder <- RunOrder[match(self$meta_dt$Linkcode, Linkcode)]
                                  self$meta_dt <- self$meta_dt[order(self$meta_dt$RunOrder), ]
                                  colnames(self$meta_dt)[grep("KF", colnames(self$meta_dt))] <- "WellNo"
                                  self$meta_dt$WellRow <- gsub("[[:digit:]]", "", self$meta_dt$WellNo)
                                  self$meta_dt$WellCol <- gsub("[^[:digit:]]", "", self$meta_dt$WellNo)
                                  self$meta_dt$Condition <- gsub("-", "", self$meta_dt$Condition)
                                  self$meta_dt <- self$meta_dt[,-grep("Tube|Label|Volume|X11", 
                                                                      colnames(self$meta_dt))]
                                  
                                  # Match and process data columns
                                  self$dat <- self$dat[,match(self$meta_dt$Linkcode, 
                                                              sapply(strsplit(colnames(self$dat), "_"), 
                                                                     "[", 2))]
                                  colnames(self$dat) <- self$meta_dt$SampleID
                                  self$dat <- as.matrix(self$dat)
                                  rownames(self$dat) <- rnames
                                  
                                  # Convert specific columns to numeric and factor
                                  idx <- which(colnames(self$meta_dt) %in% c("Poston_Plasma_ID", "Age", 
                                                                             "isMale", "Education", 
                                                                             "Run Order", "plasma ptau"))
                                  self$meta_dt[, idx] <- apply(self$meta_dt[, idx], 2, as.numeric)
                                  self$meta_dt[,-idx] <- apply(self$meta_dt[,-idx], 2, as.factor)
                                  
                                  # Update column names
                                  colnames(self$dat) <- gsub("CP0", "QC0", colnames(self$dat))
                                  self$meta_dt$SampleID <- gsub("CP0", "QC0", self$meta_dt$SampleID)
                                }
                              )
)
