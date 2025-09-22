-- =========================================
-- Bulk Load Data into UAB Operations Schema
-- File: 01_load_data.sql
-- =========================================

-- Dimension Tables
COPY uab_ops.calendar(Date, Month, Year, Quarter)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\calendar_fixed.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.department(Department_ID, Department_Name)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\department.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.service_line(ServiceLine_ID, ServiceLine_Name)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\service_line.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.payer(Payer_ID, Payer_Name)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\payer.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.prescriber(Prescriber_ID, Prescriber_Name, ServiceLine_ID)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\prescriber.csv'
DELIMITER ','
CSV HEADER;

-- Fact Tables (Ops 2023–2025)
COPY uab_ops.charges(Patient_ID, Department, Payer_Type, Charge_Amount, Date)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\charges.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.operating_room(Case_ID, Service_Line, Surgeon_Name, Case_Minutes, Cancelled, Revenue, Date)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\operating_room.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.hvc(Case_ID, Service_Line, Physician_Name, Patients, LOS_Days, Readmit_Flag, Date)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\hvc.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.inpatient_days(Admission_ID, Department, LOS_Days, Discharge_Date, Readmit_Flag)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\inpatient_days.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.infusion(Visit_ID, Drug_Name, Service_Line, Cost, Revenue, Patient_Count, Date)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\infusion.csv'
DELIMITER ','
CSV HEADER;

COPY uab_ops.ed_visits(Visit_ID, Date, Region, Admit_Flag, LOS_Hours, Acuity_Score)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\ed_visits.csv'
DELIMITER ','
CSV HEADER;

-- Fact Table (Specialty Pharmacy 2024–2025)
COPY uab_ops.specialty_pharmacy(Prescription_ID, Drug_Name, Service_Line, Prescriber_Name, Patient_Count, Cost, Revenue, Date)
FROM 'C:\Users\AshleyPC\UAB_BI_FullStack_Mock\specialty_pharmacy.csv'
DELIMITER ','
CSV HEADER;
