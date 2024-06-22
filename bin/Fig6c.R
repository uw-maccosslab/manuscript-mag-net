# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script demonstrates the usage of the Fig6cGenerator class 
#              to generate pairs plots for given samples and metadata, and 
#              optionally save the plots to PNG and PDF files.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "GGally", "ggplot2", "RColorBrewer", "ggthemes")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source the Fig6cGenerator class
source("classes/Fig6cGenerator.R")

#' Generate Fig6c
#'
#' This function runs the Fig6cGenerator, generating and optionally 
#' saving the pairs plot.
#'
#' @param save_png Logical, whether to save the plot to a PNG file.
#' @param png_path The file path to save the PNG.
#' @param save_pdf Logical, whether to save the plot to a PDF file.
#' @param pdf_path The file path to save the PDF.
#' @param use_cairo_pdf Logical, whether to use Cairo PDF device.
#'
#' @return NULL
makeFig6c <- function(save_png = FALSE, png_path = NULL, 
                                     save_pdf = FALSE, pdf_path = NULL, 
                                     use_cairo_pdf = FALSE) {
  fig6c <- Fig6cGenerator$new()
  fig6c$generateAndSavePairsPlot(save_png = save_png, png_path = png_path, 
                                 save_pdf = save_pdf, pdf_path = pdf_path, 
                                 use_cairo_pdf = use_cairo_pdf)
}

# Usage
makeFig6c(save_png = TRUE, png_path = "pairs_plot.png", 
                         save_pdf = TRUE, pdf_path = "pairs_plot.pdf", 
                         use_cairo_pdf = TRUE)
