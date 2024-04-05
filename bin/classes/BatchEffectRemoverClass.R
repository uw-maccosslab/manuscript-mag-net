# load packages
library(R6)  
library(limma)  

# source external R scripts
source("functions/initializeBatchEffectRemover.R")  # function to initialize the BatchEffectRemover object
source("functions/removeControls.R")  # function to remove control samples from the dataset
source("functions/removeBatchEffect.R")  # function to perform batch effect removal from the dataset

# define BatchEffectRemover R6 class
BatchEffectRemover <- R6Class("BatchEffectRemover",
                              public = list(
                                imputedData = NULL,  
                                metaDt = NULL,  
                                protGrp = NULL,  
                                nobatchMeta = NULL,  
                                nobatchProt = NULL,  
                                initialize = initializeBatchEffectRemover,
                                removeControls = removeControls,
                                removeBatchEffect = removeBatchEffect
                              )
)
