# 📘 **Fermentation KPI Dashboard**  
*A bioprocess analytics project using R*

## 🧭 **Overview**
This project demonstrates how key fermentation performance indicators (KPIs) can be extracted, visualized, and reported using simulated bioprocess data. It showcases practical data‑science skills applied to real bioprocess engineering problems, including KPI calculation, trend visualization, and reproducible analysis workflows.

---

## 🎯 **Project Goals**
- Build a simple, reproducible R workflow for fermentation data analysis  
- Calculate essential KPIs (biomass growth, substrate consumption, DO trends)  
- Visualize process behavior over time  
- Produce clean, publication‑ready plots and summaries  
- Demonstrate how data analytics supports process monitoring and decision‑making  

---

## 📊 **Dataset**
The dataset is **simulated** to resemble fed‑batch fermentation data.

Variables include:
- `batch_id`  
- `time_hr`  
- `biomass_gL`  
- `glucose_gL`  
- `do_pct`  
- `ph`  
- `temp_C`

Data is stored in:  
```
/data/simulated_fermentation_data.csv
```

---

## 🛠 **Tools & Packages**
This project uses the following R packages:

- **tidyverse** — data wrangling and plotting  
- **readr** — CSV import  
- **ggplot2** — visualization  
- **dplyr** — KPI calculations  
- **scales** — formatting plots (optional)  
- **rmarkdown** — optional reporting  

---

## 📈 **Analyses & Outputs**
### **1. KPI Calculations**
- Maximum biomass  
- Minimum glucose  
- Average DO  
- pH stability  
- Temperature profile  

### **2. Visualizations**
- Biomass growth curve  
- Glucose consumption profile  
- DO trend over time  
- Combined multi‑panel process overview  

Plots are saved in:

```
/outputs/plots/
```

### **3. Optional RMarkdown Report**
A clean, reproducible report summarizing:
- KPIs  
- Plots  
- Interpretation  

Saved in:

```
/outputs/report/
```

---

## 📂 **Project Structure**
```
fermentation-kpi-dashboard/
│
├── data/
│   └── simulated_fermentation_data.csv
│
├── scripts/
│   └── analysis.R
│
├── outputs/
│   ├── plots/
│   └── report/
│
└── README.md
```

---

## 🧪 **How This Demonstrates Value to Biotech/GMP Employers**
This project highlights capabilities that are directly relevant to modern bioprocess and digitalization roles:

- **Process understanding** — KPIs reflect real fermentation performance metrics  
- **Data literacy** — ability to clean, analyze, and visualize process data  
- **Reproducibility** — structured scripts and clear folder organization  
- **Digital mindset** — demonstrates how analytics supports process monitoring  
- **Communication** — plots and summaries suitable for technical teams and management  

---

## 🚀 **Next Steps**
Future improvements may include:
- Automated KPI dashboards (Shiny)  
- Statistical process control (SPC) charts  
- Batch‑to‑batch comparison  
- Anomaly detection  
- Soft‑sensor development  
