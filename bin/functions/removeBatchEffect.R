#' @title Remove Batch Effect
#' @description This function removes batch effects from the normalized protein 
#'              data using the `removeBatchEffect` function from the limma package.
#' @author Jea Park (jpark623@uw.edu)
#' @date 6/21/2024
#'
#' @details This function removes batch effects from the data stored in the 
#'          `nobatchProt` field of the object. It uses the `removeBatchEffect` 
#'          function from the limma package, specifying the design matrix and 
#'          the batch variable. If `nobatchProt` is not initialized or control 
#'          samples have not been removed, the function will stop with an error message.
#'
#' @return Updates the `nobatchProt` field of the object with the batch effect 
#'         removed data.
#'
#' @importFrom limma

removeBatchEffect <- function() {
  if (!is.null(self$nobatchProt)) {
    self$nobatchProt <- limma::removeBatchEffect(
      self$nobatchProt, 
      design = model.matrix(~Condition, data = self$nobatchMeta), 
      batch = self$nobatchMeta$Cohort
    )
  } else {
    stop("Data has not been initialized or control samples have not been removed.")
  }
}
