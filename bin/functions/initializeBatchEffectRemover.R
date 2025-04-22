#' @title Initialize Batch Effect Remover
#' @description This function initializes the BatchEffectRemover object with 
#'              imputed data and metadata.
#' @author Jea Park
#' @date 6/21/2024
#' @details The function sets up the BatchEffectRemover object by assigning the 
#'          provided imputed data and metadata to the corresponding fields. It 
#'          also prepares the data by converting zeros to NAs, ensuring that 
#'          batch effect removal processes work correctly.
#' @param imputedData A data frame containing the imputed data.
#' @param metaDt A data frame containing the metadata.
#' @return None

initializeBatchEffectRemover <- function(imputedData, metaDt) {
  # Assign the provided imputed data and metadata to the object fields
  self$imputedData <- imputedData
  self$metaDt <- metaDt
  
  # Prepare the protein group data
  self$protGrp <- imputedData
  self$protGrp[self$protGrp == 0] <- NA
  
  # Initialize the no-batch metadata and protein data
  self$nobatchMeta <- self$metaDt
  self$nobatchProt <- self$protGrp
}
