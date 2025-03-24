CREATE PROCEDURE sp_incremental_load_mview_weekly_sales
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO refined.mview_weekly_sales AS target  
    USING (
        SELECT  
            cal.fsclwk_id,  
            fc.pos_site_id,  
            fc.sku_id,  
            fc.price_substate_id,  
            fc.type,  
            SUM(fc.sales_units) AS total_sales_units,  
            SUM(fc.sales_dollars) AS total_sales_dollars,  
            SUM(fc.discount_dollars) AS total_discount_dollars  
        FROM staging.fact_transactions_cleaned fc  
        JOIN staging.fscldt cal ON fc.fscldt_id = cal.fscldt_id  
        WHERE cal.fsclwk_id >= (SELECT MAX(fsclwk_id) FROM refined.mview_weekly_sales)  -- Process only new weeks  
        GROUP BY cal.fsclwk_id, fc.pos_site_id, fc.sku_id, fc.price_substate_id, fc.type  
    ) AS source  

    ON target.fsclwk_id = source.fsclwk_id  
    AND target.pos_site_id = source.pos_site_id  
    AND target.sku_id = source.sku_id  
    AND target.price_substate_id = source.price_substate_id  
    AND target.type = source.type  

    WHEN MATCHED THEN  
        UPDATE SET  
            target.total_sales_units = source.total_sales_units,  
            target.total_sales_dollars = source.total_sales_dollars,  
            target.total_discount_dollars = source.total_discount_dollars,  
            target.last_updated = GETDATE()  

    WHEN NOT MATCHED THEN  
        INSERT (fsclwk_id, pos_site_id, sku_id, price_substate_id, type, total_sales_units, total_sales_dollars, total_discount_dollars, last_updated)  
        VALUES (source.fsclwk_id, source.pos_site_id, source.sku_id, source.price_substate_id, source.type, source.total_sales_units, source.total_sales_dollars, source.total_discount_dollars, GETDATE());
END;
