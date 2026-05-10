library(dplyr)
library(readr)
library(here)

sales <- read_csv(here("06-commercial-operations-analytics/data/cleaned_sales.csv"),
                  show_col_types = FALSE)

# Aggregate views for Excel pivots
by_product_region_month <- sales %>%
  group_by(product, region, year, month) %>%
  summarise(
    revenue = sum(revenue),
    units   = sum(units),
    .groups = "drop"
  )

by_channel <- sales %>%
  group_by(channel, year, month) %>%
  summarise(
    revenue = sum(revenue),
    units   = sum(units),
    .groups = "drop"
  )

dir.create("outputs", showWarnings = FALSE)

write_csv(by_product_region_month, here("06-commercial-operations-analytics/outputs/by_product_region_month.csv"))
write_csv(by_channel, here("06-commercial-operations-analytics/outputs/by_channel.csv"))
