let
    Source = #"uab_ops_calendar_bronze",
    #"Changed Type" = Table.TransformColumnTypes(Source, {{"Date", type date}}, "en-US"),
    #"Added DateKey" = Table.AddColumn(#"Changed Type", "DateKey", each Date.ToText([Date], "yyyyMMdd"), type text),
    #"Added Year" = Table.AddColumn(#"Added DateKey", "Year", each Date.Year([Date]), Int64.Type),
    #"Added MonthNumber" = Table.AddColumn(#"Added Year", "MonthNumber", each Date.Month([Date]), Int64.Type),
    #"Added MonthName" = Table.AddColumn(#"Added MonthNumber", "MonthName", each Date.ToText([Date], "MMMM"), type text),
    #"Added MonthShort" = Table.AddColumn(#"Added MonthName", "MonthShort", each Date.ToText([Date], "MMM"), type text),
    #"Added QuarterNumber" = Table.AddColumn(#"Added MonthShort", "QuarterNumber", each Date.QuarterOfYear([Date]), Int64.Type),
    #"Added Quarter" = Table.AddColumn(#"Added QuarterNumber", "Quarter", each "Q" & Number.ToText([QuarterNumber]), type text),
    #"Added YearMonth" = Table.AddColumn(#"Added Quarter", "YearMonth", each [Year]*100 + [MonthNumber], Int64.Type)
in
    #"Added YearMonth"
