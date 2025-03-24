-- Ensure staging schema exists
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'staging')  
BEGIN  
    EXEC('CREATE SCHEMA staging');  
END;

-- Create Fiscal Year Table
CREATE TABLE staging.fsclyr (
    fsclyr_id INT PRIMARY KEY,
    fsclyr_label VARCHAR(50)
);

-- Create Fiscal Quarter Table
CREATE TABLE staging.fsclqrtr (
    fsclqrtr_id INT PRIMARY KEY,
    fsclqrtr_label VARCHAR(50),
    fsclyr_id INT REFERENCES staging.fsclyr(fsclyr_id)
);

-- Create Fiscal Month Table
CREATE TABLE staging.fsclmth (
    fsclmth_id INT PRIMARY KEY,
    fsclmth_label VARCHAR(50),
    fsclqrtr_id INT REFERENCES staging.fsclqrtr(fsclqrtr_id)
);

-- Create Fiscal Week Table
CREATE TABLE staging.fsclwk (
    fsclwk_id INT PRIMARY KEY,
    fsclwk_label VARCHAR(50),
    fsclmth_id INT REFERENCES staging.fsclmth(fsclmth_id)
);

-- Create Fiscal Date Table
CREATE TABLE staging.fscldt (
    fscldt_id INT PRIMARY KEY,
    fscldt_label VARCHAR(50),
    fsclwk_id INT REFERENCES staging.fsclwk(fsclwk_id),
    fsclmth_id INT REFERENCES staging.fsclmth(fsclmth_id),
    fsclqrtr_id INT REFERENCES staging.fsclqrtr(fsclqrtr_id),
    fsclyr_id INT REFERENCES staging.fsclyr(fsclyr_id),
    date DATE
);

-- Insert Fiscal Year Data
INSERT INTO staging.fsclyr (fsclyr_id, fsclyr_label)
SELECT DISTINCT fsclyr_id, fsclyr_label FROM raw.hier_clnd;

-- Insert Fiscal Quarter Data
INSERT INTO staging.fsclqrtr (fsclqrtr_id, fsclqrtr_label, fsclyr_id)
SELECT DISTINCT fsclqrtr_id, fsclqrtr_label, fsclyr_id FROM raw.hier_clnd;

-- Insert Fiscal Month Data
INSERT INTO staging.fsclmth (fsclmth_id, fsclmth_label, fsclqrtr_id)
SELECT DISTINCT fsclmth_id, fsclmth_label, fsclqrtr_id FROM raw.hier_clnd;

-- Insert Fiscal Week Data
INSERT INTO staging.fsclwk (fsclwk_id, fsclwk_label, fsclmth_id)
SELECT DISTINCT fsclwk_id, fsclwk_label, fsclmth_id FROM raw.hier_clnd;

-- Insert Fiscal Date Data
INSERT INTO staging.fscldt (fscldt_id, fscldt_label, fsclwk_id, fsclmth_id, fsclqrtr_id, fsclyr_id, date)
SELECT DISTINCT fscldt_id, fscldt_label, fsclwk_id, fsclmth_id, fsclqrtr_id, fsclyr_id, date FROM raw.hier_clnd;