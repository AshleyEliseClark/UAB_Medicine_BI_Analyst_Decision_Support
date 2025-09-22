
-- =========================================
-- Schema: UAB Operations & Specialty Pharmacy
-- File: 00_create_schema.sql
-- =========================================

-- Create schema
CREATE SCHEMA IF NOT EXISTS uab_ops;

-- =====================
-- Dimension Tables
-- =====================

CREATE TABLE uab_ops.calendar (
	Date DATE PRIMARY KEY,
	Month INT,
	Year INT,
	Quarter INT
);

CREATE TABLE uab_ops.department (
	Department_ID SERIAL PRIMARY KEY,
	Department_Name VARCHAR(100) NOT NULL
);

CREATE TABLE uab_ops.service_line (
	ServiceLine_ID SERIAL PRIMARY KEY,
	ServiceLine_Name VARCHAR(100) NOT NULL
);

CREATE TABLE uab_ops.prescriber (
	Prescriber_ID SERIAL PRIMARY KEY,
	Prescriber_Name VARCHAR(100) NOT NULL,
	ServiceLine_ID INT REFERENCES uab_ops.service_line(ServiceLine_ID)
);

CREATE TABLE uab_ops.payer (
	Payer_ID SERIAL PRIMARY KEY,
	Payer_Name VARCHAR(100) NOT NULL
);

-- =====================
-- Fact Tables
-- =====================

-- Charges
CREATE TABLE uab_ops.charges (
	Patient_ID VARCHAR(20),
	Department VARCHAR(100),
	Payer_Type VARCHAR(50),
	Charge_Amount DECIMAL(12,2),
	Date DATE REFERENCES uab_ops.calendar(Date)
);

-- Operating Room
CREATE TABLE uab_ops.operating_room (
	Case_ID VARCHAR(20) PRIMARY KEY,
	Service_Line VARCHAR(100),
	Surgeon_Name VARCHAR(100),
	Case_Minutes INT,
	Cancelled BOOLEAN,
	Revenue DECIMAL(12,2),
	Date DATE REFERENCES uab_ops.calendar(Date)
);

-- Heart & Vascular Center
CREATE TABLE uab_ops.hvc (
	Case_ID VARCHAR(20) PRIMARY KEY,
	Service_Line VARCHAR(100),
	Physician_Name VARCHAR(100),
	Patients INT,
	LOS_Days INT,
	Readmit_Flag BOOLEAN,
	Date DATE REFERENCES uab_ops.calendar(Date)
);

-- Inpatient Days
CREATE TABLE uab_ops.inpatient_days (
	Admission_ID VARCHAR(20) PRIMARY KEY,
	Department VARCHAR(100),
	LOS_Days INT,
	Discharge_Date DATE,
	Readmit_Flag BOOLEAN
);

-- Infusion
CREATE TABLE uab_ops.infusion (
	Visit_ID VARCHAR(20) PRIMARY KEY,
	Drug_Name VARCHAR(100),
	Service_Line VARCHAR(100),
	Cost DECIMAL(12,2),
	Revenue DECIMAL(12,2),
	Patient_Count INT,
	Date DATE REFERENCES uab_ops.calendar(Date)
);

-- Emergency Department Visits
CREATE TABLE uab_ops.ed_visits (
	Visit_ID VARCHAR(20) PRIMARY KEY,
	Date DATE REFERENCES uab_ops.calendar(Date),
	Region VARCHAR(100),
	Admit_Flag BOOLEAN,
	LOS_Hours INT,
	Acuity_Score INT
);

-- Specialty Pharmacy
CREATE TABLE uab_ops.specialty_pharmacy (
	Prescription_ID VARCHAR(20) PRIMARY KEY,
	Drug_Name VARCHAR(100),
	Service_Line VARCHAR(100),
	Prescriber_Name VARCHAR(100),
	Patient_Count INT,
	Cost DECIMAL(12,2),
	Revenue DECIMAL(12,2),
	Date DATE REFERENCES uab_ops.calendar(Date)
);
