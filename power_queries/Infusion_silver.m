let
    Source = #"uab_ops_infusion_bronze",
    #"Changed Type" = Table.TransformColumnTypes(Source, {{"date", type date}}, "en-US"),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type", {
        {"cost", "Infusion_Cost"},
        {"revenue", "Infusion_Revenue"},
        {"patient_count", "Infusion_PatientCount"}
    }),
    #"Added DateKey" = Table.AddColumn(#"Renamed Columns", "DateKey", each Date.ToText([date], "yyyyMMdd"), type text),
    #"Added Year" = Table.AddColumn(#"Added DateKey", "Year", each Date.Year([date]), Int64.Type),
    #"Added MonthNumber" = Table.AddColumn(#"Added Year", "MonthNumber", each Date.Month([date]), Int64.Type),
    #"Added MonthName" = Table.AddColumn(#"Added MonthNumber", "MonthName", each Date.ToText([date], "MMMM"), type text),
    #"Added Quarter" = Table.AddColumn(#"Added MonthName", "Quarter", each "Q" & Number.ToText(Date.QuarterOfYear([date])), type text),
    #"Added YearMonth" = Table.AddColumn(#"Added Quarter", "YearMonth", each [Year]*100 + [MonthNumber], Int64.Type)
in
    #"Added YearMonth"
