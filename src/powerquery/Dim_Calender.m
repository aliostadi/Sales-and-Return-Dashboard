let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Dim_Calendar_RAW.csv"),[Delimiter=",", Columns=10, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"DateKey", Int64.Type}, {"Date", type date}, {"Year", Int64.Type}, {"Quarter", type text}, {"Month", Int64.Type}, {"MonthName", type text}, {"Week", Int64.Type}, {"Day", Int64.Type}, {"Weekday", type text}, {"IsWeekend", Int64.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each ([DateKey] <> null)),
    #"Removed Duplicates" = Table.Distinct(#"Filtered Rows", {"DateKey"}),
    #"Removed Duplicates1" = Table.Distinct(#"Removed Duplicates", {"DateKey"}),
    #"Removed Duplicates2" = Table.Distinct(#"Removed Duplicates1", {"Date"}),
    #"Added Custom" = Table.AddColumn(#"Removed Duplicates2", "Month_Year", each Date.ToText([Date], "yyyy-MM"))
in
    #"Added Custom"
