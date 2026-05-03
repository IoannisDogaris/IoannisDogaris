library(dplyr)
library(readr)
library(ggplot2)
library(here)

sales <- read_csv(here("06-commercial-operations-analytics/data/cleaned_sales.csv"),
                  show_col_types = FALSE)

dir.create(here("06-commercial-operations-analytics/outputs/charts"), showWarnings = FALSE, recursive = TRUE)

# Revenue trends by product
revenue_trends <- sales %>%
  group_by(year_month, product) %>%
  summarise(revenue = sum(revenue), .groups = "drop")

ggplot(revenue_trends,
       aes(x = year_month, y = revenue, color = product, group = product)) +
  geom_line(size = 1) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Monthly Revenue by Product",
       x = "Year-Month",
       y = "Revenue") +
  scale_y_continuous(labels = scales::comma) -> p1

ggsave(here("06-commercial-operations-analytics/outputs/charts/revenue_trends.png"), p1, width = 8, height = 4)

# Product mix (total revenue share)
product_mix <- sales %>%
  group_by(product) %>%
  summarise(revenue = sum(revenue), .groups = "drop") %>%
  mutate(share = revenue / sum(revenue))

ggplot(product_mix,
       aes(x = reorder(product, -revenue), y = revenue, fill = product)) +
  geom_col(show.legend = FALSE) +
  theme_minimal() +
  labs(title = "Total Revenue by Product",
       x = "Product",
       y = "Revenue") +
  scale_y_continuous(labels = scales::comma) -> p2

ggsave(here("06-commercial-operations-analytics/outputs/charts/product_mix.png"), p2, width = 6, height = 4)

# Regional heatmap (revenue)
regional_heatmap <- sales %>%
  group_by(region, year) %>%
  summarise(revenue = sum(revenue), .groups = "drop")

ggplot(regional_heatmap,
       aes(x = factor(year), y = region, fill = revenue)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(labels = scales::comma) +
  theme_minimal() +
  labs(title = "Revenue by Region and Year",
       x = "Year",
       y = "Region",
       fill = "Revenue") -> p3

ggsave(here("06-commercial-operations-analytics/outputs/charts/regional_heatmap.png"), p3, width = 6, height = 4)

# Seasonality: average revenue by month
seasonality <- sales %>%
  group_by(month) %>%
  summarise(avg_revenue = mean(revenue), .groups = "drop")

ggplot(seasonality,
       aes(x = factor(month), y = avg_revenue, group = 1)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(title = "Average Revenue by Month",
       x = "Month",
       y = "Average Revenue") +
  scale_y_continuous(labels = scales::comma) -> p4

ggsave(here("06-commercial-operations-analytics/outputs/charts/seasonality.png"), p4, width = 6, height = 4)
