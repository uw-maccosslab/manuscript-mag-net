
# source class definition responsible for initial data loading and wrangling
source("classes/DataWrangler.R")

# source class definition focused on data normalization
source("classes/CompleteDataProcessor.R")  

# define vector of identifiers used to order data
specified_order <- c("TPAD1010", "TPAD1016", "TPAD1022", "TPAD1008", "KP04", "TPAD1036", 
                     "CP04", "TPAD1040", "TPAD1021", "TPAD1012", "TPAD1037", "TPAD1025", 
                     "TPAD1013", "TPAD1035", "TPAD1018", "TPAD1007", "CP01", "TPAD1030", 
                     "TPAD1039", "KP03", "TPAD1028", "TPAD1005", "TPAD1004", "TPAD1017", 
                     "TPAD1001", "TPAD1011", "TPAD1026", "TPAD1032", "TPAD1019", "TPAD1033", 
                     "CP03", "TPAD1006", "KP02", "TPAD1024", "TPAD1002", "TPAD1038", 
                     "TPAD1031", "TPAD1034", "TPAD1015", "TPAD1027", "KP01", "TPAD1029", 
                     "TPAD1003", "TPAD1009", "TPAD1014", "TPAD1023", "CP02", "TPAD1020")

# initialize DataWrangler object
wrangler <- DataWrangler$new("../csv/EV_ADPD_Protein_Total_Areas.csv",
                             "../csv/TPAD HCN_ADD_PDD_PDCN Plasma - Metadata.csv",
                             specified_order)


# initialize CompleteDataProcessor object
completeProcessor <- CompleteDataProcessor$new(wrangler$dat, wrangler$meta_dt)

# change to TRUE to save the normalized data to CSV file
if(F) {
  write.csv(completeProcessor$batchEffectRemovedData, 
            file = "../csv/20230812-particlesADPD_pilot-batchadj-Prot.csv", 
            row.names = TRUE)
}
