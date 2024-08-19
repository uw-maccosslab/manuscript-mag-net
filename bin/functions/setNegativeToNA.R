#' @title Set Negative Values to NA
#' @description This function replaces all negative values in the `dfMedian` 
#'              data frame with NA.
#' @author Jea Park (jpark623@uw.edu)
#' @date 6/21/2024
#'
#' @details This method iterates over the `dfMedian` data frame and sets all 
#' negative values to NA. This can be useful in data preprocessing steps where 
#' negative values are not meaningful or indicative of missing data.
#'
#' @return NULL

setNegativeToNA <- function() {
  self$dfMedian[self$dfMedian < 0] <- NA
}
