# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the Fig6dGenerator R6 class, which generates
#              plots for CV vs Log2 Abundance of Feature Median and Frequency 
#              Distribution of CV.

# Load necessary libraries
library(R6)
library(ggplot2)
library(cowplot)
library(plyr)
library(dplyr)

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "ggplot2", "cowplot", "plyr", "dplyr")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Source required scripts and class definitions
source("functions/getCV.r")

#' Fig6dGenerator Class
#'
#' The Fig6dGenerator class generates plots for CV vs Log2 Abundance of Feature 
#' Median and Frequency Distribution of CV.
#'
#' @field df A data frame containing the log2-transformed raw data.
#' @field df_imputed A data frame containing the imputed data.
#' @field df_median A data frame containing the median-normalized data.
#' @field meta_dt A data frame containing the metadata.
#' @field std_idx Indices of columns matching the parameter.
#' @field res123 Combined results data frame.
#' @field parameter Filtering parameter (e.g., "KP" or "CP").
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(df, df_imputed, df_median, meta_dt, parameter)}}{
#'     Initializes the object with data frames and a parameter.
#'   }
#'   \item{\code{processData()}}{
#'     Processes the data and creates the combined results data frame.
#'   }
#'   \item{\code{generatePlots()}}{
#'     Generates and returns the combined plot (CV vs Log2 Abundance of Feature 
#'     Median and Frequency Distribution of CV).
#'   }
#' }

Fig6dGenerator <- R6Class("Fig6dGenerator",
                          public = list(
                            # Public fields
                            df = NULL,           # Log2-transformed raw data
                            df_imputed = NULL,   # Imputed data
                            df_median = NULL,    # Median-normalized data
                            meta_dt = NULL,      # Metadata
                            std_idx = NULL,      # Indices of columns matching the parameter
                            res123 = NULL,       # Combined results data frame
                            parameter = NULL,    # Filtering parameter (e.g., "KP" or "CP")
                            
                            #' Initialize the Fig6dGenerator object
                            #'
                            #' @param df The raw data frame.
                            #' @param df_imputed The imputed data frame.
                            #' @param df_median The median-normalized data frame.
                            #' @param meta_dt The metadata data frame.
                            #' @param parameter The parameter for filtering columns (e.g., "KP" or "CP").
                            #' 
                            #' @return A new Fig6dGenerator object.
                            initialize = function(df, df_imputed, df_median, meta_dt, parameter) {
                              self$df <- log2(df)
                              self$df_imputed <- df_imputed
                              self$df_median <- df_median
                              self$meta_dt <- meta_dt
                              self$parameter <- parameter
                              self$std_idx <- grep(parameter, colnames(self$df))
                              self$processData()
                            },
                            
                            #' Process Data
                            #'
                            #' This method processes the data and creates the combined results data 
                            #' frame for figure generation.
                            #'
                            #' @return NULL
                            processData = function() {
                              # Process raw data
                              res1 <- as.data.frame(cbind(
                                `Log2 Median` = as.numeric(apply(self$df[, self$std_idx], 1, median, na.rm = TRUE)),
                                CV = getCV(as.matrix(2^self$df[, self$std_idx])),
                                method = rep("Raw", nrow(self$df))
                              ))
                              
                              # Process median-normalized data
                              res2 <- as.data.frame(cbind(
                                `Log2 Median` = as.numeric(apply(self$df_median[, self$std_idx], 1, median, na.rm = TRUE)),
                                CV = getCV(as.matrix(2^self$df_median[, self$std_idx])),
                                method = rep("Median Norm", nrow(self$df_median))
                              ))
                              
                              # Process imputed data
                              res3 <- as.data.frame(cbind(
                                `Log2 Median` = as.numeric(apply(self$df_imputed[, self$std_idx], 1, median, na.rm = TRUE)),
                                CV = getCV(as.matrix(2^self$df_imputed[, self$std_idx])),
                                method = rep("Imputation", nrow(self$df_imputed))
                              ))
                              
                              # Combine results
                              self$res123 <- rbind(res1, res2, res3)
                              self$res123$`Log2 Median` <- as.numeric(self$res123$`Log2 Median`)
                              self$res123$CV <- as.numeric(self$res123$CV)
                              self$res123$method <- factor(self$res123$method, levels = c("Raw", "Median Norm", "Imputation"))
                            },
                            
                            #' Generate and Return Combined Plots
                            #'
                            #' This method generates and returns the combined plot (CV vs Log2 Abundance 
                            #' of Feature Median and Frequency Distribution of CV).
                            #'
                            #' @return A cowplot object combining the generated plots.
                            generatePlots = function() {
                              # Common theme for the plots
                              commonTheme <- list(
                                labs(color = "Density", fill = "Density",
                                     x = "Log2 Median",
                                     y = "CV",
                                     title = 'CV vs Log2 Abundance of Feature Median'),
                                theme_bw(),
                                theme(legend.position = c(0.995, 0.995),
                                      legend.justification = c(0.995, 0.995))
                              )
                              
                              # Generate the density plot
                              p1 <- ggplot(data = self$res123, 
                                           aes(`Log2 Median`, CV)) + 
                                geom_point(shape = 16, size = 0.1, 
                                           color = "grey66", show.legend = FALSE) +
                                stat_density2d(aes(fill = ..level.., alpha = ..level..), 
                                               geom = 'polygon', colour = 'black') + 
                                scale_fill_continuous(low = "green", high = "red") +
                                geom_smooth(method = "loess", linetype = 2, 
                                            colour = "red", se = FALSE) + 
                                guides(alpha = "none") + facet_grid(method ~ ., 
                                                                    scales = "free_x") + 
                                commonTheme +  
                                theme(legend.title = element_text(size = 6.5), 
                                      legend.text = element_text(size = 6), 
                                      legend.key.size = unit(0.3, 'cm'))
                              
                              # Calculate group means for the frequency distribution plot
                              mu <- ddply(self$res123, "method", summarise, 
                                          grp.mean = mean(CV, na.rm = TRUE))
                              mu <- mu %>% mutate(Label = prettyNum(round(grp.mean, 4)))
                              
                              # Generate the frequency distribution plot
                              p2 <- ggplot(data = self$res123, aes(x = CV)) +
                                geom_histogram(color = "black", fill = "white") +
                                facet_grid(method ~ .) + geom_vline(data = mu,
                                                                    aes(xintercept = grp.mean, 
                                                                        color = "red"),
                                                                    linetype = "dashed") +
                                geom_text(
                                  data = mu,
                                  aes(
                                    x = grp.mean,
                                    y = 500,
                                    id = method,
                                    label = paste0("\u03bc=", Label)
                                  ),
                                  family = "Georgia",
                                  size = 3,
                                  hjust = -0.1
                                ) +
                                theme_bw() + ylab("Frequency") + 
                                labs(title = 'Frequency Distribution of CV') +
                                theme(legend.position = "none")
                              
                              # Combine plots
                              plot_row <- plot_grid(
                                p1, p2, 
                                ncol = 2,
                                label_fontfamily = 'serif',
                                label_fontface = 'bold',
                                align = 'V',
                                rel_widths = c(1, 1)
                              )
                              
                              return(plot_row)
                            }
                          )
)
