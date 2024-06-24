# Author: Jea Park (jpark623@uw.edu)
# Date: 6/21/2024
# Description: This script defines the DataWrangler class, which handles 
#              data loading, transformation, and alignment for further processing.

# Ensure the required packages are installed and loaded
required_packages <- c("R6", "dplyr", "stringr", "readr", "purrr")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

#' DataWrangler Class
#'
#' The DataWrangler class handles data loading, transformation, and alignment 
#' for further processing.
#'
#' @field dat A data frame containing the loaded data.
#' @field meta_dt A data frame containing the metadata.
#' @field rnames A vector containing the row names (protein names) of the data.
#' @field specified_order A vector of identifiers used to order the data.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{initialize(dat_path, meta_dt_path, specified_order)}}{
#'     Initializes the object, loads data, transforms data, aligns metadata, 
#'     finalizes data, and orders data.
#'   }
#'   \item{\code{load_data(dat_path, meta_dt_path)}}{
#'     Loads data from specified paths.
#'   }
#'   \item{\code{transform_dat()}}{
#'     Transforms the loaded data.
#'   }
#'   \item{\code{extract_and_align()}}{
#'     Extracts relevant parts and aligns the metadata.
#'   }
#'   \item{\code{finalize_dat()}}{
#'     Finalizes the data by aligning column names and converting to matrix.
#'   }
#'   \item{\code{order_data()}}{
#'     Orders the data according to the specified order.
#'   }
#' }

DataWrangler <- R6Class(
  "DataWrangler",
  public = list(
    dat = NULL,          # Data frame for loaded data
    meta_dt = NULL,      # Data frame for metadata
    rnames = NULL,       # Vector for row names (protein names)
    specified_order = NULL, # Vector for specified order of identifiers
    
    #' Initialize the DataWrangler object
    #'
    #' @param dat_path Path to the data file.
    #' @param meta_dt_path Path to the metadata file.
    #' @param specified_order Vector of identifiers used to order the data.
    #'
    #' @return A new DataWrangler object.
    initialize = function(dat_path, meta_dt_path, specified_order) {
      self$specified_order <- specified_order
      self$load_data(dat_path, meta_dt_path)
      self$transform_dat()
      self$extract_and_align()
      self$finalize_dat()
      self$order_data()
    },
    
    #' Load Data
    #'
    #' This method loads data from the specified paths.
    #'
    #' @param dat_path Path to the data file.
    #' @param meta_dt_path Path to the metadata file.
    #'
    #' @return NULL
    load_data = function(dat_path, meta_dt_path) {
      self$dat <- readr::read_csv(dat_path)
      self$meta_dt <- readr::read_csv(meta_dt_path) %>%
        dplyr::mutate(across(everything(), ~dplyr::na_if(.x, "na")))
      self$rnames <- self$dat$Protein
    },
    
    #' Transform Data
    #'
    #' This method transforms the loaded data by renaming columns and handling 
    #' batch-specific columns.
    #'
    #' @return NULL
    transform_dat = function() {
      self$dat <- self$dat %>%
        dplyr::select(-c(1:3)) %>%
        dplyr::rename_with(~stringr::str_replace_all(.x, " Sum Normalized Area", "")) %>%
        dplyr::rename_with(~{
          batch_idx <- stringr::str_detect(.x, "Batch")
          new_names <- .x[batch_idx] %>%
            stringr::str_split("_") %>%
            purrr::map_chr(~stringr::str_c(.x[1], .x[2], "XX", .x[3], sep = "_"))
          .x[batch_idx] <- new_names
          .x
        }, .cols = everything())
    },
    
    #' Extract and Align Metadata
    #'
    #' This method extracts relevant parts of the column names and aligns the 
    #' metadata accordingly.
    #'
    #' @return NULL
    extract_and_align = function() {
      col_parts <- stringr::str_split(colnames(self$dat), "_")
      
      linkcode <- purrr::map_chr(col_parts, ~.x[2])
      
      self$meta_dt <- self$meta_dt %>%
        dplyr::mutate(Linkcode = dplyr::if_else(is.na(Linkcode), SampleID, Linkcode),
                      Condition = dplyr::case_when(
                        stringr::str_detect(SampleID, "KP") ~ "Reference Control",
                        stringr::str_detect(SampleID, "CP") ~ "Quality Control",
                        TRUE ~ Condition),
                      Condition = stringr::str_remove_all(Condition, "-")) %>%
        dplyr::select(-dplyr::matches("Tube|Label|Volume|X11"))
    },
    
    #' Finalize Data
    #'
    #' This method finalizes the data by aligning column names with metadata 
    #' and converting the data frame to a matrix.
    #'
    #' @return NULL
    finalize_dat = function() {
      valid_indices <- match(self$meta_dt$Linkcode, sapply(stringr::str_split(colnames(self$dat), "_"), `[`, 2))
      self$dat <- self$dat[, valid_indices, drop = FALSE]
      colnames(self$dat) <- self$meta_dt$SampleID
      self$dat <- as.matrix(self$dat)
      rownames(self$dat) <- self$rnames
    },
    
    #' Order Data
    #'
    #' This method orders the data according to the specified order of identifiers.
    #'
    #' @return NULL
    order_data = function() {
      self$meta_dt <- self$meta_dt %>%
        dplyr::filter(SampleID %in% self$specified_order) %>%
        dplyr::mutate(OrderIndex = match(SampleID, self$specified_order)) %>%
        dplyr::arrange(OrderIndex) %>%
        dplyr::select(-OrderIndex)
      
      self$dat <- self$dat[, self$specified_order]
    }
  )
)
