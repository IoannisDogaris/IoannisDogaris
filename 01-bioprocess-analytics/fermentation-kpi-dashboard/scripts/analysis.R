library(tidyverse)

data <- read_csv("../data/simulated_fermentation_data.csv")

# Simple KPI calculations
kpis <- data %>%
  summarise(
    max_biomass = max(biomass_gL),
    min_glucose = min(glucose_gL),
    avg_do = mean(do_pct)
  )

print(kpis)

# Plot biomass over time
ggplot(data, aes(time_hr, biomass_gL)) +
  geom_line(color = "steelblue", size = 1.2) +
  theme_minimal() +
  labs(title = "Biomass Growth Over Time")
