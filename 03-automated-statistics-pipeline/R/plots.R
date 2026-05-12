# R/plots.R

make_plots <- function(df) {
  # 1) Unemployment rate — distribution
  unemployment_plot <- df |>
    ggplot(aes(x = unemployment_rate)) +
    geom_histogram(
      bins = 30,
      fill = "skyblue",
      color = "white"
    ) +
    labs(
      title = "Distribution of Youth Unemployment Rates by Municipality",
      x = "Unemployment rate (%)",
      y = "Number of municipalities"
    ) +
    theme_minimal()

  # 2) Employment rate — boxplot
  employment_plot <- df |>
    ggplot(aes(x = factor(year), y = employment_rate)) +
    geom_boxplot(fill = "gray") +
    labs(
      title = "Municipal Distribution of Youth Employment Rates by Year",
      y = "Employment rate (%)",
      x = "Year"
    ) +
    theme_minimal()

  # Return plots
  return(list(
    unemployment = unemployment_plot,
    employment = employment_plot
  ))
}
