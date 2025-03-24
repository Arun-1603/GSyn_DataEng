-- Ensure refined schema exists
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'refined')  
BEGIN  
    EXEC('CREATE SCHEMA refined');  
END;

---Step 1: Create mview_weekly_sales Table
CREATE TABLE refined.mview_weekly_sales (
    fsclwk_id INT,
    pos_site_id VARCHAR(50),
    sku_id VARCHAR(50),
    price_substate_id VARCHAR(50),
    type VARCHAR(50),
    total_sales_units INT,
    total_sales_dollars DECIMAL(18,2),
    total_discount_dollars DECIMAL(18,2),
    last_updated DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (fsclwk_id, pos_site_id, sku_id, price_substate_id, type)
);

--Step 2: Aggregate & Insert Data into mview_weekly_sales
INSERT INTO refined.mview_weekly_sales
SELECT  
    cal.fsclwk_id,  
    fc.pos_site_id,  
    fc.sku_id,  
    fc.price_substate_id,  
    fc.type,  
    SUM(fc.sales_units) AS total_sales_units,  
    SUM(fc.sales_dollars) AS total_sales_dollars,  
    SUM(fc.discount_dollars) AS total_discount_dollars,  
    GETDATE() AS last_updated  
FROM staging.fact_transactions_cleaned fc  
JOIN staging.fscldt cal ON fc.fscldt_id = cal.fscldt_id  
GROUP BY cal.fsclwk_id, fc.pos_site_id, fc.sku_id, fc.price_substate_id, fc.type;

---Verify aggregated data (check row counts & sums).
SELECT COUNT(*) AS total_rows FROM refined.mview_weekly_sales;

SELECT 
    SUM(total_sales_units) AS total_units, 
    SUM(total_sales_dollars) AS total_dollars, 
    SUM(total_discount_dollars) AS total_discounts  
FROM refined.mview_weekly_sales;




