#' @title Calculate Coefficient of Variation (CV)
#' @description This function calculates the coefficient of variation (CV) for 
#'              each row in a data frame.
#' @author Jea Park (jpark623@uw.edu)
#' @date 6/21/2024
#'
#' @param df A data frame where each row represents a different observation 
#'           and each column represents a different variable.
#'
#' @details The coefficient of variation (CV) is calculated as the standard 
#' deviation divided by the mean. This function applies this calculation to 
#' each row in the provided data frame.
#'
#' @return A numeric vector containing the CV for each row in the data frame.
#'         The length of the vector will be equal to the number of rows in the 
#'         input data frame.

getCV <- function(df) {
  # Internal function to calculate CV for a single vector
  calCV <- function(x) {
    (sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE))
  }
  # Apply the CV calculation to each row of the data frame
  cv <- apply(df, 1, function(x) calCV(x))
  return(cv)
}
