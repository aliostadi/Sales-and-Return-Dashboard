let
    Source = Csv.Document(File.Contents("C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\Dim_Region_RAW.csv"),[Delimiter=",", Columns=4, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"RegionID", Int64.Type}, {"Country", type text}, {"State", type text}, {"City", type text}}),
    #"Capitalized Each Word" = Table.TransformColumns(#"Changed Type",{{"Country", Text.Proper, type text}}),
    #"Trimmed Text" = Table.TransformColumns(#"Capitalized Each Word",{{"State", Text.Trim, type text}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Trimmed Text",{"Country"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns"),
    #"Trimmed Text1" = Table.TransformColumns(#"Removed Duplicates",{{"Country", Text.Trim, type text}}),
    #"Cleaned Text" = Table.TransformColumns(#"Trimmed Text1",{{"Country", Text.Clean, type text}}),
    #"Removed Duplicates1" = Table.Distinct(#"Cleaned Text")
in
    #"Removed Duplicates1"
