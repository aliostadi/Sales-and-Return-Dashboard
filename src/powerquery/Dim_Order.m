let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Fact_Order_RAW.csv"),[Delimiter=",", Columns=9, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"OrderID", Int64.Type}, {"OrderDateKey", Int64.Type}, {"OrderDate", type datetime}, {"CustomerID", Int64.Type}, {"Currency", type text}, {"OrderStatus", type text}, {"PaymentMethod", type text}, {"ShipMode", type text}, {"ShipAddress", type text}}),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Changed Type", "ShipAddress", Splitter.SplitTextByDelimiter(",", QuoteStyle.Csv), {"ShipAddress.1", "ShipAddress.2", "ShipAddress.3"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"ShipAddress.1", type text}, {"ShipAddress.2", type text}, {"ShipAddress.3", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type1",{{"ShipAddress.3", "ShipAddress_country"}, {"ShipAddress.2", "ShipAddress_state"}, {"ShipAddress.1", "ShipAddress_city"}}),
    #"Filtered Rows" = Table.SelectRows(#"Renamed Columns", each true),
    #"Replaced Value" = Table.ReplaceValue(#"Filtered Rows","Shippedd","Shipped",Replacer.ReplaceText,{"OrderStatus"}),
    #"Filtered Rows1" = Table.SelectRows(#"Replaced Value", each true),
    #"Removed Duplicates" = Table.Distinct(#"Filtered Rows1"),
    #"Removed Other Columns" = Table.SelectColumns(#"Removed Duplicates",{"OrderID"}),
    #"Removed Duplicates1" = Table.Distinct(#"Removed Other Columns")
in
    #"Removed Duplicates1"
