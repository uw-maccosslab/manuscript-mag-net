# load necessary packages
library(R6)

# source external functions
source("functions/handleZeros.R")
source("functions/handleNegative.R")
source("functions/applyLog2.R")
source("functions/normalizeMedian.R")
source("functions/setNegativeToNA.R")

# define DataNormalizer class
DataNormalizer <- R6Class("DataNormalizer",
                          public = list(
                            df = NULL,
                            dfRaw = NULL,
                            dfMedian = NULL,
                            
                            initialize = function(dat) {
                              self$df <- dat
                              self$handleZeros()
                              self$handleNegative()
                              self$applyLog2()
                              self$normalizeMedian()
                              self$setNegativeToNA()
                            },
                            
                            handleZeros = handleZeros,
                            handleNegative = handleNegative,
                            applyLog2 = applyLog2,
                            normalizeMedian = normalizeMedian,
                            setNegativeToNA = setNegativeToNA
                          )
)
