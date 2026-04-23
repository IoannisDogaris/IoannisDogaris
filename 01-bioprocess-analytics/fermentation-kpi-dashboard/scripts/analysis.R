library(tidyverse)

# Load data
data <- read_csv("../data/simulated_fermentation_data.csv")

# ---- KPI CALCULATIONS ----
kpis <- data %>%
  summarise(
    max_biomass = max(biomass_gL),
    min_glucose = min(glucose_gL),
    avg_do = mean(do_pct),
    final_pH = last(ph)
  )

print("Fermentation KPIs:")
print(kpis)

# ---- PLOTS ----

# Biomass growth curve
p1 <- ggplot(data, aes(time_hr, biomass_gL)) +
  geom_line(color = "steelblue", size = 1.2) +
  theme_minimal() +
  labs(title = "Biomass Growth Over Time",
       x = "Time (hr)",
       y = "Biomass (g/L)")

ggsave("../outputs/plots/biomass_growth.png", p1, width = 7, height = 4)

# Glucose consumption
p2 <- ggplot(data, aes(time_hr, glucose_gL)) +
  geom_line(color = "firebrick", size = 1.2) +
  theme_minimal() +
  labs(title = "Glucose Consumption Over Time",
       x = "Time (hr)",
       y = "Glucose (g/L)")

ggsave("../outputs/plots/glucose_consumption.png", p2, width = 7, height = 4)

# DO profile
p3 <- ggplot(data, aes(time_hr, do_pct)) +
  geom_line(color = "darkgreen", size = 1.2) +
  theme_minimal() +
  labs(title = "Dissolved Oxygen Profile",
       x = "Time (hr)",
       y = "DO (%)")

ggsave("../outputs/plots/do_profile.png", p3, width = 7, height = 4)
