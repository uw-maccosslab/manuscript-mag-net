# Author: Jea Park
# Date: 6/21/2024
# Description: This script defines the Fig6bCreatePlot R6 class, which creates
#              a plot for peptide detections based on the provided data.

# Load necessary libraries
required_packages <- c("R6", "ggplot2")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' Fig6bCreatePlot Class
#'
#' The Fig6bCreatePlot class creates a plot for peptide detections based on the
#' provided data.
#'
#' @field temp A data frame containing the temporary data for processing.
#' @field metaDT A data frame containing the metadata.
#' @field p0 A ggplot object for visualizing peptide detections.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(temp, metaDT)}}{
#'     Initializes the object with data and creates the plot.
#'   }
#'   \item{\code{createPlot()}}{
#'     Creates a ggplot object for peptide detections.
#'   }
#' }

Fig6bCreatePlot <- R6Class("Fig6bCreatePlot",
                           public = list(
                             temp = NULL,
                             metaDT = NULL,
                             p0 = NULL,
                             
                             #' Initialize the Fig6bCreatePlot object
                             #'
                             #' @param temp A data frame containing the temporary data for processing.
                             #' @param metaDT A data frame containing the metadata.
                             #' 
                             #' @return A new Fig6bCreatePlot object.
                             initialize = function(temp, metaDT) {
                               self$temp <- temp
                               self$metaDT <- metaDT
                               self$createPlot()
                             },
                             
                             #' Create Plot for Peptide Detections
                             #'
                             #' This method creates a ggplot object for visualizing peptide detections.
                             #'
                             #' @return A ggplot object for visualizing peptide detections.
                             createPlot = function() {
                               self$p0 <- ggplot2::ggplot(data = self$temp, 
                                                          aes(x = SampleID, 
                                                              y = `Peptide Detections`, 
                                                              fill = `class`)) +
                                 geom_bar(stat = "identity") +
                                 facet_grid(~Condition, scales = "free") +
                                 scale_fill_grey(start = 0.8, end = 0.2) +
                                 theme_bw() +
                                 theme(axis.text.x = element_text(size = rel(0.7), 
                                                                  angle = 45, hjust = 1),
                                       legend.title = element_blank(),
                                       legend.position = "right",
                                       legend.spacing.y = unit(-0.2, "cm"))
                               
                               self$metaDT <- self$metaDT[match(unique(self$temp$SampleID), 
                                                                self$metaDT$SampleID), ]
                               errbar <- cbind(self$metaDT$RunLevelCount, 'NA', 'NA')
                               errbar <- as.numeric(t(errbar))
                               
                               self$p0 <- self$p0 + geom_errorbar(aes(y = errbar,
                                                                      ymin = errbar,
                                                                      ymax = errbar, 
                                                                      col = "Run Level FDR"),
                                                                  linetype = 1, size = 1)
                             }
                           )
)
