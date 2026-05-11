# R/tables.R
make_tables <- function(df, descriptives) {

  main_table <- descriptives |>
    gt::gt() |>
    gt::tab_header(title = "")

  list(main_table = main_table)
}
