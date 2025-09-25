let
  Source = #table(
    type table [RawCurrency = text, CurrencyCode = text],
    {
      {"€",  "EUR"},
      {"EUR","EUR"},
      {"£",  "GBP"},
      {"GBP","GBP"},
      {"USD","USD"},
      {"usd","USD"}
    }
  ),
  Clean = Table.TransformColumns(Source, {
            {"RawCurrency", each Text.Upper(Text.Trim(_)), type text},
            {"CurrencyCode", each Text.Upper(Text.Trim(_)), type text}
          }),
  Distinct = Table.Distinct(Clean, {"RawCurrency"})
in
  Distinct