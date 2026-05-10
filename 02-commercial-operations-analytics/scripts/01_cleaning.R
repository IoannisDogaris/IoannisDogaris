library(dplyr)
library(lubridate)
library(readr)
library(here)

raw <- read_csv(here("06-commercial-operations-analytics/data/raw_sales.csv"),
                col_types = cols(
                  product     = col_character(),
                  region      = col_character(),
                  channel     = col_character(),
                  market_tier = col_character(),
                  date        = col_date(),
                  units       = col_double(),
                  price       = col_double(),
                  revenue     = col_double()
                ))

cleaned <- raw %>%
  mutate(
    year        = year(date),
    month       = month(date),
    quarter     = quarter(date),
    year_month  = format(date, "%Y-%m"),
    asp         = if_else(units > 0, revenue / units, NA_real_)
  )

write_csv(cleaned, here("06-commercial-operations-analytics/data/cleaned_sales.csv"))
