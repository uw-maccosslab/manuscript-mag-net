# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6cGenerator R6 class, which generates 
#              pairs plots for given samples and metadata.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "GGally", "ggplot2", "RColorBrewer", "ggthemes")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source required classes
source("classes/DensityPlotLayerGenerator.R")
source("classes/CorPlotLayerGenerator.R")
source("classes/PairsPlotGenerator.R")

# Source the main script
source("main.r")

#' Fig6cGenerator Class
#'
#' The Fig6cGenerator class processes the data and generates pairs plots for 
#' given samples and metadata.
#'
#' @field df A data frame containing the log2-transformed raw data.
#' @field meta_dt A data frame containing the metadata.
#' @field df_temp A data frame containing the complete cases of df.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize()}}{
#'     Initializes the object, processes the data, and prepares it for plotting.
#'   }
#'   \item{\code{generateAndSavePairsPlot(save_png = FALSE, png_path = NULL, 
#'   save_pdf = FALSE, pdf_path = NULL, use_cairo_pdf = FALSE)}}{
#'     Generates the pairs plot for the given samples and optionally saves it 
#'     to PNG or PDF.
#'   }
#' }

Fig6cGenerator <- R6Class("Fig6cGenerator",
                          public = list(
                            df = NULL,        # Log2-transformed raw data
                            meta_dt = NULL,   # Metadata
                            df_temp = NULL,   # Complete cases of df
                            
                            #' Initialize the Fig6cGenerator object
                            #'
                            #' @return A new Fig6cGenerator object.
                            initialize = function() {
                              self$df <- log2(completeProcessor$getDat())
                              self$df[self$df < 0] <- NA
                              colnames(self$df) <- gsub("CP", "QC", colnames(self$df))
                              self$meta_dt <- completeProcessor$getMetaDt()
                              self$df_temp <- self$df[complete.cases(self$df), ]
                            },
                            
                            #' Generate and Save Pairs Plot
                            #'
                            #' This method generates the pairs plot for the given samples and optionally 
                            #' saves it to PNG or PDF.
                            #'
                            #' @param save_png Logical, whether to save the plot to a PNG file.
                            #' @param png_path The file path to save the PNG.
                            #' @param save_pdf Logical, whether to save the plot to a PDF file.
                            #' @param pdf_path The file path to save the PDF.
                            #' @param use_cairo_pdf Logical, whether to use Cairo PDF device.
                            #'
                            #' @return NULL
                            generateAndSavePairsPlot = function(save_png = FALSE, png_path = NULL, 
                                                                save_pdf = FALSE, pdf_path = NULL, 
                                                                use_cairo_pdf = FALSE) {
                              samples <- self$df_temp[, grep("Quality", self$meta_dt$Condition)]
                              pairsPlotGenerator <- PairsPlotGenerator$new(DensityPlotLayerGenerator$new(), 
                                                                           CorPlotLayerGenerator$new())
                              pairs_plot <- pairsPlotGenerator$plotPairs(data.frame(samples))
                              
                              print(pairs_plot)
                              
                              # Optionally save plots to a PNG file
                              if (save_png && !is.null(png_path)) {
                                png(png_path, width = 11800, height = 5920, units = "px", res = 960)
                                print(pairs_plot)
                                dev.off()
                              }
                              
                              # Optionally save plots to a PDF file
                              if (save_pdf && !is.null(pdf_path)) {
                                if (use_cairo_pdf) {
                                  cairo_pdf(pdf_path, width = 12.29, height = 6.17)
                                  print(pairs_plot)
                                  dev.off()
                                } else {
                                  ggsave(pdf_path, plot = pairs_plot, width = 12.29, height = 6.17, 
                                         units = "in")
                                }
                              }
                            }
                          )
)
