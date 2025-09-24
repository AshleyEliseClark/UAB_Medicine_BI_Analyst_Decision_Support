```
# 🏥 UAB Medicine – Daily Operations & Specialty Pharmacy Analytics

📊 [View ERD](docs/ERD.png)
---

## 📄 Project Summary

## 🗂 Data Model / ERD
The schema follows a **star design** with Calendar, Department, Service Line, Prescriber, and Payer as dimensions. Fact tables include Charges, OR, HVC, Inpatient Days, Infusion, ED Visits, and Specialty Pharmacy.  

**Tools:**PostgreSQL, Power BI (Power Query + DAX), SQL, Python (Codespaces/VS Code), GitHub, dbdiagram.io   
**Role:** BI Analyst with Data Engineering & Data Science tasks


Built a full-stack pipeline aligned to Medallion Architecture (Bronze → Silver → Gold) and CAP/INFORMS framework.
Designed PostgreSQL schema for UAB operations (Charges, OR, HVC, Inpatient Days, Infusion, ED, Specialty Pharmacy).
Developed SQL scripts and views for data profiling, KPI rollups, and executive summary aggregation.
Connected Power BI to Postgres schema (uab_ops) for clean Silver/Gold data layers.
Modeled relational schemas (Charges, OR, HVC, Inpatient Days, Infusion, ED Visits, Specialty Pharmacy).
Designed Power Query ETL flows for cleaning, normalizing, and joining 3 years of synthetic UAB-style data (2022–2025; Specialty Pharmacy 2023–2025).
Implemented DAX measures for KPIs (LOS, readmits, OR utilization, payer mix, specialty drug ROI).
Delivered two interactive Power BI dashboards:

- **Daily Operations:** Executive Summary, Charges, OR, HVC, Inpatient Days, Infusion, ED Visits
- **Specialty Pharmacy:** Overview, By Drug, By Service Line, By Prescriber

Extended project with Data Governance (quality checks, lineage, RLS) and Machine Learning (readmission prediction, ED visit forecasting, clustering of prescriber patterns) using Python.

---

## Key Business Questions

### Daily Operations
- How are charges and payer mix trending across departments?
- What is OR utilization and cancellation rate by service line?
- How do ED visits, admits %, LOS, and acuity vary over time?
- What are Inpatient LOS and readmission trends by service line?
- Which infusion drugs and clinics drive cost and revenue?

### Specialty Pharmacy
- Which specialty drugs (Humira, Stelara, Dupixent, Ozempic, Pluvicto, Ocrevus, Spinraza, Trikafta…) drive revenue and utilization?
- How does performance vary by service line (Gastro, Hem/Onc, CF, Rheum, Neuro, Derm, Pulm, Cardio, Transplant)?
- Which prescribers contribute most to patient volume and ROI?
- Are there seasonal patterns or payer differences affecting cost and access?

Folder Structure
UAB_BI_Dashboard/
├── data/                     # Synthetic datasets (2022–2025; SP 2023–2025)
├── sql/                      # PostgreSQL schema + queries
│   ├── 00_create_schema.sql      # Create tables, constraints, and relationships
│   ├── 01_load_data.sql          # Bulk COPY to load raw CSVs (Bronze layer ingestion)
│   ├── 02_profile_counts.sql     # Row counts & QA checks after data load
│   ├── 03_payer_mix.sql          # Exploratory payer mix query (before Silver views)
│   ├── 04_readmit_rate.sql       # Exploratory readmission rate query (before Silver views)
│   ├── 05_views.sql              # Silver layer business-ready views (exec_summary, dept_summary, ED, SP, payer)
│   └── 06_views_exec_summary.sql # Prototype/alternate exec summary rollup
│
├── powerqueries/             # NEW – Power Query M-code for Silver transformations
│   ├── Calendar_silver.m
│   ├── Charges_silver.m
│   ├── InpatientDays_silver.m
│   ├── EDVisits_silver.m
│   ├── HVC_silver.m
│   ├── OperatingRoom_silver.m
│   ├── Infusion_silver.m
│   └── SpecialtyPharmacy_silver.m
│
├── reports/                  # Power BI reports (.pbix)
├── dax_measures/             # All DAX measures KPI mesures for Gold layer
├── scripts/                  # Python scripts (governance + ML)
├── docs/                     # ERD, architecture, CAP framework, governance notes
├── dashboards/               # Screenshots of all dashboard pages
├── requirements.txt          # Python dependencies
└── README.md

---

## Data Architecture & Governance

### Medallion Approach
- **Bronze (Raw):** CSVs ingested into PostgreSQL (uab_ops schema) and stored in /data
- **Silver (Cleansed):** Power Query transformations (payer normalization, OR duration, ED admits flag, specialty drug mapping)
- **Gold (KPIs):** DAX measures for LOS, readmits, OR utilization, specialty ROI

### Data Governance Features
- **Data Quality:** Python scripts flag missing values, outliers, duplicates.
- **Lineage:** Documented transformations in `/docs/medallion_architecture.md`.
- **Security:** Row-Level Security (RLS) demo restricting service line access.
- **Compliance:** HIPAA principles simulated by removing PHI, keeping synthetic data only.

---

## Machine Learning (Python in Codespaces)
- Models pull cleaned features directly from PostgreSQL views before training in Python
- `data_quality_checks.py` → QA report of missing values, outliers, duplicates
- `readmission_model.py` → Logistic Regression & Random Forest predicting readmission risk from LOS, acuity
- `ed_forecast.py` → Prophet/ARIMA forecasting ED arrivals for next 6 months
- `specialty_clusters.py` → Clustering prescribers/patients by drug utilization


```

