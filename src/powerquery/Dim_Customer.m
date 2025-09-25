let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Dim_Customer_RAW.csv"),[Delimiter=",", Columns=8, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"CustomerID", Int64.Type}, {"CustomerName", type text}, {"Segment", type text}, {"Country", type text}, {"State", type text}, {"City", type text}, {"CustomerCode", type text}, {"CombinedLocation", type text}}),
    #"Trimmed Text" = Table.TransformColumns(#"Changed Type",{{"Country", Text.Trim, type text}}),
    #"Removed Duplicates" = Table.Distinct(#"Trimmed Text", {"CustomerID"})
in
    #"Removed Duplicates"