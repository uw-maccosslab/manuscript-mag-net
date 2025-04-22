# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script demonstrates the usage of the Fig6bGenerator class 
#              to process data from elib files, generate run-level FDR counts,
#              merge with metadata, and create a plot for run-level FDR 
#              peptide detections.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "ggplot2")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source the Fig6bGenerator class definition
source("classes/Fig6bGenerator.R")

#' Generate and Save Fig6b Plot
#'
#' This function creates and uses the Fig6bGenerator object to process data,
#' generate run-level FDR counts, merge with metadata, and create a plot for
#' peptide detections. The resulting plot can be optionally saved as a PNG or
#' PDF file.
#'
#' @param elib_path Path to the directory containing the elib files.
#' @param csv_output_path Output path for the run-level FDR count CSV.
#' @param csv_input_path1 Path to the input CSV file containing peptide total 
#'        areas.
#' @param csv_input_path2 Path to the input CSV file containing metadata.
#' @param save_png Logical indicating whether to save the plot as a PNG file.
#' @param png_path Path to save the PNG file.
#' @param save_pdf Logical indicating whether to save the plot as a PDF file.
#' @param pdf_path Path to save the PDF file.
#' 
#' @return Prints the plot to the console and optionally saves it to a file.
generate_fig6b_plot <- function(elib_path, csv_output_path, csv_input_path1, 
                                csv_input_path2, save_png = FALSE, 
                                png_path = "fig6b-adpd_ev-peptide_detection.png",
                                save_pdf = FALSE, 
                                pdf_path = "fig6b-adpd_ev-peptide_detection.pdf") {
  tryCatch({
    # Create and use the Fig6bGenerator object
    fig6b <- Fig6bGenerator$new(
      elib_path = elib_path,                          
      csv_output_path = csv_output_path,  
      csv_input_path1 = csv_input_path1,     
      csv_input_path2 = csv_input_path2
    )
    
    # Print the plot object
    print(fig6b$p0)
    
    # Optionally save plots to a PNG file
    if (save_png) {
      png(png_path, width = 11800, height = 5920, units = "px", res = 960)
      print(fig6b$p0)
      dev.off()
    }
    
    # Optionally save plots to a PDF file
    if (save_pdf) {
      ggsave(pdf_path, plot = fig6b$p0, width = 12.29, height = 6.17, units = "in")
    }
  }, error = function(e) {
    cat("An error occurred: ", e$message, "\n")
  })
}

# Usage
generate_fig6b_plot(
  elib_path = "../elibs", 
  csv_output_path = "../csv/Particles_ADPD-runLevelFDRCount.csv", 
  csv_input_path1 = "../csv/EV_ADPD_Peptide_Total_Areas.csv", 
  csv_input_path2 = "../csv/TPAD HCN_ADD_PDD_PDCN Plasma - Metadata.csv",
  save_png = F,
  save_pdf = F
)

