#' @title Median Normalization
#' @description This function performs median normalization on the raw data.
#' @author Jea Park (jpark623@uw.edu)
#' @date 6/21/2024
#' @details The function calculates the median of each column in the raw data,
#'          then adjusts these medians by subtracting the overall median of 
#'          medians. The adjusted medians are used to normalize the raw data.
#'          The result is stored in the `dfMedian` field of the object.
#' @return None

normalizeMedian <- function() {
  # Calculate the median of each column in the raw data
  dfMed <- apply(as.matrix(self$dfRaw), 2, median, na.rm = TRUE)
  
  # Adjust medians by subtracting the overall median of medians
  dfMedLoc <- dfMed - median(dfMed)
  
  # Normalize the raw data using the adjusted medians
  self$dfMedian <- t(t(self$dfRaw) - dfMedLoc)
}
