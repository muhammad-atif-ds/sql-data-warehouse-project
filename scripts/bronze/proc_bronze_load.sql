/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;	;
	BEGIN TRY
		PRINT '===============================';
		PRINT 'Loading bronze layer';
		PRINT '===============================';

		PRINT '----------------- --------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '-------------------------------';


		SET @batch_start_time = GETDATE();
		SET @start_time = GETDATE();
		PRINT '>> Truncating bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\My Folder\Learning\Data Engineering\5. Notes\8. ETL\2. sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIELDTERMINATOR = ',',
			FIRSTROW = 2,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Time Taken: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(10)) + ' seconds';
		PRINT '-------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\My Folder\Learning\Data Engineering\5. Notes\8. ETL\2. sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIELDTERMINATOR = ',',
			FIRSTROW = 2,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Time Taken: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(10)) + ' seconds';
		PRINT '-------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\My Folder\Learning\Data Engineering\5. Notes\8. ETL\2. sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIELDTERMINATOR = ',',
			FIRSTROW = 2,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Time Taken: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(10)) + ' seconds';
		PRINT '-------------------------------';



		PRINT '-------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '-------------------------------';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'E:\My Folder\Learning\Data Engineering\5. Notes\8. ETL\2. sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIELDTERMINATOR = ',',
			FIRSTROW = 2,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Time Taken: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(10)) + ' seconds';
		PRINT '-------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'E:\My Folder\Learning\Data Engineering\5. Notes\8. ETL\2. sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIELDTERMINATOR = ',',
			FIRSTROW = 2,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Time Taken: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(10)) + ' seconds';
		PRINT '-------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'E:\My Folder\Learning\Data Engineering\5. Notes\8. ETL\2. sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIELDTERMINATOR = ',',
			FIRSTROW = 2,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Time Taken: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(10)) + ' seconds';
		PRINT '-------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '================================';
		PRINT 'Bronze layer load completed successfully';
		PRINT '>> Total Time Taken for Batch: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR(10)) + ' seconds';
		PRINT '================================';

	END TRY
	BEGIN CATCH
		PRINT '===================================='
		PRINT 'Error Occured While Loading Bronze Layer'
		PRINT 'Error Message: ' + ERROR_MESSAGE()
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10))
		PRINT '===================================='
	END CATCH
END