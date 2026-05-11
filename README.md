# DATA WAREHOUSE FINANCIAL ANALYTICS PROJECT

## Project Overview

In a modern Data Engineering environment, companies need to centralize and structure data coming from operational systems such as ERP systems, CRM platforms, and CSV files in order to support analysis and business decision-making.

This project focuses on designing and building a complete Data Warehouse using a layered architecture approach.

The pipeline includes:

- Ingesting raw financial and operational CSV files
- Structuring raw data in the Bronze layer
- Cleaning and standardizing data in the Silver layer
- Building an analytical Star Schema model in the Gold layer
- Preparing data for reporting and business analysis
- Creating interactive dashboards in Power BI

---

# Project Objectives

- Build a modern Data Warehouse architecture (Bronze / Silver / Gold)
- Load CSV files into a SQL database
- Clean and standardize raw data
- Transform operational data into analytical datasets
- Create SQL views and analytical models
- Perform data quality validation at every stage
- Develop Power BI dashboards for business reporting

---

# Data Warehouse Architecture

```text
CSV Sources → BRONZE → SILVER → GOLD → POWER BI
```

---

# Technology Stack

- SQL Server
- T-SQL
- Power BI
- CSV Files
- Star Schema Modeling

---

# Project Structure

```text
data-warehouse-project/
│
├── datasets/
│   ├── account.csv
│   ├── store.csv
│   ├── gltransaction.csv
│   ├── storemaster.csv
│   └── account_mapping.csv
│
├── sql/
│   ├── bronze/
│   ├── silver/
│   ├── gold/
│   └── quality_checks/
│
├── powerbi/
│   └── dashboard.pbix
│
└── README.md
```

---

# Layered Architecture

## Bronze Layer — Raw Data Ingestion

### Objective

Load CSV files into SQL Server without applying any transformation.

### Tasks

- Create the `DataWarehouse` database
- Create schemas:
  - `bronze`
  - `silver`
  - `gold`
- Create Bronze tables:
  - `account`
  - `store`
  - `gltransaction`
  - `storemaster`
  - `account_mapping`
- Load CSV files using `BULK INSERT`

### Characteristics

- Exact copy of source files
- No cleaning or transformation
- Used as the raw historical source

---

## Silver Layer — Data Cleaning & Standardization

### Objective

Clean, standardize, and structure the data for analytical usage.

### Data Cleaning

- Remove unnecessary spaces using `TRIM`
- Standardize codes using `UPPER`
- Convert data types using `CAST`
- Handle null values
- Remove duplicate records

### Standardization

- Fix inconsistent values
  - Example:
    - `"P L"` → `"P&L"`
- Normalize text formats
- Standardize business keys

### Expected Result

Reliable and consistent datasets ready for analytical modeling.

---

## Gold Layer — Analytical Data Model

### Objective

Build a Star Schema optimized for reporting and analysis.

## Star Schema Components

### Dimension Tables

- `dimstore`
- `dimaccount`

### Fact Table

- `fact_gl`

### Main Relationships

- Transactions + Accounts
- Transactions + Stores

### Expected Result

A clean and optimized analytical model ready for Power BI reporting.

---

# Data Quality Checks

Data validation is performed throughout all layers.

## Validation Rules

- No duplicate records
- Valid primary and foreign keys
- Referential integrity between tables
- No critical missing values
- Consistency between Bronze, Silver, and Gold layers

## Example Checks

```sql
-- Duplicate Detection
SELECT accountnumber, COUNT(*)
FROM silver.account
GROUP BY accountnumber
HAVING COUNT(*) > 1;
```

```sql
-- Row Count Validation
SELECT COUNT(*) FROM bronze.gltransaction;
SELECT COUNT(*) FROM silver.gltransaction;
```

```sql
-- Foreign Key Validation
SELECT *
FROM gold.fact_gl f
LEFT JOIN gold.dimaccount d
ON f.account_key = d.account_key
WHERE d.account_key IS NULL;
```

---

# Power BI Layer

## Objective

Transform the Gold analytical model into interactive business dashboards.

## Power BI Features

### Data Connection

- Connect Power BI directly to the `DataWarehouse` database
- Use Gold layer tables as the primary data source

### Data Modeling

- Implement a Star Schema inside Power BI
- Create relationships between dimensions and fact tables

### Dashboards & Reports

The dashboards provide:

- Financial Performance Overview (P&L)
- Revenue Analysis
- Cost Analysis
- Trend Analysis Over Time
- Store Performance Analysis
- Category-Based Analysis

---

# Example Analytical Model

```text
               dimaccount
                    |
                    |
dimstore ---- fact_gl ---- Date
```

---

# Key Learning Outcomes

By completing this project, you will learn how to:

- Design a layered Data Warehouse architecture
- Build ETL pipelines using SQL
- Clean and standardize enterprise data
- Create Star Schema models
- Perform data quality validation
- Develop Power BI dashboards
- Transform raw data into business insights

---

# Future Improvements

- Add incremental loading
- Implement stored procedures for ETL automation
- Add scheduling with SQL Server Agent or Airflow
- Introduce Slowly Changing Dimensions (SCD)
- Add advanced Power BI KPIs and DAX measures

---

# Author

Developed as a Data Engineering & Data Analytics practice project.
