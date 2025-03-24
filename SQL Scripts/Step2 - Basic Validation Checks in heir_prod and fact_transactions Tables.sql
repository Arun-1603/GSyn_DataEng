---Validation for raw.hier_prod Table---> Passed All Checks
---1)Non-null checks for primary keys  -->Done
SELECT * FROM raw.hier_prod
WHERE sku_id IS NULL;
 
---2)Uniqueness Check for Primary Key (sku_id)  -->Done
SELECT sku_id, COUNT(*)
FROM raw.hier_prod
GROUP BY sku_id
HAVING COUNT(*) > 1;
 
---3)Data Type Check (ensure no empty strings)  -->Done
SELECT * FROM raw.hier_prod
WHERE sku_id = '' 
   OR styl_id = '' 
   OR subcat_id = '' 
   OR cat_id = '' 
   OR dept_id = '';
 
 
---Validation for raw.fact_transactions
---1)Non-null Check for Primary Key (order_id, line_id): Since the primary key is a composite of order_id and line_id  -->Done
SELECT *
FROM raw.fact_transactions
WHERE order_id IS NULL OR line_id IS NULL;
 
---2)Uniqueness Check for Primary Key (order_id, line_id)   -->Done
SELECT order_id, line_id, COUNT(*)
FROM raw.fact_transactions
GROUP BY order_id, line_id
HAVING COUNT(*) > 1;
 
---3)Data Type Check
----3a)Ensure sales_units is not negative  -->Done
 
SELECT * FROM raw.fact_transactions WHERE sales_units < 0;
 
----3b)Ensure sales_dollars and discount_dollars are not negative  -->Failed(Has Negative Sales_dollars) But Okay
SELECT *
FROM raw.fact_transactions
WHERE sales_dollars < 0 OR discount_dollars < 0;
 
----3c)Ensure dt is a valid datetime  -->Done
SELECT * FROM raw.fact_transactions WHERE ISDATE(dt) = 0;
 
---4)Foreign Key Constraint Check
----4a)Ensure sku_id exists in hier_prod  -->Done
SELECT f.*
FROM raw.fact_transactions f
LEFT JOIN raw.hier_prod h ON f.sku_id = h.sku_id
WHERE h.sku_id IS NULL;
 
----4b)Ensure pos_site_id exists in hier_posite  -->Done
SELECT f.*
FROM raw.fact_transactions f
LEFT JOIN raw.hier_possite p ON f.pos_site_id = p.site_id
WHERE p.site_id IS NULL;
 
----4c)Ensure fscldt_id exists in hier_clnd  -->Done
SELECT f.*
FROM raw.fact_transactions f
LEFT JOIN raw.hier_clnd c ON f.fscldt_id = c.fscldt_id
WHERE f.fscldt_id IS NULL;
 
----4d)Ensure price_substate_id exists in hier_prestates  --> Done
SELECT f.*
FROM raw.fact_transactions f
LEFT JOIN raw.hier_pricestate ps ON f.price_substate_id = ps.substate_id
WHERE ps.substate_id IS NULL;
 