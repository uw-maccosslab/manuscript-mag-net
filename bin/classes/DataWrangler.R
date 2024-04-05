# load packages
library(R6)
library(dplyr)

# define DataWrangler class
DataWrangler <- R6Class(
  "DataWrangler",
  public = list(
    dat = NULL,
    meta_dt = NULL,
    rnames = NULL,
    specified_order = NULL,
    
    initialize = function(dat_path, meta_dt_path, specified_order) {
      self$specified_order <- specified_order
      self$load_data(dat_path, meta_dt_path)
      self$transform_dat()
      self$extract_and_align()
      self$finalize_dat()
      self$order_data()
    },
    
    load_data = function(dat_path, meta_dt_path) {
      self$dat <- readr::read_csv(dat_path)
      self$meta_dt <- readr::read_csv(meta_dt_path) %>%
        dplyr::mutate(across(everything(), ~dplyr::na_if(.x, "na")))
      self$rnames <- self$dat$Protein
    },
    
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
    
    finalize_dat = function() {
      valid_indices <- match(self$meta_dt$Linkcode, sapply(stringr::str_split(colnames(self$dat), "_"), `[`, 2))
      self$dat <- self$dat[, valid_indices, drop = FALSE]
      colnames(self$dat) <- self$meta_dt$SampleID
      self$dat <- as.matrix(self$dat)
      rownames(self$dat) <- self$rnames
    },
    order_data = function() {
      # Order `meta.dt` rows by specified order
      self$meta_dt <- self$meta_dt %>%
        dplyr::filter(SampleID %in% self$specified_order) %>%
        dplyr::mutate(OrderIndex = match(SampleID, self$specified_order)) %>%
        dplyr::arrange(OrderIndex) %>%
        dplyr::select(-OrderIndex)
      
      self$dat <- self$dat[, self$specified_order]
    }
  )
)
