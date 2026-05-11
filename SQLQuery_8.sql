DROP TABLE IF EXISTS gold.dim_store;
DROP TABLE IF EXISTS gold.dim_account;
DROP TABLE IF EXISTS gold.fact_gl;
GO


CREATE VIEW gold.dim_store AS
SELECT
    sm.store_code,
    sm.store_name,
    sm.store_type,
    s.country,
    s.region
FROM silver.store_master sm
LEFT JOIN silver.store s ON sm.store_code = s.store_code;
GO

-- VIEW: dim_account
CREATE VIEW gold.dim_account AS
SELECT
    a.account_number,
    a.account_name,
    a.account_type,
    a.currency,
    am.PLLine        AS pl_line,
    am.StatementType AS statement_type,
    am.SortOrder     AS sort_order,
    am.Notes         AS notes
FROM silver.account a
LEFT JOIN silver.account_mapping am ON a.account_number = am.AccountNumber;
GO

-- VIEW: fact_gl
CREATE VIEW gold.fact_gl AS
SELECT
    transaction_id,
    transaction_date,
    store_code,
    account_number,
    amount_local,
    currency,
    document_number,
    [description]
FROM silver.gl_transaction;
GO

-- VERIFY
SELECT 'dim_store'   AS tbl, COUNT(*) AS rows FROM gold.dim_store  UNION ALL
SELECT 'dim_account' AS tbl, COUNT(*) AS rows FROM gold.dim_account UNION ALL
SELECT 'fact_gl'     AS tbl, COUNT(*) AS rows FROM gold.fact_gl;