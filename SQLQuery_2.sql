USE WAREHOUSE;
GO

-- Bronze Tables
CREATE TABLE bronze.account (
    account_number  INT,
    account_name    NVARCHAR(100),
    account_type    NVARCHAR(50),
    currency        NVARCHAR(10)
);

USE WAREHOUSE;

SELECT TABLE_SCHEMA, TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'bronze'
ORDER BY TABLE_NAME;

CREATE TABLE bronze.account_mapping (
    AccountNumber   INT,
    AccountName     NVARCHAR(100),
    PLLine          NVARCHAR(100),
    StatementType   NVARCHAR(50),
    SortOrder       FLOAT,
    Notes           NVARCHAR(255)
);

CREATE TABLE bronze.store_master (
    store_code  NVARCHAR(10),
    store_name  NVARCHAR(100),
    store_type  NVARCHAR(50)
);

CREATE TABLE bronze.store (
    store_code  NVARCHAR(10),
    country     NVARCHAR(50),
    region      NVARCHAR(50)
);

CREATE TABLE bronze.gl_transaction (
    transaction_id      INT,
    transaction_date    DATE,
    store_code          NVARCHAR(10),
    account_number      INT,
    amount_local        FLOAT,
    currency            NVARCHAR(10),
    document_number     NVARCHAR(50),
    description         NVARCHAR(255)
);
GO

-- Load Data
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
--SELECT 'account' AS tbl, COUNT(*) AS rows FROM bronze.account UNION ALL
--SELECT 'account_mapping', COUNT(*) FROM bronze.account_mapping UNION ALL
--SELECT 'store_master', COUNT(*) FROM bronze.store_master UNION ALL
--SELECT 'store', COUNT(*) FROM bronze.store UNION ALL
--SELECT 'gl_transaction', COUNT(*) FROM bronze.gl_transaction;