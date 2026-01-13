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
===============================================================================
*/
Create or Alter Procedure bronze.load_bronze as
Begin

	Declare @start_time Datetime, @end_time Datetime,@batch_start_time Datetime, @batch_end_time datetime;
	Begin try
		
		set @batch_start_time = GETDATE();
		Print '============================================';
		Print 'Loading Bronze layer';
		Print '============================================';

		Print '--------------------------------------------';
		Print 'Loading CRM Tables';
		Print '--------------------------------------------';

		set @start_time = GETDATE();
		Print '>>> Truncating Table: bronze.crm_cust_info'; 
		Truncate Table bronze.crm_cust_info;

		Print '>>> Inserting Data into Table: bronze.crm_cust_info';
		BULK insert bronze.crm_cust_info
		From 'C:\Users\Admin\Documents\My_DWH_Sql-Project\datasets\source_crm\cust_info.csv'
		WITH (
			FirstRow = 2,
			FielDterminator = ',',
			TabLock
		);
		set @end_time = GETDATE();
		Print '>> Load Duration: ' + cast(Datediff(second, @start_time, @end_time) as Nvarchar) + ' sec'
		Print '>> ---------------------';
		-- select * from bronze.crm_cust_info;

		-- select count(*) from bronze.crm_cust_info;

		set @start_time = GETDATE();
		Print '>>> Truncating Table: bronze.crm_prd_info';
		Truncate Table bronze.crm_prd_info;

		Print '>>> Inserting Data into Table: bronze.crm_prd_info';
		BULK insert bronze.crm_prd_info
		From 'C:\Users\Admin\Documents\My_DWH_Sql-Project\datasets\source_crm\prd_info.csv'
		WITH (
			FirstRow = 2,
			FielDterminator = ',',
			TabLock
		);
		set @end_time = GETDATE();
		Print '>> Load Duration: ' + cast(Datediff(second, @start_time, @end_time) as Nvarchar) + ' sec'
		Print '>> ---------------------';

		-- select * from bronze.crm_prd_info;

		set @start_time = GETDATE();
		Print '>>> Truncating Table: bronze.crm_sales_details';
		Truncate Table bronze.crm_sales_details;

		Print '>>> Inserting Data into Table: bronze.crm_sales_details';
		BULK insert bronze.crm_sales_details
		From 'C:\Users\Admin\Documents\My_DWH_Sql-Project\datasets\source_crm\sales_details.csv'
		WITH (
			FirstRow = 2,
			FielDterminator = ',',
			TabLock
		);
		set @end_time = GETDATE();
		Print '>> Load Duration: ' + cast(Datediff(second, @start_time, @end_time) as Nvarchar) + ' sec'
		Print '>> ---------------------';
		-- select * from bronze.crm_sales_details;

		Print '--------------------------------------------';
		Print 'Loading ERP Tables';
		Print '--------------------------------------------';

		set @start_time = GETDATE();
		Print '>>> Truncating Table: bronze.erp_loc_a101';
		Truncate Table bronze.erp_loc_a101;

		Print '>>> Inserting Data into Table: bronze.erp_loc_a101';
		BULK insert bronze.erp_loc_a101
		From 'C:\Users\Admin\Documents\My_DWH_Sql-Project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FirstRow = 2,
			FielDterminator = ',',
			TabLock
		);
		 
		 set @end_time = GETDATE();
		Print '>> Load Duration: ' + cast(Datediff(second, @start_time, @end_time) as Nvarchar) + ' sec'
		Print '>> ---------------------';

		-- select * from bronze.erp_loc_a101;

		set @start_time = GETDATE();
		Print '>>> Truncating Table: bronze.erp_cust_az12';
		Truncate Table bronze.erp_cust_az12;

		Print '>>> Inserting Data into Table: bronze.erp_cust_az12';
		BULK insert bronze.erp_cust_az12
		From 'C:\Users\Admin\Documents\My_DWH_Sql-Project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FirstRow = 2,
			FielDterminator = ',',
			TabLock
		);
		set @end_time = GETDATE();
		Print '>> Load Duration: ' + cast(Datediff(second, @start_time, @end_time) as Nvarchar) + ' sec'
		Print '>> ---------------------';
		-- select * from bronze.erp_cust_az12;

		set @start_time = GETDATE();
		Print '>>> Truncating Table: bronze.erp_px_cat_g1v2';
		Truncate Table bronze.erp_px_cat_g1v2;

		Print '>>> Inserting Data into Table: bronze.erp_px_cat_g1v2';
		BULK insert bronze.erp_px_cat_g1v2
		From 'C:\Users\Admin\Documents\My_DWH_Sql-Project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FirstRow = 2,
			FielDterminator = ',',
			TabLock
		);
		set @end_time = GETDATE();
		Print '>> Load Duration: ' + cast(Datediff(second, @start_time, @end_time) as Nvarchar) + ' sec'
		Print '>> ---------------------';
		-- select * from bronze.erp_px_cat_g1v2;

		set @batch_end_time = GETDATE();
		Print '=============================================='
		Print 'Loading... Bronze Layer is Completed';
		Print '  -Total Load Duration: ' + Cast (Datediff(second, @batch_start_time, @batch_end_time) As NVarchar) + ' seconds';
		Print '=============================================='

	End Try
	Begin Catch
		Print '==============================================';
		Print 'Error Occured During Loading Bronze Layer';
		print 'Error Message' + Error_Message();
		print 'Error Message' + Cast(Error_Number() As NVarchar);
		print 'Error Message' + Cast(Error_State() As NVarchar);
		Print '==============================================';
	End Catch
End

/*
======================================================================
  Usage Example:
    EXEC bronze.load_bronze;
*/
