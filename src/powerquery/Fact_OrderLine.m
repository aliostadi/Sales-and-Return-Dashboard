let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Fact_OrderLine_RAW.csv"),[Delimiter=",", Columns=10, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"OrderLineID", Int64.Type}, {"OrderID", Int64.Type}, {"ProductID", Int64.Type}, {"Quantity", Int64.Type}, {"UnitPrice", type number}, {"Discount", Percentage.Type}, {"StandardCost", type number}, {"LineRevenue", type number}, {"LineCost", type number}, {"LineMargin", type number}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"ProductID"}, Dim_Product, {"ProductID"}, "Dim_Product", JoinKind.Inner)
in
    #"Merged Queries"