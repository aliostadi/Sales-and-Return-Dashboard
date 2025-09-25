let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Dim_Supplier_RAW.csv"),[Delimiter=",", Columns=3, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"SupplierID", Int64.Type}, {"SupplierName", type text}, {"Country", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","&","",Replacer.ReplaceText,{"SupplierName"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","_","",Replacer.ReplaceText,{"SupplierName"}),
    #"Cleaned Text" = Table.TransformColumns(#"Replaced Value1",{{"SupplierName", Text.Clean, type text}})
in
    #"Cleaned Text"