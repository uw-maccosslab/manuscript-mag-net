removeControls <- function() {
  idx <- grep("Control", self$metaDt$Condition)
  if(length(idx) > 0) { # Check if there are any Control samples
    self$nobatchProt <- self$protGrp[,-idx]
    self$nobatchMeta <- self$metaDt[-idx,]
  }
}