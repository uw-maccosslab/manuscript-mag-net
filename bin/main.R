# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script sources necessary class definitions for data loading 
#              and normalization, orders the data, and initializes the required 
#              objects to process and normalize the data.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "data.table")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' Load and Normalize Data
#'
#' This script loads data using the DataWrangler class, orders the data, and 
#' normalizes it using the CompleteDataProcessor class. Optionally, the 
#' normalized data can be saved to a CSV file.
#'

# Source class definition responsible for initial data loading and wrangling
source("classes/DataWrangler.R")

# Source class definition focused on data normalization
source("classes/CompleteDataProcessor.R")  

# Define vector of identifiers used to order data
specified_order <- c("TPAD1010", "TPAD1016", "TPAD1022", "TPAD1008", "KP04", 
                     "TPAD1036", "CP04", "TPAD1040", "TPAD1021", "TPAD1012", 
                     "TPAD1037", "TPAD1025", "TPAD1013", "TPAD1035", "TPAD1018", 
                     "TPAD1007", "CP01", "TPAD1030", "TPAD1039", "KP03", 
                     "TPAD1028", "TPAD1005", "TPAD1004", "TPAD1017", "TPAD1001", 
                     "TPAD1011", "TPAD1026", "TPAD1032", "TPAD1019", "TPAD1033", 
                     "CP03", "TPAD1006", "KP02", "TPAD1024", "TPAD1002", 
                     "TPAD1038", "TPAD1031", "TPAD1034", "TPAD1015", "TPAD1027", 
                     "KP01", "TPAD1029", "TPAD1003", "TPAD1009", "TPAD1014", 
                     "TPAD1023", "CP02", "TPAD1020")

# Initialize DataWrangler object
# The DataWrangler class is used to load the data from the specified CSV files 
# and order it according to the specified identifiers.
wrangler <- DataWrangler$new("../csv/EV_ADPD_Protein_Total_Areas.csv",
                             "../csv/TPAD HCN_ADD_PDD_PDCN Plasma - Metadata.csv",
                             specified_order)

# Initialize CompleteDataProcessor object
# The CompleteDataProcessor class is used to normalize the data and remove 
# batch effects.
completeProcessor <- CompleteDataProcessor$new(wrangler$dat, wrangler$meta_dt)

# Optionally save the normalized data to a CSV file
# Change the condition to TRUE to save the normalized data.
if (FALSE) {
  write.csv(completeProcessor$batchEffectRemovedData, 
            file = "../csv/20230812-particlesADPD_pilot-batchadj-Prot.csv", 
            row.names = TRUE)
}
