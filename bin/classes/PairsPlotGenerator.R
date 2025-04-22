# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the PairsPlotGenerator R6 class, which 
#              generates pairs plots for given samples.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "GGally", "ggplot2")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source required classes
source("classes/DensityPlotLayerGenerator.R")
source("classes/CorPlotLayerGenerator.R")

#' PairsPlotGenerator Class
#'
#' The PairsPlotGenerator class generates pairs plots for given samples.
#'
#' @field densityLayerGenerator An object of the DensityPlotLayerGenerator class.
#' @field corLayerGenerator An object of the CorPlotLayerGenerator class.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(densityLayerGenerator, corLayerGenerator)}}{
#'     Initializes the object with the required layer generators.
#'   }
#'   \item{\code{plotPairs(samples, diag="bar")}}{
#'     Generates the pairs plot for the given samples.
#'   }
#' }

PairsPlotGenerator <- R6Class("PairsPlotGenerator",
                              public = list(
                                densityLayerGenerator = NULL,  # Density plot layer generator object
                                corLayerGenerator = NULL,      # Correlation plot layer generator object
                                
                                #' Initialize the PairsPlotGenerator object
                                #'
                                #' @param densityLayerGenerator An object of the DensityPlotLayerGenerator class.
                                #' @param corLayerGenerator An object of the CorPlotLayerGenerator class.
                                #'
                                #' @return A new PairsPlotGenerator object.
                                initialize = function(densityLayerGenerator, corLayerGenerator) {
                                  self$densityLayerGenerator <- densityLayerGenerator
                                  self$corLayerGenerator <- corLayerGenerator
                                },
                                
                                #' Generate Pairs Plot
                                #'
                                #' This method generates the pairs plot for the given samples.
                                #'
                                #' @param samples Data frame containing the samples.
                                #' @param diag Type of plot for diagonal panels ("bar" or "density").
                                #'
                                #' @return A ggplot object for the pairs plot.
                                plotPairs = function(samples, diag = "bar") {
                                  diag <- ifelse(diag == "bar", "barDiag", "densityDiag")
                                  
                                  p <- ggpairs(samples, columns = order(colnames(samples)),
                                               lower = list(continuous = self$densityLayerGenerator$generateDensityPlot),
                                               diag = list(continuous = wrap(diag, fill = "gray60")), 
                                               upper = list(continuous = self$corLayerGenerator$generateCorPlotLayer)) + 
                                    theme(panel.background = element_rect(fill = "white")) +
                                    theme(axis.text.x = element_text(angle = 0, vjust = 1, color = "black")) + 
                                    theme(axis.text.y = element_text(angle = 0, vjust = 1, color = "black")) + 
                                    theme_bw()
                                  
                                  return(p)
                                }
                              )
)
