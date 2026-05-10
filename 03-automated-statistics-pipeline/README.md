# Automated Statistics Pipeline: Labour Market Indicators for Youth

This project demonstrates a fully reproducible, automated statistics workflow in R.  
It includes:

- automated data ingestion
- data cleaning and recoding
- descriptive statistics
- tables (gt)
- visualisations (ggplot2)
- a reproducible workflow using `targets`
- bilingual reporting (English and Swedish) using Quarto

The project uses a synthetic dataset that mimics municipal‑level labour market indicators.  
All outputs are generated through the pipeline to ensure transparency and reproducibility.

## Structure

- `data/raw/` – input data (synthetic or open data)
- `data/processed/` – cleaned and derived datasets
- `R/` – modular R functions used by the pipeline
- `reports/` – English and Swedish Quarto reports
- `scripts/` – standalone scripts (e.g., synthetic data generation)
- `config/` – configuration files
- `_targets.R` – pipeline definition using the `targets` package
