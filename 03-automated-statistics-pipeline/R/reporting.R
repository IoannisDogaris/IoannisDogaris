# R/reporting.R
render_report <- function(input, params) {
  quarto::quarto_render(
    input = input,
    execute_params = params,
    output_dir = "reports"
  )
}
