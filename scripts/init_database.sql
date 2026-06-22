/*
=========================================================
Data Warehouse Initialization Script
=========================================================
Database : datawarehouse

Schemas:
  - bronze : Raw source data
  - silver : Cleaned and transformed data
  - gold   : Business-ready analytical data
=========================================================
*/

-- Create Schemas

CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;

-- Add Schema Descriptions

COMMENT ON SCHEMA bronze IS 'Raw source data layer';
COMMENT ON SCHEMA silver IS 'Cleaned and transformed data layer';
COMMENT ON SCHEMA gold IS 'Business-ready analytical data layer';

-- Verify Schema Creation

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name IN ('bronze', 'silver', 'gold')
ORDER BY schema_name;
