let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Dim_SalesTarget_RAW.csv"),[Delimiter=",", Columns=4, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"YearMonth", type date}, {"Country", type text}, {"Category", type text}, {"TargetRevenue", type number}}),
    #"Added Custom" = Table.AddColumn(#"Changed Type", "Custom", each Date.ToText([YearMonth], "yyyy-MM")),
    #"Renamed Columns" = Table.RenameColumns(#"Added Custom",{{"Custom", "Month-Year"}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Renamed Columns",{"Month-Year"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns")
in
    #"Removed Duplicates"