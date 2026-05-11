# _targets.R
# Reproducible pipeline for the Automated Statistics Pipeline project

library(targets)
library(tarchetypes)

# ------------------------------------------------------------
# 1. Set target options
# ------------------------------------------------------------

tar_option_set(
  packages = c(
    "dplyr",
    "tidyr",
    "readr",
    "ggplot2",
    "gt",
    "yaml",
    "quarto"
  ),
  format = "rds"
)

# ------------------------------------------------------------
# 2. Source R functions
# ------------------------------------------------------------

purrr::walk(
  list.files("R", pattern = "\\.R$", full.names = TRUE),
  source
)

# ------------------------------------------------------------
# 3. Targets
# ------------------------------------------------------------

list(
  # Configuration / parameters
  tar_target(
    config_file,
    "config/parameters.yml",
    format = "file"
  ),

  tar_target(
    params,
    yaml::read_yaml(config_file)
  ),

  # Raw data
  tar_target(
    raw_data_file,
    "data/raw/synthetic_labour_market.csv",
    format = "file"
  ),

  tar_target(
    raw_data,
    read_raw_data(raw_data_file)
  ),

  # Cleaned data
  tar_target(
    cleaned_data,
    clean_data(raw_data, params)
  ),

  tar_target(
  processed_data_file,
  {
    readr::write_csv(cleaned_data, "data/processed/processed_data.csv")
    "data/processed/processed_data.csv"
  },
  format = "file"
  ),

  # Descriptive statistics
  tar_target(
    descriptives,
    compute_descriptives(cleaned_data)
  ),

  # Tables
  tar_target(
  tables,
  {
    tbl <- make_tables(cleaned_data, descriptives)$main_table
    list(
      main_table_html = gt::as_raw_html(tbl)
    )
  }
  ),

  # Plots
  tar_target(
    plots,
    make_plots(cleaned_data, descriptives),
    format = "file"
  ),

  # English report
  tar_target(
    report_en,
    {
      quarto_render(
        input = "reports/report_en.qmd",
        execute_params = list(
          data = cleaned_data,
          descriptives = descriptives,
          tables = tables,
          plots = plots
        )
      )
      "reports/report_en.html"
    },
    format = "file"
  ),

  # Swedish report
  tar_target(
    report_sv,
    {
      quarto_render(
        input = "reports/report_sv.qmd",
        execute_params = list(
          data = cleaned_data,
          descriptives = descriptives,
          tables = tables,
          plots = plots
        )
      )
      "reports/report_sv.html"
    },
    format = "file"
  )
)