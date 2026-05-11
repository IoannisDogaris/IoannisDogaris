# R/data_clean.R
clean_data <- function(df, params) {
  df |>
    filter(!is.na(unemployment_rate)) |>
    mutate(
      unemployment_rate = round(unemployment_rate, 1),
      employment_rate   = round(employment_rate, 1)
    )
}