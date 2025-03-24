# Project README

Note:

		A new folder Snapshots has been added to showcase project-related images, including proofs of work with Azure Data Factory (ADF), Azure Data Lake Storage (ADLS), SQL Server (SQLDB), Power BI, and GitHub repository structures.

1. Project Overview:

		This project is designed to process, transform, and aggregate transaction data efficiently using Azure Data Factory (ADF), Azure Data Lake Storage Gen2 (ADLS Gen2), and SQL Server. The final output is used for reporting in Power BI. The implementation ensures optimized data processing by handling duplicates, normalization, and incremental loading.

2. Project Structure:

		The repository contains the following folders:
		Azure Data Factory: Contains ADF pipeline configurations, linked services, datasets, and activities used for data movement and transformation.
		ER & DataFlow Architecture Diagrams: Includes Entity-Relationship (ER) diagrams and Data Flow Architecture diagrams for better understanding of the project structure.
		SQL Scripts: Contains SQL scripts for table creation, data validation, transformation, aggregation, and incremental loading.
		README.md: Provides an overview and step-by-step implementation guide for the project.

3. Raw Data Handling:

		Source files are received in .dlm format and stored in ADLS Gen2 under the folder structure: RawData/Input/*.dlm
		The data is loaded into SQL tables under the RAW Schema.


4. SQL Table Creation:

		All necessary tables are created in SQL, except for fact_transactions, where constraints are removed to allow duplicates. This improves ADF pipeline performance.


5. Loading Data to SQL (RAW Schema):

		ADF loads raw data from ADLS Gen2 into RAW SQL tables.


6. Schema Inference and Validation Checks:

		Schema Inference: Table structures were inferred based on column names and relationships in the raw data.
		Run validation checks using Step2 - Basic Validation Checks in heir_prod and fact_transactions Tables from SQL Scripts.


7. Staging Schema:

		A Staging Schema is created for cleaned and transformed data.
		fact_transactions_cleaned table is created to remove duplicates.
		Normalization is applied to hier_prod and hier_clnd tables.


8. Refined Schema & Aggregation:

		Refined Schema is created for reporting purposes.
		mview_weekly_sales aggregates weekly sales data.


9. Power BI Integration:

		The mview_weekly_sales table is connected to Power BI for visualization and reporting.


10. Incremental Loading:

		A Stored Procedure (SP) is created for incremental loading.
		The SP is integrated into the ADF pipeline to load only new/updated data.


11. Step-by-Step Implementation Guide:

		A)Store Raw Data in ADLS Gen2: Place .dlm files in RawData/Input/
		B)Create SQL Tables: Use Step1 - Creating All Tables in Raw Schema from SQL Scripts
		C)Load Data into RAW Schema: Use ADF to move data from ADLS Gen2 to SQL
		D)Run Validation Checks: Execute Step2 - Basic Validation Checks in heir_prod and fact_transactions Tables from SQL Scripts
		E)Transform & Normalize Data: 
			Use Step3 - Create Fact_transaction_Cleaned table in Staging Layer from SQL Scripts
			Use Step4 - hier_prod Normalization in Staging Layer from SQL Scripts
			Use Step5 - hier_clnd Normalization in Staging Layer from SQL Scripts
		F)Aggregate Weekly Sales Data:
			Use Step6 - Creating&Inserting Data Into mview_weekly_sales Table in Refined Layer from SQL Scripts
		G)Integrate Power BI: Connect Refined Schema tables for reporting
		H)Implement Incremental Load:
			Use Step7 - Stored Procedure For Incremental Loading for mview_weekly_sales Table from SQL Scripts and attach it to ADF for efficient data refresh


12. Tools & Technologies Used:

		Azure Data Factory (ADF): Orchestrating data movement and transformations.
		Azure Data Lake Storage Gen2 (ADLS Gen2): Storing raw .dlm files.
		SQL Server: Processing, validating, and aggregating data.
		Power BI: Visualizing the final aggregated sales data.
		GitHub: Version control and project collaboration.


13. Submission & Documentation:

		The project is structured for submission on GitHub with all relevant scripts and configurations.
		A video demonstration of the implementation has been recorded, explaining the data flow, transformations, and Power BI integration.


14. Bonus Task: Incremental Loading:

		The mview_weekly_sales table supports incremental loading using a Stored Procedure (SP).
		This allows processing only new or updated data, improving efficiency.