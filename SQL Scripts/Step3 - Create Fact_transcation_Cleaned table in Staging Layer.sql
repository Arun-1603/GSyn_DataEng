---Create staging.fact_transactions_cleaned (Optimized Table with Primary Key & Indexing)
CREATE TABLE staging.fact_transactions_cleaned(
    order_id BIGINT,
    line_id INT,
    type VARCHAR(50),
    dt DATETIME,
    pos_site_id VARCHAR(50),
    sku_id VARCHAR(50),
    fscldt_id INT,
    price_substate_id VARCHAR(50),
    sales_units INT,
    sales_dollars DECIMAL(18,2),
    discount_dollars DECIMAL(18,2),
    original_order_id BIGINT NULL,
    original_line_id INT NULL,
    PRIMARY KEY (order_id, line_id)
);

---Identity Duplicates in raw.fact_transactions
SELECT order_id, line_id, COUNT(*) AS duplicate_count
FROM raw.fact_transactions
GROUP BY order_id, line_id
HAVING COUNT(*) > 1;

---Remove Duplicates from raw.fact_transactions
WITH cte AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY order_id, line_id ORDER BY dt DESC) AS row_num
    FROM raw.fact_transactions
)
DELETE FROM cte WHERE row_num > 1;

---Insert Only Unique Rows into staging.fact_transactions_cleaned
INSERT INTO staging.fact_transactions_cleaned
SELECT * FROM raw.fact_transactions AS raw
WHERE NOT EXISTS (
    SELECT 1 FROM staging.fact_transactions_cleaned AS staging
    WHERE staging.order_id = raw.order_id 
    AND staging.line_id = raw.line_id
);

