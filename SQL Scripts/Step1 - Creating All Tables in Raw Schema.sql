-- Ensure refined schema exists
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'raw')  
BEGIN  
    EXEC('CREATE SCHEMA raw');  
END;

-- Fact Transactions Table
CREATE TABLE raw.fact_transactions (
    order_id BIGINT,
    line_id INT,
    type VARCHAR(50),
    dt DATETIME,
    pos_site_id VARCHAR(50),
    sku_id VARCHAR(50),
    fscldt_id INT,
    price_substate_id VARCHAR(50),
    sales_units INT,
    sales_dollars FLOAT,
    discount_dollars FLOAT,
    original_order_id BIGINT NULL,
    original_line_id INT NULL
);
-- Fact Average Costs Table
CREATE TABLE raw.fact_averagecosts (
    fscldt_id INT,
    sku_id VARCHAR(50),
    average_unit_standardcost FLOAT,
    average_unit_landedcost FLOAT
);
 
-- Dimension Tables
CREATE TABLE raw.hier_clnd (
    fscldt_id INT PRIMARY KEY,
    fscldt_label VARCHAR(50),
    fsclwk_id INT,
    fsclwk_label VARCHAR(50),
    fsclmth_id INT,
    fsclmth_label VARCHAR(50),
    fsclqrtr_id INT,
    fsclqrtr_label VARCHAR(50),
    fsclyr_id INT,
    fsclyr_label VARCHAR(50),
    ssn_id VARCHAR(50),
    ssn_label VARCHAR(50),
    ly_fscldt_id INT,
    lly_fscldt_id INT,
    fscldow INT,
    fscldom INT,
    fscldoq INT,
    fscldoy INT,
    fsclwoy INT,
    fsclmoy INT,
    fsclqoy INT,
    date DATE
);
 
CREATE TABLE raw.hier_hldy (
    hldy_id VARCHAR(50) PRIMARY KEY,
    hldy_label VARCHAR(255)
);
 
CREATE TABLE raw.hier_invloc (
    loc INT PRIMARY KEY,
    loc_label VARCHAR(100),
    loctype VARCHAR(50),
    loctype_label VARCHAR(50)
);
 
CREATE TABLE raw.hier_invstatus (
    code_id VARCHAR(50) PRIMARY KEY,
    code_label VARCHAR(50),
    bckt_id VARCHAR(50),
    bckt_label VARCHAR(50),
    ownrshp_id VARCHAR(50),
    ownrshp_label VARCHAR(50)
);
 
CREATE TABLE raw.hier_possite (
    site_id VARCHAR(50) PRIMARY KEY,
    site_label VARCHAR(100),
    subchnl_id VARCHAR(50),
    subchnl_label VARCHAR(100),
    chnl_id VARCHAR(50),
    chnl_label VARCHAR(100)
);
 
CREATE TABLE raw.hier_pricestate (
    substate_id VARCHAR(50) PRIMARY KEY,
    substate_label VARCHAR(100),
    state_id VARCHAR(50),
    state_label VARCHAR(100)
);
 
CREATE TABLE raw.hier_prod (
    sku_id VARCHAR(50) PRIMARY KEY,
    sku_label VARCHAR(100),
    stylclr_id VARCHAR(50),
    stylclr_label VARCHAR(100),
    styl_id VARCHAR(50),
    styl_label VARCHAR(100),
    subcat_id VARCHAR(50),
    subcat_label VARCHAR(100),
    cat_id VARCHAR(50),
    cat_label VARCHAR(100),
    dept_id VARCHAR(50),
    dept_label VARCHAR(100),
    issvc INT,
    isasmbly INT,
    isnfs INT
);
 
CREATE TABLE raw.hier_rtlloc (
    str VARCHAR(50) PRIMARY KEY,
    str_label VARCHAR(100),
    dstr VARCHAR(50),
    dstr_label VARCHAR(100),
    rgn VARCHAR(50),
    rgn_label VARCHAR(100)
);