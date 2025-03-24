# Project README

Note: Step by Step implementation starts from 10th point

1. Project Overview

This project is designed to process, transform, and aggregate transaction data efficiently using Azure Data Factory (ADF), Azure Data Lake Storage Gen2 (ADLS Gen2), and SQL Server. The final output is used for reporting in Power BI. The implementation ensures optimized data processing by handling duplicates, normalization, and incremental loading.

2. Raw Data Handling

Source files are received in .dlm format and stored in ADLS Gen2 under the folder structure:

RawData/Input/*.dlm

The data is loaded into SQL tables under the RAW Schema.

3. SQL Table Creation

All necessary tables are created in SQL, except for fact_transactions, where constraints are removed to allow duplicates. This improves ADF pipeline performance.

4. Loading Data to SQL (RAW Schema)

ADF loads raw data from ADLS Gen2 into RAW SQL tables.

5. Schema Inference and Validation Checks

Schema Inference: Table structures were inferred based on column names and relationships in the raw data.

Run validation checks using Step2 - Basic Validation Checks in heir_prod and fact_transactions Tables from SQL Scripts.

6. Staging Schema

A Staging Schema is created for cleaned and transformed data.

fact_transactions_cleaned table is created to remove duplicates.

Normalization is applied to hier_prod and hier_clnd tables.

7. Refined Schema & Aggregation

Refined Schema is created for reporting purposes.

mview_weekly_sales aggregates weekly sales data.

8. Power BI Integration

The mview_weekly_sales table is connected to Power BI for visualization and reporting.

9. Incremental Loading

A Stored Procedure (SP) is created for incremental loading.

The SP is integrated into the ADF pipeline to load only new/updated data.

10. Step-by-Step Implementation Guide

Store Raw Data in ADLS Gen2: Place .dlm files in RawData/Input/

Create SQL Tables: Use Step1 - Creating All Tables in Raw Schema from SQL Scripts

Load Data into RAW Schema: Use ADF to move data from ADLS Gen2 to SQL

Run Validation Checks: Execute Step2 - Basic Validation Checks in heir_prod and fact_transactions Tables from SQL Scripts

Transform & Normalize Data:

Use Step3 - Create Fact_transaction_Cleaned table in Staging Layer from SQL Scripts

Use Step4 - hier_prod Normalization in Staging Layer from SQL Scripts

Use Step5 - hier_clnd Normalization in Staging Layer from SQL Scripts

Aggregate Weekly Sales Data:

Use Step6 - Creating&Inserting Data Into mview_weekly_sales Table in Refined Layer from SQL Scripts

Integrate Power BI: Connect Refined Schema tables for reporting

Implement Incremental Load:

Use Step7 - Stored Procedure For Incremental Loading for mview_weekly_sales Table from SQL Scripts and attach it to ADF for efficient data refresh

11. Tools & Technologies Used

Azure Data Factory (ADF): Orchestrating data movement and transformations.

Azure Data Lake Storage Gen2 (ADLS Gen2): Storing raw .dlm files.

SQL Server: Processing, validating, and aggregating data.

Power BI: Visualizing the final aggregated sales data.

GitHub: Version control and project collaboration.

12. Submission & Documentation

The project is structured for submission on GitHub with all relevant scripts and configurations.

A video demonstration of the implementation has been recorded, explaining the data flow, transformations, and Power BI integration.

13. Bonus Task: Incremental Loading

The mview_weekly_sales table supports incremental loading using a Stored Procedure (SP).

This allows processing only new or updated data, improving efficiency.