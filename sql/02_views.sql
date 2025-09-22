-- =========================================
-- UAB BI Project - Silver Layer Views
-- File: 02_views.sql
-- =========================================

-- 1. Executive Summary View
CREATE OR REPLACE VIEW uab_ops.exec_summary AS
SELECT 
	c.Year,
	c.Month,
	SUM(ch.Charge_Amount) AS Total_Charges,
	COUNT(DISTINCT orr.Case_ID) AS OR_Cases,
	AVG(h.LOS_Days) AS Avg_HVC_LOS,
	ROUND(SUM(ip.Readmit_Flag)::decimal / NULLIF(COUNT(ip.Admission_ID),0), 3) AS Inpatient_Readmit_Rate,
	ROUND(SUM(ed.Admit_Flag)::decimal / NULLIF(COUNT(ed.Visit_ID),0), 3) AS ED_Admit_Rate,
	SUM(sp.Revenue) AS Specialty_Revenue
FROM uab_ops.calendar c
LEFT JOIN uab_ops.charges ch ON c.Date = ch.Date
LEFT JOIN uab_ops.operating_room orr ON c.Date = orr.Date
LEFT JOIN uab_ops.hvc h ON c.Date = h.Date
LEFT JOIN uab_ops.inpatient_days ip ON c.Date = ip.Discharge_Date
LEFT JOIN uab_ops.ed_visits ed ON c.Date = ed.Date
LEFT JOIN uab_ops.specialty_pharmacy sp ON c.Date = sp.Date
GROUP BY c.Year, c.Month
ORDER BY c.Year, c.Month;

-- 2. Department Rollup View
CREATE OR REPLACE VIEW uab_ops.dept_summary AS
SELECT 
	ip.Department,
	c.Year,
	c.Month,
	COUNT(ip.Admission_ID) AS Discharges,
	AVG(ip.LOS_Days) AS Avg_LOS,
	ROUND(SUM(ip.Readmit_Flag)::decimal / NULLIF(COUNT(ip.Admission_ID),0), 3) AS Readmit_Rate,
	SUM(ch.Charge_Amount) AS Total_Charges
FROM uab_ops.inpatient_days ip
LEFT JOIN uab_ops.charges ch ON ip.Date = ch.Date AND ip.Department = ch.Department
JOIN uab_ops.calendar c ON ip.Date = c.Date
GROUP BY ip.Department, c.Year, c.Month
ORDER BY ip.Department, c.Year, c.Month;

-- 3. Service Line Rollup (Specialty Pharmacy)
CREATE OR REPLACE VIEW uab_ops.sp_service_summary AS
SELECT 
	sp.Service_Line,
	c.Year,
	c.Month,
	SUM(sp.Revenue) AS Total_Revenue,
	SUM(sp.Cost) AS Total_Cost,
	ROUND((SUM(sp.Revenue) - SUM(sp.Cost)) / NULLIF(SUM(sp.Cost),0), 3) AS ROI,
	COUNT(DISTINCT sp.Prescriber_Name) AS Unique_Prescribers
FROM uab_ops.specialty_pharmacy sp
JOIN uab_ops.calendar c ON sp.Date = c.Date
GROUP BY sp.Service_Line, c.Year, c.Month
ORDER BY sp.Service_Line, c.Year, c.Month;

-- 4. Payer Mix View (Charges)
CREATE OR REPLACE VIEW uab_ops.payer_mix AS
SELECT 
	c.Year,
	c.Month,
	ch.Payer_Type,
	SUM(ch.Charge_Amount) AS Total_Charges,
	ROUND(100.0 * SUM(ch.Charge_Amount) / NULLIF(SUM(SUM(ch.Charge_Amount)) OVER(PARTITION BY c.Year, c.Month),0), 2) AS Pct_of_Total
FROM uab_ops.charges ch
JOIN uab_ops.calendar c ON ch.Date = c.Date
GROUP BY c.Year, c.Month, ch.Payer_Type
ORDER BY c.Year, c.Month, ch.Payer_Type;

-- 5. ED Visits Trends
CREATE OR REPLACE VIEW uab_ops.ed_trends AS
SELECT 
	c.Year,
	c.Month,
	ed.Region,
	COUNT(ed.Visit_ID) AS Total_Visits,
	ROUND(SUM(ed.Admit_Flag)::decimal / NULLIF(COUNT(ed.Visit_ID),0), 3) AS Admit_Rate,
	AVG(ed.LOS_Hours) AS Avg_LOS_Hours,
	AVG(ed.Acuity_Score) AS Avg_Acuity
FROM uab_ops.ed_visits ed
JOIN uab_ops.calendar c ON ed.Date = c.Date
GROUP BY c.Year, c.Month, ed.Region
ORDER BY c.Year, c.Month, ed.Region;

