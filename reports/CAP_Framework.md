# CAP Framework – UAB BI Dashboard

This project aligns with the CAP (Consistency, Availability, Partition Tolerance) framework to ensure robust analytics.

## Consistency
- Actuals and Budgets are validated against authoritative source systems (Finance extracts and Budget files).
- Service area measures (Charges, OR, Infusion, Inpatient, ED Visits, HVC) reconcile to official monthly totals before being published.
- All DAX measures are version-controlled in GitHub for auditability.

## Availability
- Dashboards are published in Power BI Service and refreshed daily.
- Scheduled refresh ensures leaders always have up-to-date Actual vs Budget performance.
- KPI cards and variance charts are always accessible in the Summary page, even if drill-down detail is delayed.

## Partition Tolerance
- Fact tables are partitioned by Year/Month, which allows queries to remain performant even if a particular partition is unavailable.
- Historical data remains accessible (e.g., 2022–2024) while current month data refreshes incrementally.
- Resilient against single-table refresh failures (one service area can still be queried independently).
