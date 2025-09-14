# UAB Medicine – Business Intelligence / Decision Support Simulation

## Objective
Simulate BI deliverables created at UAB Medicine to demonstrate structured BI workflows using Snowflake, SQL, Python, Power Query, DAX, and Power BI.

## Use Cases
- Daily Operations Dashboard: charges, OR utilization, ED visits, inpatient days.
- Specialty Pharmacy Dashboard: utilization, costs, outcomes of specialty drugs.

## Tech Stack
- Snowflake for structured data storage
- Python for ETL + forecasting
- SQL for schema & KPIs
- Power Query for shaping data
- DAX for calculations
- Power BI for dashboards

UAB_BI_DecisionSupport/
├── data/                # Dummy CSVs (charges, OR, HVC, ED, infusion, etc.)
├── sql/                 # Snowflake schema + queries
├── python_etl/          # Python ETL + forecasting
├── power_query/         # Power Query M scripts
├── dax_measures/        # DAX measures
├── dashboards/          # Power BI pbix files + screenshots
└── README.md
