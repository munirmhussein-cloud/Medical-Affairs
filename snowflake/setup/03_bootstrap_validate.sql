-- Round 5 — Snowflake Bootstrap Validation
-- Run after 00, 01, and 02. This script is read-only.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

-- Confirm session context.
SELECT CURRENT_ROLE() AS current_role,
       CURRENT_WAREHOUSE() AS current_warehouse,
       CURRENT_DATABASE() AS current_database,
       CURRENT_SCHEMA() AS current_schema;

-- Confirm role-visible objects.
SHOW WAREHOUSES LIKE 'MEDICAL_AFFAIRS_DEMO_WH';
SHOW DATABASES LIKE 'MEDICAL_AFFAIRS_AI';
SHOW SCHEMAS LIKE 'MEDICAL_AFFAIRS' IN DATABASE MEDICAL_AFFAIRS_AI;
SHOW FILE FORMATS IN SCHEMA MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS;
SHOW STAGES IN SCHEMA MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS;

-- Confirm internal stages are addressable by the demo role.
LIST @MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.STRUCTURED_DATA_STAGE;
LIST @MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.SCIENTIFIC_DOCUMENT_STAGE;
LIST @MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.METADATA_STAGE;

-- Expected Round 5 state:
-- * warehouse/database/schema exist
-- * CSV and JSON named file formats exist
-- * three internal stages exist and LIST succeeds
-- * no demo tables are required yet
-- * no semantic view exists yet
-- * no Cortex Search service exists yet
-- * no Cortex Agent exists yet
