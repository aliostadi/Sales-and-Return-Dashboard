# Sales & Returns Dashboard (Excel · Power Query · Power Pivot · DAX)

An end-to-end BI project built entirely in Excel:
- ETL with **Power Query** (M)
- Star/gallaxy model with **Power Pivot**
- **DAX** measures for KPIs
- Interactive dashboard with slicers

## 📸 Screenshots
![Dashboard](C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\src\docs\README_images/dashboard-hero.png)

![Model Diagram](C:\Users\msi\Desktop\پروژه ها\DataEngBI\retail_raw_csvs\src\docs\README_images/model-diagram.png)

## 🧱 Data Model (high level)
- Facts: `Fact_Order`, `Fact_OrderLine`, `Fact_Return`, `Fact_InventoryMovement`
- Dimensions: `Dim_Calendar`, `Dim_Product`, `Dim_Customer`, `Dim_Supplier`, `Dim_Category`, `Dim_Country`
- Planning: `Dim_SalesTarget` 

## 🧮 Key Measures (DAX)
```DAX
No Orders:=DISTINCTCOUNT(Fact_Order[OrderID])

Total Revenue:=sum(Fact_OrderLine[LineRevenue])

Total Cost:=sum(Fact_OrderLine[LineCost])

Total Margin:=sum(Fact_OrderLine[LineMargin])

Sold Quantity:=sum(Fact_OrderLine[Quantity])

No Products:=DISTINCTCOUNT(Fact_OrderLine[ProductID])

Number of Orders:=DISTINCTCOUNT(Fact_OrderLine[OrderID])

Avg Number of Products per Order:=DIVIDE([Sold Quantity],[Number of Orders],0)

Avg Revenue per Order:=DIVIDE([Total Revenue],[Number of Orders],0)

NO returen Products:=sum([ReturnQty])
```

## ▶️ How to run

1. Clone repo and open `models/Sales_Dashboard.xlsm`.
2. On first open, **Enable Content** (macros).
3. Go to Data  **Data →  **Queries and Connections and change the BasePath Parameter based on your system
4. Use **Data → Refresh All** to pull sample data from `data/`.
5. Explore the dashboard sheet; use slicers (Date, Country, Category).

## 📂 ETL (Power Query)

All M scripts are in `src/powerquery/`. Each query name matches a table in the model.

## 🔒 Data

Sample datasets (synthetic) are in `src/data/`. No PII or sensitive info.

## 📝 License

MIT (see `LICENSE`).