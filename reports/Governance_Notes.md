# Data Governance Notes – UAB BI Dashboard

The UAB BI Dashboard is designed with governance best practices for healthcare financial analytics.

## Refresh Cadence
- **Daily** refresh for operational data (Charges, OR Cases, Infusion, ED Visits).
- **Monthly** refresh for Budget extracts.
- Incremental refresh applied to large-volume fact tables for performance.

## Security & Access
- Row-level security can be applied by Service Area or Department to restrict access.
- Finance leadership has global access; department managers see only their respective service area dashboards.

## Change Control
- All DAX measures exported and version-controlled in GitHub.
- Changes to Summary Page or Specialty Pharmacy dashboards documented via pull requests.
- Naming conventions enforced (e.g., `[Actual_Service]`, `[Budget_Service]`).

## Data Quality & Validation
- Variance thresholds flagged: > ±10% deviation requires explanation from department leads.
- % of Budget > 200% triggers automated QA review.
- Cross-check between Budget and Actuals at month-end close for consistency.

## Audit & Compliance
- GitHub history serves as an audit trail for DAX logic changes.
- ERD and Data Architecture diagrams stored in `/docs/` for transparency.
- CAP Framework alignment documented to meet data governance standards.
