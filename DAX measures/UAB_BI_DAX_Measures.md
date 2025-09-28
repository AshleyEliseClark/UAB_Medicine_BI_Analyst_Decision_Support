# UAB BI Dashboard – All DAX Measures

## Table: ServiceAreas

### Actual

```DAX

SWITCH ( SELECTEDVALUE ( ServiceAreas[Service] ),
    "Charges",   [Actual_Charges],
    "OR Cases",  [Actual_ORCases],
    "Infusion",  [Actual_Infusion],
    "Inpatient", [Actual_Inpatient],
    "ED Visits", [Actual_ED],
    "HVC",       [Actual_HVC]

)
```

### Budget

```DAX

SWITCH ( SELECTEDVALUE ( ServiceAreas[Service] ),
    "Charges",   [Budget_Charges],
    "OR Cases",  [Budget_ORCases],
    "Infusion",  [Budget_Infusion],
    "Inpatient", [Budget_Inpatient],
    "ED Visits", [Budget_ED],
    "HVC",       [Budget_HVC]
)

```

### Variance

```DAX

[Actual] - [Budget]

```

### % of Budget

```DAX

DIVIDE ( [Actual], [Budget] )

```

## Table: budget

### Measure

```DAX
-- no expression found --
```

## Table: calendar_silver

### % Month Elapsed

```DAX

VAR d = COALESCE (
    SELECTEDVALUE ( calendar_silver[Date] ),
    MAX ( calendar_silver[Date] )
)
VAR StartMonth = DATE ( YEAR ( d ), MONTH ( d ), 1 )
VAR EndMonth   = EOMONTH ( d, 0 )
VAR AsOf       = MIN ( TODAY(), EndMonth )
VAR ElapsedDays = DATEDIFF ( StartMonth, AsOf, DAY ) + 1
VAR TotalDays   = DAY ( EndMonth )
RETURN DIVIDE ( ElapsedDays, TotalDays )

```

### -- Anchor the selected month from your slicerSelected Month Start

```DAX

VAR d = MAX ( calendar_silver[Date] )
RETURN DATE ( YEAR(d), MONTH(d), 1 )



```

### Selected Month End

```DAX

VAR d = COALESCE ( SELECTEDVALUE ( calendar_silver[Date] ), MAX ( calendar_silver[Date] ) )
RETURN EOMONTH ( d, 0 )



```

### Selected Month Label

```DAX

VAR d = COALESCE ( SELECTEDVALUE ( calendar_silver[Date] ), MAX ( calendar_silver[Date] ) )
RETURN FORMAT ( d, "MMMM yyyy" )

```

### Gauge Max

```DAX
1

```

## Table: charges_silver

### Total Charges (Actual)

```DAX
SUM(charges_silver[Amount])




```

### Average Charge per Patient

```DAX

DIVIDE(
    [Total Charges (Actual)],
    DISTINCTCOUNT(charges_silver[patient_id])
)
```

### Charges Variance

```DAX

[Total Charges (Actual)] - [Total Charges(Budget)]
```

### Charges Variance %

```DAX

DIVIDE ( [Charges Variance], [Total Charges(Budget)] )
```

### Charges % of Budget

```DAX

DIVIDE(
    [Total Charges (Actual)],
    [Total Charges(Budget)],
    BLANK()
)

```

### Total Charges(Budget)

```DAX

CALCULATE (
    SUM ( budget[BudgetCharges] ),
    TREATAS ( VALUES ( calendar_silver[DateKey] ), budget[DateKey] )
)

```

### Total Charges (Today)

```DAX

CALCULATE([Total Charges (Actual)], 
    FILTER(calendar_silver, calendar_silver[Date] = TODAY()))
```

### Total Charges (Budget Today)

```DAX

CALCULATE([Total Charges(Budget)], 
    FILTER(calendar_silver, calendar_silver[Date] = TODAY()))
```

### Charges Variance (Today)

```DAX

[Total Charges (Today)] - [Total Charges (Budget Today)]
```

### Charges % of Budget MTD

```DAX

DIVIDE([Total Charges (Actual)], [Total Charges(Budget)], BLANK())
```

### Month % Elapsed

```DAX

DIVIDE(TODAY() - STARTOFMONTH(calendar_silver[Date]), 
       ENDOFMONTH(calendar_silver[Date]) - STARTOFMONTH(calendar_silver[Date]), 
       BLANK())
```

### Actual_Charges

```DAX
[Total Charges (Actual)] 
```

### Budget_Charges

```DAX
[Total Charges(Budget)] 
```

## Table: ed_visits_silver

### Total ED (Actual)

```DAX
COUNTROWS(ed_visits_silver)
```

### Avg ED LOS (Hours)

```DAX
AVERAGE(ed_visits_silver[ED_LOS_Hours])
```

### ED Admit Rate

```DAX

DIVIDE(
    CALCULATE(COUNTROWS(ed_visits_silver), ed_visits_silver[admit_flag] = TRUE),
    [Total ED (Actual)]
)
```

### ED Visits Budget

```DAX

SUM ( budget[BudgetEDVisits] )
```

### ED Visits Variance

```DAX

[Total ED (Actual)] - [ED Visits Budget]
```

### ED Visits Variance %

```DAX

DIVIDE ( [ED Visits Variance], [ED Visits Budget] )
```

### Total ED (Budget)

```DAX

CALCULATE(
SUM ( budget[BudgetEDVisits]),
TREATAS( VALUES(calendar_silver[DateKey]),budget[DateKey]))
```

### Actual_ED

```DAX
[Total ED (Actual)] 
```

### Budget_ED

```DAX
[Total ED (Budget)] 
```

## Table: hvc_silver

### HVC Patients

