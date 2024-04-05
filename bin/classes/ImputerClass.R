# Load necessary libraries
library(R6)
library(pcaMethods)

# source external functions
source("functions/initializeMethod.R")
source("functions/imputeConditionMethod.R")

# define Imputer class
Imputer <- R6Class(
  "Imputer",
  public = list(
    metaDat = NULL,
    cutoff = 0.4,
    nipalsImpute = NULL,
    initialize = initializeMethod,
    imputeCondition = imputeConditionMethod
  )
)