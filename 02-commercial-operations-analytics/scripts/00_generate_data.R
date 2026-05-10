set.seed(123)

library(dplyr)
library(lubridate)
library(here)

# Parameters
n_months   <- 36
start_date <- as.Date("2022-01-01")
products   <- c("Product A", "Product B", "Product C", "Product D")
regions    <- c("North", "South", "East", "West")
channels   <- c("Retail", "Online", "Wholesale")

dates <- seq.Date(from = start_date,
                  by   = "month",
                  length.out = n_months)

base_df <- expand.grid(
  date    = dates,
  product = products,
  region  = regions,
  channel = channels,
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)

# Simple market tiers by region
market_tier_map <- c("North" = "A", "East" = "B", "West" = "B", "South" = "C")

# Product base demand
product_base_units <- c("Product A" = 1200,
                        "Product B" = 900,
                        "Product C" = 700,
                        "Product D" = 500)

# Region multipliers
region_mult <- c("North" = 1.2,
                 "East"  = 1.0,
                 "West"  = 0.9,
                 "South" = 0.7)

# Channel multipliers
channel_mult <- c("Retail"    = 1.0,
                  "Online"    = 0.8,
                  "Wholesale" = 1.3)

# Price per product (constant for simplicity)
product_price <- c("Product A" = 50,
                   "Product B" = 40,
                   "Product C" = 35,
                   "Product D" = 30)

# Seasonality: bump in Q2 and Q4
seasonality_factor <- function(d) {
  m <- month(d)
  if (m %in% c(4, 5, 6))  return(1.15)  # Q2
  if (m %in% c(10,11,12)) return(1.10)  # Q4
  return(1.00)
}

# Trend: slow growth over time
trend_factor <- function(d) {
  months_since_start <- as.numeric(d - start_date) / 30
  1 + 0.003 * months_since_start
}

raw_sales <- base_df %>%
  rowwise() %>%
  mutate(
    market_tier = market_tier_map[region],
    base_units  = product_base_units[product],
    units_mean  = base_units *
                  region_mult[region] *
                  channel_mult[channel] *
                  seasonality_factor(date) *
                  trend_factor(date),
    units       = round(rlnorm(1, meanlog = log(units_mean), sdlog = 0.25)),
    price       = product_price[product] * runif(1, 0.95, 1.05),
    revenue     = units * price
  ) %>%
  ungroup() %>%
  select(product, region, channel, market_tier, date, units, price, revenue)

dir.create(here("06-commercial-operations-analytics/data"), showWarnings = FALSE, recursive = TRUE)
write.csv(raw_sales, here("06-commercial-operations-analytics/data/raw_sales.csv"), row.names = FALSE)
