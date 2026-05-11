USE WAREHOUSE;
GO 

CREATE TABLE silver.account (
    account_number  INT,
    account_name    NVARCHAR(100),
    account_type    NVARCHAR(50),
    currency        NVARCHAR(10)
);

CREATE TABLE silver.account_mapping 
(
    AccountNumber INT,
    Accountname NVARCHAR(50),
    Pline NVARCHAR(50),
    StatementType NVARCHAR(50),
    SortOrder INT,
    Notes NVARCHAR (100)
);

CREATE TABLE silver.store_master
(
    store_code NVARCHAR(50),
    store_name NVARCHAR(50),
    store_type NVARCHAR(50)
);

CREATE TABLE silver.store
(
    store_code NVARCHAR(50),
    country NVARCHAR(50),
    region NVARCHAR(50)
);

CREATE TABLE silver.gl_transaction
(
    transaction_id INT,
    transaction_date DATE,
    store_code NVARCHAR(10),
    account_number INT,
    amount_local FLOAT(50),
    currency NVARCHAR(10),
    document_number NVARCHAR(50),   
    [description] NVARCHAR(255)
);
GO