```DAX
SUM(hvc_silver[patients])
```

### HVC Avg LOS (Days)

```DAX
AVERAGE(hvc_silver[HVC_LOS_Days])
```

### Total HVC Cases

```DAX

COUNTROWS(hvc_silver)
```

### Total HVC Patients

```DAX

SUM(hvc_silver[patients])
```

### HVC Readmit Rate %

```DAX

DIVIDE(
    CALCULATE(COUNTROWS(hvc_silver), hvc_silver[readmit_flag] = TRUE),
    [Total HVC Cases],
    BLANK())
```

### Total HVC LOS Days

```DAX

SUM(hvc_silver[HVC_LOS_Days])
```

### Actual_HVC

```DAX
[Total HVC Cases]  
```

### Total HVC Cases (Budget)

```DAX

CALCULATE (
    SUM ( budget_extended_corrected[BudgetHVCCases] ),
    TREATAS ( VALUES ( calendar_silver[DateKey] ), budget_extended_corrected[DateKey] )
)

```

### Total HVC Patients (Budget)

```DAX

CALCULATE(
    sum(budget_extended_corrected[BudgetEDVisits]),
    TREATAS(VALUES(calendar_silver[DateKey]),budget_extended_corrected[DateKey]
    ))
```

### Total HVC LOS Days (Budget)

```DAX

SUM(budget_extended_corrected[BudgetHVCLosDays])
```

### HVC Cases Variance

```DAX

[Total HVC Cases] - [Total HVC Cases (Budget)]
```

### Budget_HVC

```DAX
[Total HVC Cases (Budget)] 
```

## Table: infusion_silver

### Total Infusion (Actual)

```DAX

COUNTROWS(infusion_silver)
```

### Infusion Patients

```DAX
SUM(infusion_silver[Infusion_PatientCount])
```

### Infusion Revenue Budget

```DAX

SUM ( budget[BudgetInfusionRevenue] )
```

### Total Infusion (Budget)

```DAX

CALCULATE (
    SUM ( budget_extended_corrected[BudgetInfusionEncounters] ),
    TREATAS ( VALUES ( calendar_silver[DateKey] ), budget_extended_corrected[DateKey] )
)

```

### Infusion Encounters Variance

```DAX

[Total Infusion (Actual)] - [Total Infusion (Budget)]
```

### Variance %

```DAX

DIVIDE([Infusion Encounters Variance], [Total Infusion (Budget)], BLANK())
```

### Actual_Infusion

```DAX
[Total Infusion (Actual)]  
```

### Budget_Infusion

```DAX
[Total Infusion (Budget)]  
```

## Table: inpatient_days_silver

### Total IP Days

```DAX
SUM(inpatient_days_silver[InpatientDays])
```

### Readmit Rate

```DAX

DIVIDE(
    CALCULATE(COUNTROWS(inpatient_days_silver), inpatient_days_silver[readmit_flag] = TRUE),
    COUNTROWS(inpatient_days_silver)
)
```

### Inpatient Days Budget

```DAX

SUM ( budget[BudgetInpatientDays])
```

### Inpatient Days Variance ($)

```DAX

[Total IP Days] - [Total IP Days (Budget)]
```

### IP Days Variance %

```DAX

DIVIDE ( [Inpatient Days Variance ($)], [Total IP Days (Budget)] )
```

### Total IP Days (Budget)

```DAX

CALCULATE (
    SUM ( budget[BudgetInpatientDays] ),
    TREATAS ( VALUES ( calendar_silver[DateKey] ), budget[DateKey] ))
```

### Actual_Inpatient

```DAX
[Total IP Days] 
```

### Budget_Inpatient

```DAX
[Total IP Days (Budget)]  
```

## Table: operating_room_silver

### Total OR (Actual)

```DAX
COUNTROWS(operating_room_silver) 
```

### Total OR Cases (Budget)

```DAX

CALCULATE(
    SUM(budget_extended_corrected[BudgetORCases]),
    TREATAS(VALUES(calendar_silver[DateKey]), budget_extended_corrected[DateKey])
)


```

### OR Cases Variance

```DAX

[Total OR (Actual)] - [Total OR Cases (Budget)]
```

### OR Variance %

```DAX

DIVIDE([OR Cases Variance], [Total OR Cases (Budget)], BLANK())
```

### Actual_ORCases

```DAX
[Total OR (Actual)]
```

### Budget_ORCases

```DAX
[Total OR Cases (Budget)]
```

## Table: specialty_pharmacy_silver

### Total Pharmacy Revenue

```DAX
SUM(specialty_pharmacy_silver[Pharmacy_Revenue])
```

### Total Pharmacy Cost

```DAX
SUM(specialty_pharmacy_silver[Pharmacy_Cost])
```

### Pharmacy Margin

```DAX
[Total Pharmacy Revenue] - [Total Pharmacy Cost]
```

### Total Pharmacy Patients

```DAX
SUM(specialty_pharmacy_silver[Pharmacy_PatientCount])
```

### Top Prescribers by Revenue

```DAX

RANKX(
    ALL(specialty_pharmacy_silver[prescriber_name]),
    CALCULATE(SUM(specialty_pharmacy_silver[Pharmacy_Revenue])))
```

### Pharmacy Revenue Budget

```DAX

SUM ( budget[BudgetPharmacyRevenue] )


```

### Pharmacy Revenue Variance

```DAX

[Total Pharmacy Revenue] - [Pharmacy Revenue Budget]
```

### Pharmacy Revenue Variance %

```DAX

DIVIDE ( [Pharmacy Revenue Variance], [Pharmacy Revenue Budget] )
```

### Total Pharmacy Revenue (Budget)

```DAX
SUM ( budget[BudgetPharmacyRevenue])
```
