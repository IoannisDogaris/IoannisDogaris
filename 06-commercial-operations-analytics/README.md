# Commercial Operations Analytics

This project is a small case study where I explore a synthetic multi‑product sales dataset.  
The goal is simple: practice a realistic commercial analytics workflow using R, and build something that looks and feels like the kind of analysis a business or operations team might ask for.

It’s not tied to any specific industry - the structure is generic enough to apply to retail, pharma, consumer goods, etc. The focus is on understanding performance, spotting patterns, and producing something that could support decision‑making.

---

## What I Wanted to Explore
A few practical questions guided the analysis:

- Which products bring in the most revenue?
- How do different regions perform over time?
- Are there clear seasonal patterns?
- What’s growing, what’s slowing down, and what deserves attention?

---

## Dataset
The dataset is synthetic and generated in `scripts/00_generate_data.R`.  
It includes:

- product  
- region  
- channel  
- date  
- units sold  
- price  
- revenue  
- a few engineered fields (year, month, quarter, ASP)

The idea was to create something realistic enough to analyze without relying on external sources.

---

## How the Analysis Works
Everything is done in R:

- **Data cleaning** (tidyverse)
- **KPI engineering** (revenue, units, ASP, YoY growth)
- **Exploratory analysis**
- **Visualizations** (ggplot2)
- **Exports for Excel** (for pivot tables and a simple dashboard)

---

## Highlights & Observations
A few things that stood out during the analysis:

- One product consistently leads revenue across all regions.
- The South region underperforms compared to the others.
- There’s a noticeable seasonal bump in Q2 and Q4.
- A couple of products show a clear upward trend, while one is flattening out.

These aren’t “business recommendations” — just observations from the data.

---

## Visuals
Plots are saved in `outputs/charts/`:

- Revenue trends by product  
- Product mix  
- Regional heatmap  
- Seasonality curve  

They’re basic but useful for getting a quick sense of what’s going on.

---

## Files & Structure

data/
raw_sales.csv
cleaned_sales.csv

scripts/
00_generate_data.R
01_cleaning.R
02_eda_kpis.R
03_visualizations.R
04_export_for_excel.R

outputs/
charts/
dashboard.xlsx

---

## Possible Next Steps
A few things I might add later:

- Forecasting (ARIMA or Prophet)
- A small Shiny dashboard
- Segmentation (e.g., clustering regions or products)
- Price sensitivity analysis

This project is meant to be a foundation I can build on as I continue learning.
