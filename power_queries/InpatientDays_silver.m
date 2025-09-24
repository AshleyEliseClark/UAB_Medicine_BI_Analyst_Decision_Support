let
    Source = #"uab_ops_inpatient_days_bronze",
    #"Changed Type" = Table.TransformColumnTypes(Source, {{"admission_date", type date}}, "en-US"),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type", {{"los_days", "InpatientDays"}}),
    #"Added DateKey" = Table.AddColumn(#"Renamed Columns", "DateKey", each Date.ToText([admission_date], "yyyyMMdd"), type text),
    #"Added Year" = Table.AddColumn(#"Added DateKey", "Year", each Date.Year([admission_date]), Int64.Type),
    #"Added MonthNumber" = Table.AddColumn(#"Added Year", "MonthNumber", each Date.Month([admission_date]), Int64.Type),
    #"Added MonthName" = Table.AddColumn(#"Added MonthNumber", "MonthName", each Date.ToText([admission_date], "MMMM"), type text),
    #"Added Quarter" = Table.AddColumn(#"Added MonthName", "Quarter", each "Q" & Number.ToText(Date.QuarterOfYear([admission_date])), type text),
    #"Added YearMonth" = Table.AddColumn(#"Added Quarter", "YearMonth", each [Year]*100 + [MonthNumber], Int64.Type)
in
    #"Added YearMonth"
