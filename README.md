# powerbi-sales-report
Power BI report visualizing sales by product category
This repository contains a Power BI report that analyzes sales performance by product category using a star schema data model with fact and dimension tables.


🧰 Tools Used
- **Power BI Desktop**
- **SAS Studio** (for preprocessing and exporting CSVs)
- **Data Model**: Star Schema



## 🧱 Data Structure

### 📁 Tables
- `fact.csv` – Sales transaction data (Order_ID, Customer_ID, Product_ID, Sales, etc.)
- `dim_customer.csv` – Customer details (Customer_ID, Name, City, Country)
- `dim_product.csv` – Product details (Product_ID, Category, Sub_Category, Product_Name)

### 🔗 Relationships
- One-to-many joins from `dim_customer` and `dim_product` to the `fact` table.

