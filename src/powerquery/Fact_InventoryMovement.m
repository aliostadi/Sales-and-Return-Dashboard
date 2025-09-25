let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Fact_InventoryMovement_RAW.csv"),[Delimiter=",", Columns=5, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ProductID", Int64.Type}, {"MovementDateKey", Int64.Type}, {"MovementDate", type date}, {"MovementType", type text}, {"Quantity", Int64.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each true),
    #"Uppercased Text" = Table.TransformColumns(#"Filtered Rows",{{"MovementType", Text.Upper, type text}}),
    #"Filtered Rows1" = Table.SelectRows(#"Uppercased Text", each true)
in
    #"Filtered Rows1"
