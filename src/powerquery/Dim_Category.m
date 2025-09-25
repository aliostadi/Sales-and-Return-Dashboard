let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Dim_Product_RAW.csv"),[Delimiter=",", Columns=8, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ProductID", Int64.Type}, {"ProductName", type text}, {"Category", type text}, {"Subcategory", type text}, {"SupplierID", Int64.Type}, {"StandardCost", type number}, {"ListPrice", type text}, {"CatPath", type text}}),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Changed Type", "CatPath", Splitter.SplitTextByDelimiter("|", QuoteStyle.Csv), {"CatPath.1", "CatPath.2"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"CatPath.1", type text}, {"CatPath.2", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type1",{"CatPath.1", "CatPath.2"}),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Columns",",","",Replacer.ReplaceText,{"ListPrice"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value",",",".",Replacer.ReplaceText,{"ListPrice"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Replaced Value1",{{"ListPrice", type number}}),
    #"Added Custom" = Table.AddColumn(#"Changed Type2", "Custom", each if [ProductName] = null then "Product-" else [ProductName]),
    #"Removed Columns1" = Table.RemoveColumns(#"Added Custom",{"Custom", "ProductName", "SupplierID", "StandardCost", "ListPrice", "ProductID"}),
    #"Removed Other Columns" = Table.SelectColumns(#"Removed Columns1",{"Category"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns")
in
    #"Removed Duplicates"