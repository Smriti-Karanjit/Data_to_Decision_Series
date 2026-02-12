# 🏥 Appointment No-Show Risk & Recovery Simulator  
**From Raw Healthcare Data → Decision-Ready Analytics (Databricks Lakehouse)**
## 🎯 Objective
Build an end-to-end analytics pipeline that:

- Cleans and validates healthcare appointment data  
- Engineers patient-history and behavioral features  
- Produces transparent risk scoring (rule-based)  
- Estimates expected revenue at risk per appointment  
- Simulates expected recovered revenue using SMS reminder lift assumptions  
- Generates decision-ready outputs for dashboards and operations teams
## 🧱 Lakehouse Architecture

### Bronze – Raw Ingestion
- Raw appointment dataset
- Minimal transformation
- Data quality logging
- Goal: Preserve raw truth

### Silver – Clean & Feature Engineering
- Type casting, null handling, normalization
- Patient history features:
  - Previous appointments
  - Previous no-show rate
  - Lead time days
  - Weekend indicator
  - Senior indicator

### Gold – Decision Layer
- Transparent rule-based risk scoring
- Risk segmentation (Low / Medium / High)
- Expected revenue at risk
- Scenario simulator (SQL View)
- Dashboard-ready outputs
## 📊 Key Outcomes
### 1. Volume vs Severity
- ~90K low-risk appointments (~11% no-show probability)
- ~19K medium-risk (~33% probability)
- **923 high-risk (~1% volume) with ~56% probability**

**Insight:** A very small fraction carries disproportionate risk — ideal reminder targets.
### 2. Efficiency — Expected Recovery per Outreach
| Risk Band | Expected Recovery |
|--------|----------------|
| High   | ~$55–60 |
| Medium | ~$20 |
| Low    | ~$3 |

**Insight:** High-risk outreach yields highest individual return.
### 3. Scale — Total Expected Recovery
| Risk Band | Total Expected Recovery |
|--------|----------------------|
| Medium | ~$390K |
| Low    | ~$246K |
| High   | ~$51K |

**Insight:** Medium-risk segments drive the largest aggregate opportunity.
## 🔍 Methodology

### Risk Score (Explainable)
A bounded rule-based score using:
- Long lead time
- Previous no-show rate
- Weekend appointment
- Senior indicator

This is **not an ML probability**, but a transparent operational prioritization score.
### Scenario Simulator
SQL View: `gold.v_fact_noshow_simulator`

Lift assumptions:
- High → 20%
- Medium → 12%
- Low → 5%

Expected recovered revenue = expected_revenue_at_risk × lift

The base Gold table remains unchanged — pure scenario experimentation layer.
## 🛠 Tech Stack
- Databricks SQL
- Delta Lake
- PySpark (minimal)
- SQL Window Functions
- Lakehouse Architecture
- Power BI / Databricks Visuals
- Git / GitHub
## 📈 Visualizations Produced
- Risk Distribution — Volume vs Severity
- Expected Recovery per Outreach
- Total Expected Recovery by Risk Band
- Optional:
  - Monthly recovery trend
  - High-risk operational queue
  - Neighbourhood opportunity heatmap
## 🚀 Future Enhancements
- Replace rule score with calibrated ML model
- Add SMS delivery success data
- Real billing / claim revenue
- Automated job scheduling
- Real-time dashboards
## 🧠 Skills Demonstrated
- Lakehouse Architecture  
- SQL Feature Engineering  
- Scenario Simulation  
- Data Quality Gates  
- Decision Analytics  
- Visualization & Storytelling  
## Author
**Smriti Karanjit**  
Data Science | Analytics Engineering | Databricks | SQL | ML
