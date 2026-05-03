library(dplyr)
library(readr)
library(here)

sales <- read_csv(here("06-commercial-operations-analytics/data/cleaned_sales.csv"),
                  show_col_types = FALSE)

# Product-level KPIs
product_kpis <- sales %>%
  group_by(product, year) %>%
  summarise(
    revenue      = sum(revenue),
    units        = sum(units),
    avg_price    = mean(price),
    .groups      = "drop"
  ) %>%
  group_by(product) %>%
  arrange(year) %>%
  mutate(
    revenue_lag = lag(revenue),
    yoy_growth  = (revenue - revenue_lag) / revenue_lag
  ) %>%
  ungroup()

# Region-level KPIs
region_kpis <- sales %>%
  group_by(region, year) %>%
  summarise(
    revenue = sum(revenue),
    units   = sum(units),
    .groups = "drop"
  )

# Monthly seasonality
monthly_kpis <- sales %>%
  group_by(month) %>%
  summarise(
    avg_revenue = mean(revenue),
    avg_units   = mean(units),
    .groups     = "drop"
  )

dir.create(here("06-commercial-operations-analytics/outputs"), showWarnings = FALSE)
write_csv(product_kpis, here("06-commercial-operations-analytics/outputs/product_kpis.csv"))
write_csv(region_kpis,  here("06-commercial-operations-analytics/outputs/region_kpis.csv"))
write_csv(monthly_kpis, here("06-commercial-operations-analytics/outputs/monthly_kpis.csv"))
