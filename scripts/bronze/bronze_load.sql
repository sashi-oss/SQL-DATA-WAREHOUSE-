/*
=========================================================
Load Bronze Layer
=========================================================
Purpose:
    Load raw CSV data into Bronze layer tables
    and validate the load process.
=========================================================
*/

-- CRM Customer Information

TRUNCATE TABLE bronze.crm_cust_info;

COPY bronze.crm_cust_info
FROM 'C:\Users\sashi\OneDrive\Desktop\SOURCE_DATA_CRM\cust_info.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) AS crm_cust_info_records
FROM bronze.crm_cust_info;

SELECT *
FROM bronze.crm_cust_info
LIMIT 10;


-- CRM Product Information

TRUNCATE TABLE bronze.crm_prd_info;

COPY bronze.crm_prd_info
FROM 'C:\Users\sashi\OneDrive\Desktop\SOURCE_DATA_CRM\prd_info.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) AS crm_prd_info_records
FROM bronze.crm_prd_info;

SELECT *
FROM bronze.crm_prd_info
LIMIT 10;


-- CRM Sales Details

TRUNCATE TABLE bronze.crm_sales_details;

COPY bronze.crm_sales_details
FROM 'C:\Users\sashi\OneDrive\Desktop\SOURCE_DATA_CRM\sales_details.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) AS crm_sales_details_records
FROM bronze.crm_sales_details;

SELECT *
FROM bronze.crm_sales_details
LIMIT 10;


-- ERP Customer Information

TRUNCATE TABLE bronze.erp_cust_az12;

COPY bronze.erp_cust_az12
FROM 'C:\Users\sashi\OneDrive\Desktop\SourceData_ERP\CUST_AZ12.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) AS erp_cust_az12_records
FROM bronze.erp_cust_az12;

SELECT *
FROM bronze.erp_cust_az12
LIMIT 10;


-- ERP Location Information

TRUNCATE TABLE bronze.erp_loc_a101;

COPY bronze.erp_loc_a101
FROM 'C:\Users\sashi\OneDrive\Desktop\SourceData_ERP\LOC_A101.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) AS erp_loc_a101_records
FROM bronze.erp_loc_a101;

SELECT *
FROM bronze.erp_loc_a101
LIMIT 10;


-- ERP Product Categories

TRUNCATE TABLE bronze.erp_px_cat_g1v2;

COPY bronze.erp_px_cat_g1v2
FROM 'C:\Users\sashi\OneDrive\Desktop\SourceData_ERP\PX_CAT_G1V2.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) AS erp_px_cat_g1v2_records
FROM bronze.erp_px_cat_g1v2;

SELECT *
FROM bronze.erp_px_cat_g1v2
LIMIT 10;
