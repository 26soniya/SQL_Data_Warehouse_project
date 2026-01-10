/*
===============================================================
CREATE Database & Schemas
===============================================================
Script Purpose:
  This script creates a new database names"Data_warehouse" after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionaly, the script sets up Three schemas within the database: 'bronze', 'silver', & 'gold'.

WARNING:
  Running this script will drop the entire "Data_warehouse" database if it already exists.
  All data in the databse will be permanently deleted. Proceed with Caution and ensure to have a proper backup before execution.
*/

USE master;
go

--Drop and recreate the "Data_warehouse" database
If Exists (select 1 from sys.databases where name = "Data_warehouse")
Begin
  Alter Database Data_Warehouse set single user with rollback immediate;
  Drop databse Data_warehouse;
End;
go

---create new "database" calles "Data_warehouse"
create database Data_warehouse;

Use Data_warehouse;

---create Schemas
create schema bronze;
go
create schema silver;
go
create schema gold;
go
