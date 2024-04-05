removeBatchEffect <- function() {
  if (!is.null(self$nobatchProt)) {
    self$nobatchProt <- limma::removeBatchEffect(self$nobatchProt, design=model.matrix(~Condition, data=self$nobatchMeta), batch=self$nobatchMeta$Cohort)
  } else {
    stop("Data has not been initialized or control samples have not been removed.")
  }
}