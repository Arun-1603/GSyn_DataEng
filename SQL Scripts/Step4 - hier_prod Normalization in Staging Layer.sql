-- Ensure staging schema exists
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'staging')  
BEGIN  
    EXEC('CREATE SCHEMA staging');  
END;
 
-- Create Department Table
CREATE TABLE staging.dept (
    dept_id VARCHAR(50) PRIMARY KEY,
    dept_label VARCHAR(100)
);
 
-- Create Category Table
CREATE TABLE staging.cat (
    cat_id VARCHAR(50) PRIMARY KEY,
    cat_label VARCHAR(100),
    dept_id VARCHAR(50) REFERENCES staging.dept(dept_id)
);
 
-- Create Subcategory Table
CREATE TABLE staging.subcat (
    subcat_id VARCHAR(50) PRIMARY KEY,
    subcat_label VARCHAR(100),
cat_id VARCHAR(50) REFERENCES staging.cat(cat_id)
);
 
-- Create Style Table
CREATE TABLE staging.styl (
    styl_id VARCHAR(50) PRIMARY KEY,
    styl_label VARCHAR(100),
    subcat_id VARCHAR(50) REFERENCES staging.subcat(subcat_id)
);
 
-- Create SKU Table
CREATE TABLE staging.sku (
    sku_id VARCHAR(50) PRIMARY KEY,
    sku_label VARCHAR(100),
    styl_id VARCHAR(50) REFERENCES staging.styl(styl_id)
);
 
-- Insert Department Data
INSERT INTO staging.dept (dept_id, dept_label)
SELECT DISTINCT dept_id, dept_label FROM raw.hier_prod;
 
-- Insert Category Data
INSERT INTO staging.cat (cat_id, cat_label, dept_id)
SELECT DISTINCT cat_id, cat_label, dept_id FROM raw.hier_prod;
 
-- Insert Subcategory Data
INSERT INTO staging.subcat (subcat_id, subcat_label, cat_id)
SELECT DISTINCT subcat_id, subcat_label, cat_id FROM raw.hier_prod;
 
-- Insert Style Data
INSERT INTO staging.styl (styl_id, styl_label, subcat_id)
SELECT DISTINCT styl_id, styl_label, subcat_id FROM raw.hier_prod;
 
-- Insert SKU Data
INSERT INTO staging.sku (sku_id, sku_label, styl_id)
SELECT DISTINCT sku_id, sku_label, styl_id FROM raw.hier_prod;