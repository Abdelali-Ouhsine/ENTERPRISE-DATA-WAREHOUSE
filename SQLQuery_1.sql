USE WAREHOUSE;
GO 

--Data Cleaning 

INSERT INTO silver.account(account_number,account_name,account_type,currency)
SELECT DISTINCT
    account_number,
    TRIM(account_name) AS account_name,
    TRIM(account_type) AS account_type,
    UPPER(TRIM(currency)) AS currency
    FROM bronze.account
    WHERE account_number IS NOT NULL;

    INSERT INTO silver.account_mapping(AccountNumber,AccountName,PLLine,StatementType, SortOrder, Notes)
    SELECT DISTINCT 
        AccountNumber, 
        TRIM(AccountName) AS AccountName,
        TRIM(PLLine) AS PLLine,
        REPLACE(TRIM(StatementType), 'P L', 'P&L') AS StatementType,
        sortOrder,
        COALESCE(NULLIF(TRIM(Notes), ''), 'N/A') AS Notes
        FROM (
            SELECT *,
            ROW_NUMBER() OVER (PARTITION BY AccountNumber ORDER BY AccountNumber) AS rn
            FROM bronze.account_mapping
            WHERE AccountNumber IS NOT NULL
        ) t 
        WHERE rn = 1

        INSERT INTO silver.store_master(store_code,store_name, store_type)
        SELECT DISTINCT 
        UPPER(TRIM(store_code)) AS store_code,
        TRIM(store_name) AS store_name,
        TRIM(store_type) AS store_type

        FROM (
            SELECT *,
            ROW_NUMBER() OVER(PARTITION BY store_code ORDER BY store_code) AS rn
            FROM bronze.store_master
            WHERE store_code IS NOT NULL
        ) t
        WHERE rn = 1

        INSERT INTO silver.store(store_code, country, region)
        SELECT
        UPPER(TRIM(store_code)) AS store_code,
        TRIM(country) AS country,
        COALESCE(NULLIF(TRIM(region), ''), 'Unknown') AS region

        FROM (
            SELECT *,
            ROW_NUMBER() OVER(PARTITION BY store_code ORDER BY store_code) AS rn
            FROM bronze.store 
            WHERE store_code IS NOT NULL
        ) t
        WHERE rn = 1

        INSERT INTO silver.gl_transaction(transaction_id, transaction_date, store_code, account_number, amount_local, currency, document_number, [description])
        SELECT
            transaction_id,
            CAST(transaction_date AS DATE) AS transaction_date,
            UPPER(TRIM(store_code)) AS store_code,
            account_number,
            amount_local,
            UPPER(currency) AS currency,
            TRIM(document_number) AS document_number,
            TRIM([description]) AS [description]
        FROM (
            SELECT *,
            ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_id) AS rn 
            FROM bronze.gl_transaction
            WHERE transaction_id IS NOT NULL
        )t 
        WHERE rn = 1