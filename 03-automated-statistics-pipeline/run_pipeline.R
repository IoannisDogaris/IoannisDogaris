# run_pipeline.R
library(targets)
library(tarchetypes)

message("Running targets pipeline...")
tar_make()
