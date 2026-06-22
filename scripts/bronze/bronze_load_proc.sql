/*
=========================================================
Load Bronze Layer (PostgreSQL Optimized)
=========================================================
Purpose:
    Load raw CSV data into Bronze layer tables,
    track execution metrics, and log progress.
=========================================================
*/

DO $$
DECLARE
    -- Variables to track execution timing and rows
    v_start_time TIMESTAMP;
    v_end_time   TIMESTAMP;
    v_row_count  INT;
BEGIN
    RAISE NOTICE '=========================================================';
    RAISE NOTICE ' Starting Bronze Layer Data Load';
    RAISE NOTICE '=========================================================';

    ---------------------------------------------------------
    -- 1. CRM Customer Information
    ---------------------------------------------------------
    v_start_time := NOW();
    RAISE NOTICE '>> Loading Table: bronze.crm_cust_info | Start Time: %', v_start_time;
    
    TRUNCATE TABLE bronze.crm_cust_info;
    
    COPY bronze.crm_cust_info (cst_id, cst_key, cst_firstname, cst_lastname, cst_material_status, cst_gndr, cst_create_date)
    FROM 'C:\Users\sashi\OneDrive\Desktop\SOURCE_DATA_CRM\cust_info.csv'
    DELIMITER ',' CSV HEADER;
    
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := NOW();
    RAISE NOTICE '>> Finished Table: bronze.crm_cust_info | End Time: % | Records Loaded: %', v_end_time, v_row_count;
    RAISE NOTICE '---------------------------------------------------------';


    ---------------------------------------------------------
    -- 2. CRM Product Information
    ---------------------------------------------------------
    v_start_time := NOW();
    RAISE NOTICE '>> Loading Table: bronze.crm_prd_info | Start Time: %', v_start_time;
    
    TRUNCATE TABLE bronze.crm_prd_info;
    
    COPY bronze.crm_prd_info (prd_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt)
    FROM 'C:\Users\sashi\OneDrive\Desktop\SOURCE_DATA_CRM\prd_info.csv'
    DELIMITER ',' CSV HEADER;
    
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := NOW();
    RAISE NOTICE '>> Finished Table: bronze.crm_prd_info | End Time: % | Records Loaded: %', v_end_time, v_row_count;
    RAISE NOTICE '---------------------------------------------------------';


    ---------------------------------------------------------
    -- 3. CRM Sales Details
    ---------------------------------------------------------
    v_start_time := NOW();
    RAISE NOTICE '>> Loading Table: bronze.crm_sales_details | Start Time: %', v_start_time;
    
    TRUNCATE TABLE bronze.crm_sales_details;
    
    COPY bronze.crm_sales_details (sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price)
    FROM 'C:\Users\sashi\OneDrive\Desktop\SOURCE_DATA_CRM\sales_details.csv'
    DELIMITER ',' CSV HEADER;
    
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := NOW();
    RAISE NOTICE '>> Finished Table: bronze.crm_sales_details | End Time: % | Records Loaded: %', v_end_time, v_row_count;
    RAISE NOTICE '---------------------------------------------------------';


    ---------------------------------------------------------
    -- 4. ERP Customer Information
    ---------------------------------------------------------
    v_start_time := NOW();
    RAISE NOTICE '>> Loading Table: bronze.erp_cust_az12 | Start Time: %', v_start_time;
    
    TRUNCATE TABLE bronze.erp_cust_az12;
    
    COPY bronze.erp_cust_az12 (cid, bdate, gen)
    FROM 'C:\Users\sashi\OneDrive\Desktop\SourceData_ERP\CUST_AZ12.csv'
    DELIMITER ',' CSV HEADER;
    
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := NOW();
    RAISE NOTICE '>> Finished Table: bronze.erp_cust_az12 | End Time: % | Records Loaded: %', v_end_time, v_row_count;
    RAISE NOTICE '---------------------------------------------------------';


    ---------------------------------------------------------
    -- 5. ERP Location Information
    ---------------------------------------------------------
    v_start_time := NOW();
    RAISE NOTICE '>> Loading Table: bronze.erp_loc_a101 | Start Time: %', v_start_time;
    
    TRUNCATE TABLE bronze.erp_loc_a101;
    
    COPY bronze.erp_loc_a101 (cid, cntry)
    FROM 'C:\Users\sashi\OneDrive\Desktop\SourceData_ERP\LOC_A101.csv'
    DELIMITER ',' CSV HEADER;
    
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := NOW();
    RAISE NOTICE '>> Finished Table: bronze.erp_loc_a101 | End Time: % | Records Loaded: %', v_end_time, v_row_count;
    RAISE NOTICE '---------------------------------------------------------';


    ---------------------------------------------------------
    -- 6. ERP Product Categories
    ---------------------------------------------------------
    v_start_time := NOW();
    RAISE NOTICE '>> Loading Table: bronze.erp_px_cat_g1v2 | Start Time: %', v_start_time;
    
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    
    COPY bronze.erp_px_cat_g1v2 (id, cat, subcat, maintenance)
    FROM 'C:\Users\sashi\OneDrive\Desktop\SourceData_ERP\PX_CAT_G1V2.csv'
    DELIMITER ',' CSV HEADER;
    
    GET DIAGNOSTICS v_row_count = ROW_COUNT;
    v_end_time := NOW();
    RAISE NOTICE '>> Finished Table: bronze.erp_px_cat_g1v2 | End Time: % | Records Loaded: %', v_end_time, v_row_count;
    
    RAISE NOTICE '=========================================================';
    RAISE NOTICE ' Bronze Layer Data Load Completed Successfully!';
    RAISE NOTICE '=========================================================';

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '=========================================================';
    RAISE NOTICE ' CRITICAL ERROR OCCURRED DURING LOAD PIPELINE!';
    RAISE NOTICE ' Error Message: %', SQLERRM;
    RAISE NOTICE '=========================================================';
    RAISE;
END $$;

-- ---------------------------------------------------------
-- Quick Data Validation Checks (Outside the transaction block)
-- ---------------------------------------------------------
SELECT 'crm_cust_info' AS table_name, COUNT(*) FROM bronze.crm_cust_info
UNION ALL
SELECT 'crm_prd_info', COUNT(*) FROM bronze.crm_prd_info
UNION ALL
SELECT 'crm_sales_details', COUNT(*) FROM bronze.crm_sales_details
UNION ALL
SELECT 'erp_cust_az12', COUNT(*) FROM bronze.erp_cust_az12
UNION ALL
SELECT 'erp_loc_a101', COUNT(*) FROM bronze.erp_loc_a101
UNION ALL
SELECT 'erp_px_cat_g1v2', COUNT(*) FROM bronze.erp_px_cat_g1v2;
