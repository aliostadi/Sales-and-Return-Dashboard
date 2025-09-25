let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Fact_Return_RAW.csv"),[Delimiter=",", Columns=6, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ReturnID", type text}, {"OrderID", Int64.Type}, {"OrderLineID", Int64.Type}, {"ProductID", Int64.Type}, {"ReturnQty", Int64.Type}, {"Reason", type text}})
in
    #"Changed Type"
