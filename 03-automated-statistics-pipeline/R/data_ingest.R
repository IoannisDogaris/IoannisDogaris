# R/data_ingest.R
read_raw_data <- function(path) {
  read_csv(path, show_col_types = FALSE)
}