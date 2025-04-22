# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines a function to initialize and use the 
#              Fig6dGenerator class to process data and generate combined 
#              density and frequency distribution plots of CV for specified 
#              parameters, with options to save the plots as PNG or PDF files.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "MASS", "ggplot2", "cowplot", "plyr", "dplyr", "grDevices")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source required scripts and class definitions
source("main.r")
source("classes/Fig6dGenerator.R")

#' Generate and Print CV Plots
#'
#' This function initializes the Fig6dGenerator class and generates combined 
#' density and frequency distribution plots of CV for the specified parameter.
#'
#' @param parameter The parameter for filtering columns (e.g., "KP" or "CP").
#' @param save_png Logical value indicating whether to save the plot as a PNG file.
#' @param png_path The file path to save the PNG file.
#' @param save_pdf Logical value indicating whether to save the plot as a PDF file.
#' @param pdf_path The file path to save the PDF file.
#' @param use_cairo_pdf Logical value indicating whether to use the Cairo PDF device.
#'
#' @return A cowplot object combining the generated plots.
#' @export
generateCVPlots <- function(parameter, save_png = FALSE, png_path = NULL, 
                            save_pdf = FALSE, pdf_path = NULL, use_cairo_pdf = FALSE) {
  # Extract necessary data from the CompleteProcessor object
  df <- completeProcessor$getDat()
  df_imputed <- completeProcessor$getImputedData()
  df_median <- completeProcessor$getNormalizedData()
  meta_dt <- completeProcessor$getMetaDt()
  
  # Initialize and use the Fig6dGenerator class for the specified parameter
  plotGen <- Fig6dGenerator$new(df, df_imputed, df_median, meta_dt, parameter)
  fig6d_plot <- plotGen$generatePlots()
  
  # Print the plot
  print(fig6d_plot)
  
  # Optionally save plots to a PNG file
  if (save_png && !is.null(png_path)) {
    png(png_path, width = 11800, height = 5920, units = "px", res = 960)
    print(fig6d_plot)
    dev.off()
  }
  
  # Optionally save plots to a PDF file
  if (save_pdf && !is.null(pdf_path)) {
    if (use_cairo_pdf) {
      cairo_pdf(pdf_path, width = 12.29, height = 6.17)
      print(fig6d_plot)
      dev.off()
    } else {
      ggsave(pdf_path, plot = fig6d_plot, width = 12.29, height = 6.17, units = "in")
    }
  }
  
  # Return the plot
  return(fig6d_plot)
}

# Usage 
fig6d_KP <- generateCVPlots("KP", save_png = TRUE, png_path = "cv_assess_KP.png")
fig6d_CP <- generateCVPlots("CP", save_pdf = TRUE, pdf_path = "cv_assess_CP.pdf", use_cairo_pdf = TRUE)

