# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the CorPlotLayerGenerator R6 class, which 
#              generates a correlation plot layer for pairs plots.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "ggplot2", "rlang")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' CorPlotLayerGenerator Class
#'
#' The CorPlotLayerGenerator class generates a correlation plot layer for pairs 
#' plots.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize()}}{
#'     Initializes the object.
#'   }
#'   \item{\code{generateCorPlotLayer(data, mapping, method="pearson", 
#'   ndp=6, sz=5, stars=TRUE)}}{
#'     Computes correlation and generates a ggplot layer for upper panels.
#'   }
#' }

CorPlotLayerGenerator <- R6Class("CorPlotLayerGenerator",
                                 public = list(
                                   
                                   #' Initialize the CorPlotLayerGenerator object
                                   #'
                                   #' @return A new CorPlotLayerGenerator object.
                                   initialize = function() {
                                     # No initialization required for this class
                                   },
                                   
                                   #' Compute Correlation and Generate Upper Panel Plot
                                   #'
                                   #' This method computes the correlation and generates a ggplot layer for 
                                   #' the upper panels of the pairs plot.
                                   #'
                                   #' @param data The data frame.
                                   #' @param mapping Aesthetic mappings.
                                   #' @param method Correlation method (default is "pearson").
                                   #' @param ndp Number of decimal places (default is 6).
                                   #' @param sz Text size (default is 5).
                                   #' @param stars Logical, whether to add stars to the plot (default is TRUE).
                                   #'
                                   #' @return A ggplot layer.
                                   generateCorPlotLayer = function(data, mapping, method = "pearson", ndp = 6, 
                                                                   sz = 5, stars = TRUE) {
                                     x <- rlang::eval_tidy(mapping$x, data)
                                     y <- rlang::eval_tidy(mapping$y, data)
                                     
                                     corr <- cor.test(x, y, method = method)
                                     est <- corr$estimate
                                     lb.size <- sz 
                                     
                                     if (stars) {
                                       stars <- c("***", "**", "*", "")[findInterval(corr$p.value, 
                                                                                     c(0, 0.001, 0.01, 0.05, 
                                                                                       1))]
                                       lbl <- paste0(round(est, ndp), stars)
                                     } else {
                                       lbl <- round(est, ndp)
                                     }
                                     
                                     ggplot(data = data, mapping = mapping) +
                                       annotate("text", x = mean(x, na.rm = TRUE), y = mean(y, na.rm = TRUE), 
                                                label = lbl, size = lb.size)
                                   }
                                 )
)
