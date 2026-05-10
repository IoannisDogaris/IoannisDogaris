# ============================================================
# Script: generate_synthetic_data.R
# Purpose: Create a synthetic municipal-level labour market
#          dataset for youth (16–24) in Sweden.
# Output: data/raw/synthetic_labour_market.csv
# ============================================================

library(dplyr)
library(tidyr)
library(stringr)
library(readr)

set.seed(2026)  # reproducibility

# ------------------------------------------------------------
# 1. Define basic dimensions
# ------------------------------------------------------------

years <- 2018:2023

municipalities <- c(
  "Stockholm", "Göteborg", "Malmö", "Uppsala", "Västerås", "Örebro",
  "Linköping", "Helsingborg", "Jönköping", "Norrköping",
  # Add remaining municipalities programmatically
  paste0("Kommun_", 11:290)
)

sex <- c("Male", "Female")
age_groups <- c("16-19", "20-24")
education_levels <- c("Low", "Medium", "High")

# ------------------------------------------------------------
# 2. Create base grid
# ------------------------------------------------------------

df <- expand_grid(
  municipality = municipalities,
  year = years,
  sex = sex,
  age_group = age_groups
)

# expand_grid() constructs a complete rectangular dataset by
# generating all combinations of the supplied variables. 
# This is essential for reproducible statistical production 
# where full coverage across dimensions (e.g., municipality, 
# year, sex, age group) is required.

# ------------------------------------------------------------
# 3. Generate synthetic indicators
# ------------------------------------------------------------

# Base unemployment rate varies by municipality size
df <- df %>%
  mutate(
    # Population: larger in big cities, smaller elsewhere
    population = case_when(
      municipality == "Stockholm" ~ rpois(n(), 18000),
      municipality == "Göteborg"  ~ rpois(n(), 12000),
      municipality == "Malmö"     ~ rpois(n(), 10000),
      TRUE                        ~ rpois(n(), 1500)
    ),

    # Population counts are generated using a Poisson 
    # distribution, which is commonly used for non-negative 
    # integer count data. It provides realistic variation while
    # ensuring no negative values and a variance structure
    # appropriate for demographic counts.


    # Education distribution (youth)
    education_level = sample(
      education_levels,
      size = n(),
      replace = TRUE,
      prob = c(0.35, 0.45, 0.20)
    ),
    
    # Assign an education level to each row using weighted 
    # probabilities (Low 35%, Medium 45%, High 20%).

    # Unemployment rate influenced by education + randomness
    unemployment_rate = pmin(
      pmax(
        rnorm(
          n(),
          mean = case_when(
            education_level == "Low"    ~ 18,
            education_level == "Medium" ~ 12,
            education_level == "High"   ~ 8
          ),
          sd = 3
        ),
        3
      ),
      35
    ),

    # Generate unemployment rates based on education level 
    # with random variation, then clamp values to a realistic
    # range (3%–35%).

    # Employment rate inversely related to unemployment
    employment_rate = pmin(
      pmax(
        100 - unemployment_rate + rnorm(n(), mean = -5, sd = 2),
        40
      ),
      95
    )
  )

    # Generate employment rates inversely related to 
    # unemployment, add noise, and clamp to 40–95%.

# ------------------------------------------------------------
# 4. Final formatting
# ------------------------------------------------------------

df <- df %>%
  mutate(
    unemployment_rate = round(unemployment_rate, 1),
    employment_rate   = round(employment_rate, 1)
  ) %>%
  arrange(municipality, year, sex, age_group)

# ------------------------------------------------------------
# 5. Write output
# ------------------------------------------------------------

output_path <- "data/raw/synthetic_labour_market.csv"

# Ensure directory exists
dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)

write_csv(df, output_path)

message("Synthetic dataset written to: ", output_path)
