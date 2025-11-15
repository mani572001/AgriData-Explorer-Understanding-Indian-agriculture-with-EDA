# AgriData Explorer 🌾  
_Exploratory Data Analysis & Visualization of Indian Agricultural Data_

## 📌 Project Overview

Indian agriculture is huge, but the data around it is messy, scattered, and hard to use.  
This project builds an **end-to-end data analysis and visualization solution** for Indian crop production, yield, and cultivated area using:

- **Python** – data cleaning & EDA  
- **SQL (MySQL)** – querying and analysis  
- **Power BI** – dashboards and reporting  

The goal is to make it easier for **farmers, policymakers, and researchers** to explore trends, spot regional disparities, and make data-driven decisions.

---

## 🎯 Objectives

- Clean and structure raw agricultural data (state & district level)
- Perform **EDA** on crop production, yield, and area
- Answer key **business questions** using **SQL**
- Build **interactive Power BI dashboards** for:
  - Crop production trends  
  - Yield comparisons  
  - Area cultivated by crop/state/district  

---

## 🧠 Business Use Cases

### 👨‍🌾 Farmers
- Identify which crops perform better in their region over time  
- Compare yields and decide **what to plant and when**

### 🏛️ Policymakers
- Detect **low-productivity regions** and allocate subsidies/resources  
- Understand **yield volatility** to design better crop insurance policies  

### 🔬 Researchers
- Study the impact of **climate / irrigation / soil** indirectly through production and yield trends  
- Identify **high-potential crops/regions** for further innovation  

---

## 📂 Dataset

- **Source**: ICRISAT – District Level Data (India)  
- **Link**: `https://docs.google.com/spreadsheets/d/1PHf2rFB53qUu7j8-r4qcHQdrhvxOyiyhyMWIY-nb_m8/edit?gid=321359364#gid=321359364`

### Key Columns

- `Year`  
- `State Name`, `State Code`  
- `Dist Name`, `Dist Code`  

### Crop Fields (examples)

- `RICE AREA (1000 ha)`  
- `RICE PRODUCTION (1000 tons)`  
- `RICE YIELD (Kg per ha)`  
- `WHEAT AREA (1000 ha)`  
- `WHEAT PRODUCTION (1000 tons)`  
- `WHEAT YIELD (Kg per ha)`  
- `OILSEEDS AREA (1000 ha)`  
- `OILSEEDS PRODUCTION (1000 tons)`  
- `OILSEEDS YIELD (Kg per ha)`  
- `SUGARCANE AREA / PRODUCTION / YIELD`  
- `COTTON AREA / PRODUCTION / YIELD`  
- Other crops: Sorghum, Maize, Groundnut, Sunflower, Soybean, Pulses, Fruits, Vegetables, etc.

---

## 🛠️ Tech Stack

- **Language**: Python  
- **Data Analysis**: pandas, numpy, matplotlib / seaborn / plotly (as used)  
- **Database**: MySQL  
- **Visualization**: Power BI  
- **Other**: SQLAlchemy / MySQL Connector (if used), Power Query in Power BI  

---

## 📊 Exploratory Data Analysis (EDA)

Some of the main EDA tasks implemented:

- **Top 7 Rice Producing States** (bar plot)  
- **Top 5 Wheat Producing States** + % share (bar + pie chart)  
- **Top 7 Sunflower Producing States**  
- **Oilseed production by top 5 states**  
- **India's Sugarcane production over last 50 years** (line plot)  
- **Rice vs Wheat production (last 50 years)**  
- **Rice production by West Bengal districts**  
- **Top 10 Wheat production years from Uttar Pradesh**  
- **Millet production trends (last 50 years)**  
- **Sorghum (Kharif vs Rabi) by region**  
- **Top 7 states for Groundnut production**  
- **Soybean production & yield efficiency (top 5 states)**  
- **Oilseed production in major states**  
- **Impact of area cultivated on production (Rice, Wheat, Maize)**  
- **Rice vs Wheat yield across states**

> 🔧 If any of these are not implemented yet in your notebook, either add them or remove them from this list. Don’t lie in your README; whoever reviews it will notice.

---

## 🧾 SQL – Questions Answered

The project also uses **MySQL** to answer analytical questions like:

1. **Year-wise trend of rice production** across **top 3 states**  
2. **Top 5 districts** by **wheat yield increase** over the last **5 years**  
3. **States with the highest growth** in **oilseed production** (5-year growth rate)  
4. **District-wise correlation** between **area and production** for Rice, Wheat, and Maize  
5. **Yearly production growth of cotton** in top 5 cotton producing states  
6. **Districts with the highest groundnut production** in 2020  
7. **Annual average maize yield** across all states  
8. **Total area cultivated for oilseeds** in each state  
9. **Districts with the highest rice yield**  
10. **Compare wheat vs rice production** for top 5 states over 10 years  

> All SQL queries are available in:  
> `sql/queries.sql`  
> (Rename this path if yours is different.)

---

## 📈 Power BI Dashboards

The Power BI report includes:

- **Geographical maps** – crop production / yield by state & district  
- **Trend charts (line)** – production & yield over years  
- **Bar/column charts** – state/district level comparisons  
- **Scatter plots** – relationship between area and production (e.g. Rice, Wheat, Maize)  
- **KPIs & Cards** – total area, total production, avg yield  

Interactive features:

- Slicers for:
  - Year  
  - State / District  
  - Crop type  
- Cross-filtering: click on a state → update other visuals  

> Power BI file: `powerbi/AgriData_Explorer.pbix`

---

## 🧱 Project Structure

> Update this to match your repo. Right now this is a **sensible default**.

```bash
.
├── data/
│   ├── raw/
│   │   └── icrisat_district_level.csv
│   └── processed/
│       └── agriculture_cleaned.csv
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   ├── 02_eda_visualizations.ipynb
│   └── 03_sql_exploration.ipynb
├── sql/
│   └── queries.sql
├── powerbi/
│   └── AgriData_Explorer.pbix
├── src/
│   └── utils/...
├── README.md
└── requirements.txt
