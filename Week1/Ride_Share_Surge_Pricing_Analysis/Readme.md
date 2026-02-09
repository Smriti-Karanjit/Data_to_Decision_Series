[![GitHub stars](https://img.shields.io/github/stars/smritikaranjit/ride-surge-analysis?style=social)](https://github.com/Smriti-Karanjit/Data_to_Decision_Series/Ride_Share_Surge_Pricing_Analysis)
[![Surge Peak](https://img.shields.io/badge/Surge%20Peak-3.8%25-orange)](images/surge_by_hour.png)
[![Rain Impact](https://img.shields.io/badge/Rain%20Lift-%2B0.1%25-gray)](images/surge_rain.png)

# Ride-Share Surge Pricing Analysis  
**Data → Decision Series | Week 1 – Case 2**

---

## Objective
Does **time-of-day demand** or **weather events** better explain ride-share surge pricing?  
This project analyzes Uber & Lyft trip estimates merged with hourly weather records to quantify **temporal vs environmental drivers of surge probability.**

---

## In 1 Chart
![Surge Probability by Hour](images/surge_by_hour.png)

**Answer: Time > Weather.**  
Surge peaks at **3.8% (Hour 14)** vs **3.0% baseline**.  
Rain impact: **+0.1% lift** *(visually identical bars — statistically negligible).*

---

## Dataset
- **Cab Trips:** Uber & Lyft simulated ride estimates (high-frequency)
- **Weather:** Hourly meteorological attributes (temperature, humidity, wind, rain, clouds)
- **Coverage:** ~3 weeks of data, single metropolitan area
- **Merge Key:** Hour-bucketed timestamp (`ts_hour`) + pickup location

---

## Methodology

### Data Cleaning
- Removed rides with missing price values  
- Dropped unused identifiers (`id`, `product_id`)  
- Converted UNIX timestamps to datetime (ms → trips, s → weather)  
- Filled sparse rain values and created boolean **`is_raining`** flag  

### Data Alignment
- Weather is hourly; trip data is higher frequency  
- Both datasets aligned using **hour-level buckets** before merging  

### Feature Engineering
- **Time:** hour of day, weekday, weekend flag, peak commute flag  
- **Context:** rain indicator, temperature buckets, distance buckets  
- **Derived:** surge probability (`surge_multiplier > 1`)

---

## Key Questions
- Does **hour of day** influence surge likelihood?
- Does **rain or weather** significantly increase surge probability?
- Are **weekends** meaningfully different from weekdays?
- Which **locations** show higher cost vs surge risk patterns?

---

## Key Findings
- Surge events occur in **~3–4% of rides** *(rare but high-impact)*  
- **Hour 14 peak:** **~3.8%** vs **~3.0% baseline**  
- **Rain effect:** **+0.1%** surge probability *(minimal impact)*  
- **Weekday stability:** standard deviation ≈ **0.2%** across days  
- **Temporal demand cycles** are more consistent than basic weather indicators

---

## Visual Evidence
Primary visuals (see `/images`):
- **Surge Probability by Hour (%)** — trend detection  
- **Rain vs No Rain (%)** — direct factor comparison  
- **Surge Probability by Weekday (%)** — behavioral context  
- **Location Cost vs Surge Risk Scatter** — pricing vs surge trade-off  

---

## Multivariate Exploration
- **Location × Hour Heatmaps:** identify micro-peaks by pickup zone  
- **Distance × Vehicle Heatmaps:** reveal pricing gradients by trip length and vehicle class  
- **Platform Comparison:** Uber vs Lyft average price and surge likelihood

---

## Feature Influence (Price Perspective)
A Random Forest regression model was trained to evaluate **price drivers** *(not surge drivers).*  
This section demonstrates feature impact on **ride price**, complementing the surge-probability analysis.

> *Future extension:* train a **classification model** for `is_surge` to directly measure surge predictors.

---

## Limitations
- Short time window (~3 weeks)  
- Single-city scope  
- No explicit event or holiday indicators  
- Findings reflect **directional patterns**, not full seasonal trends

---

## Future Improvements
- Multi-city comparison and longer horizons  
- Event and holiday feature integration  
- **Surge classification model** with AUC/F1 metrics  
- SHAP/interpretability for transparent feature impact

---

## Tech Stack
- **Python:** Pandas, NumPy  
- **Visualization:** Matplotlib, Seaborn  
- **Modeling:** Scikit-Learn  
- **Environment:** Jupyter / Databricks

---

## Repository Structure

📁 /data            → Raw CSVs (anonymized samples: `trips.csv`, `weather.csv`)  
📁 /notebooks       → `01_cleaning.ipynb` | `02_eda.ipynb` | `03_modeling.ipynb`  
📁 /images          → README visuals + additional charts  
📁 /sql             → Data preparation queries (merges, CTEs)  
📁 /src             → Feature engineering / helper functions  
📄 requirements.txt → `pip install -r requirements.txt`  
📄 environment.yml  → Databricks-compatible environment  
📄 README.md        → Project overview (this file)

---

## How to Run
```bash
pip install -r requirements.txt
jupyter notebook
