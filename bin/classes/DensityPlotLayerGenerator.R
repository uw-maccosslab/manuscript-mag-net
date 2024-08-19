# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the DensityPlotLayerGenerator R6 class, 
#              which generates a density plot layer for pairs plots.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "ggplot2")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' DensityPlotLayerGenerator Class
#'
#' The DensityPlotLayerGenerator class generates a density plot layer for pairs 
#' plots.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize()}}{
#'     Initializes the object.
#'   }
#'   \item{\code{generateDensityPlot(data, mapping)}}{
#'     Generates the density plot for lower panels.
#'   }
#' }

DensityPlotLayerGenerator <- R6Class("DensityPlotLayerGenerator",
                                     public = list(
                                       
                                       #' Initialize the DensityPlotLayerGenerator object
                                       #'
                                       #' @return A new DensityPlotLayerGenerator object.
                                       initialize = function() {
                                         # No initialization required for this class
                                       },
                                       
                                       #' Generate Density Plot for Lower Panels
                                       #'
                                       #' This method generates the density plot for the lower panels of the pairs 
                                       #' plot.
                                       #'
                                       #' @param data The data frame.
                                       #' @param mapping Aesthetic mappings.
                                       #'
                                       #' @return A ggplot layer.
                                       generateDensityPlot = function(data, mapping) {
                                         colfunc <- colorRampPalette(c("white", "#5e4fa2", "#3288bd", "#66c2a5", 
                                                                              "#abdda4", "#e6f598"))
                                                                              ggplot(data = data, mapping = mapping) + 
                                                                                geom_point(colour = "black", size = 0.5) +
                                                                                stat_density2d(aes(fill = ..density.., alpha = ..density..), 
                                                                                               geom = "tile", contour = F) +
                                                                                scale_fill_gradientn(colours = colfunc(100)) 
                                       }
                                     )
)
