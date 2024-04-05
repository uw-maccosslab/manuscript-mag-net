initializeBatchEffectRemover <- function(imputedData, metaDt) {
  self$imputedData <- imputedData
  self$metaDt <- metaDt
  self$protGrp <- imputedData
  self$protGrp[self$protGrp == 0] <- NA
  self$nobatchMeta <- self$metaDt
  self$nobatchProt <- self$protGrp
}