# R/plots.R
make_plots <- function(df, descriptives) {

  unemployment_plot <- df |>
    group_by(municipality) |>
    summarise(unemployment = mean(unemployment_rate)) |>
    ggplot(aes(x = unemployment, y = reorder(municipality, unemployment))) +
    geom_col() +
    labs(
      title = "Average Unemployment Rate by Municipality",
      x = "Unemployment (%)",
      y = "Municipality"
    )

  employment_plot <- df |>
    group_by(municipality) |>
    summarise(employment = mean(employment_rate)) |>
    ggplot(aes(x = employment, y = reorder(municipality, employment))) +
    geom_col() +
    labs(
      title = "Average Employment Rate by Municipality",
      x = "Employment (%)",
      y = "Municipality"
    )
  
  ggsave("reports/unemployment_plot.png", unemployment_plot, width = 8, height = 5)
  ggsave("reports/employment_plot.png", employment_plot, width = 8, height = 5)

  return(c(
  unemployment_plot = "unemployment_plot.png",
  employment_plot   = "employment_plot.png"
))

}