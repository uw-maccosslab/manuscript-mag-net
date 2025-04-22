#' @title Remove Control Samples
#' @description This function removes control samples from the dataset.
#' @author Jea Park
#' @date 6/21/2024
#' @details The function identifies control samples in the metadata based on 
#'          the condition and removes the corresponding entries from both the 
#'          protein data and the metadata. This is useful for excluding control 
#'          samples from subsequent analysis.
#' @return None

removeControls <- function() {
  # Identify control samples in the metadata
  idx <- grep("Control", self$metaDt$Condition)
  
  # Check if there are any control samples and remove them
  if(length(idx) > 0) {
    self$nobatchProt <- self$protGrp[,-idx]
    self$nobatchMeta <- self$metaDt[-idx,]
  }
}
