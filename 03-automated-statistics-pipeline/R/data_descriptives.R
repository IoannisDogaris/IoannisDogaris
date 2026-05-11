# R/data_descriptives.R
compute_descriptives <- function(df) {
  df |>
    summarise(
      n = n(),
      avg_unemployment = mean(unemployment_rate, na.rm = TRUE),
      avg_employment   = mean(employment_rate, na.rm = TRUE)
    )
}
