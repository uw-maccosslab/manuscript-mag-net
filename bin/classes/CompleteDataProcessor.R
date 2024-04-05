# load package
library(R6)

# source external R scripts
source("classes/DataNormalizerClass.R")
source("classes/ImputerClass.R")
source("classes/BatchEffectRemoverClass.R")

# define CompleteDataProcessor R6 class
CompleteDataProcessor <- R6Class("CompleteDataProcessor",
                                 public = list(
                                   dat = NULL,
                                   metaDt = NULL,
                                   normalizedData = NULL,
                                   imputedData = NULL,
                                   batchEffectRemovedData = NULL,
                                   
                                   initialize = function(dat, metaDt) {
                                     self$dat <- dat
                                     self$metaDt <- metaDt
                                     self$processData()
                                   },
                                   
                                   processData = function() {
                                     # Data normalization
                                     dataNormalizer <- DataNormalizer$new(self$dat)
                                     self$normalizedData <- dataNormalizer$dfMedian
                                     
                                     # Imputation
                                     imputerInstance <- Imputer$new(self$normalizedData)
                                     imputerInstance$metaDat <- self$metaDt
                                     self$imputedData <- imputerInstance$imputeCondition()
                                     
                                     # Batch effect removal
                                     batchEffectRemover <- BatchEffectRemover$new(self$imputedData, self$metaDt)
                                     batchEffectRemover$removeControls()
                                     batchEffectRemover$removeBatchEffect()
                                     self$batchEffectRemovedData <- batchEffectRemover$nobatchProt
                                   }
                                 )
)