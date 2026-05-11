USE WAREHOUSE;

TRUNCATE TABLE bronze.account;
TRUNCATE TABLE bronze.account_mapping;
TRUNCATE TABLE bronze.store_master;
TRUNCATE TABLE bronze.store;
TRUNCATE TABLE bronze.gl_transaction;
GO

BULK INSERT bronze.account
FROM '/var/opt/mssql/account.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);

BULK INSERT bronze.account_mapping
FROM '/var/opt/mssql/account_mapping.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);

BULK INSERT bronze.store_master
FROM '/var/opt/mssql/store_master.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);

BULK INSERT bronze.store
FROM '/var/opt/mssql/store.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);

BULK INSERT bronze.gl_transaction
FROM '/var/opt/mssql/transaction.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\n', TABLOCK);
GO

-- Verify
SELECT 'account' AS tbl, COUNT(*) AS rows FROM bronze.account UNION ALL
SELECT 'account_mapping', COUNT(*) FROM bronze.account_mapping UNION ALL
SELECT 'store_master', COUNT(*) FROM bronze.store_master UNION ALL
SELECT 'store', COUNT(*) FROM bronze.store UNION ALL
SELECT 'gl_transaction', COUNT(*) FROM bronze.gl_transaction;50 