-- Round 5 — Snowflake Bootstrap
-- Creates warehouse, database, schema, named file formats, and internal stages.
-- Run with SYSADMIN (or an equivalent role that can create/manage these objects).

USE ROLE SYSADMIN;

CREATE WAREHOUSE IF NOT EXISTS MEDICAL_AFFAIRS_DEMO_WH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  COMMENT = 'Compute for synthetic Medical Affairs Decision Intelligence demo';

CREATE DATABASE IF NOT EXISTS MEDICAL_AFFAIRS_AI
  COMMENT = 'Synthetic Medical Affairs Decision Intelligence demo database';

CREATE SCHEMA IF NOT EXISTS MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS
  COMMENT = 'Synthetic structured and unstructured Medical Affairs demo assets';

USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

-- Structured CSV assets from data/structured/.
CREATE FILE FORMAT IF NOT EXISTS MEDICAL_AFFAIRS_CSV_FF
  TYPE = CSV
  PARSE_HEADER = TRUE
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  TRIM_SPACE = TRUE
  EMPTY_FIELD_AS_NULL = TRUE
  NULL_IF = ('', 'NULL', 'null')
  DATE_FORMAT = 'YYYY-MM-DD'
  ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE
  COMMENT = 'CSV file format for synthetic structured Medical Affairs demo datasets';

-- JSON configuration/metadata artifacts used by later build rounds.
CREATE FILE FORMAT IF NOT EXISTS MEDICAL_AFFAIRS_JSON_FF
  TYPE = JSON
  STRIP_OUTER_ARRAY = FALSE
  COMMENT = 'JSON file format for Medical Affairs demo metadata and configuration artifacts';

-- Internal stage for structured CSV data.
CREATE STAGE IF NOT EXISTS STRUCTURED_DATA_STAGE
  FILE_FORMAT = MEDICAL_AFFAIRS_CSV_FF
  DIRECTORY = (ENABLE = TRUE)
  COMMENT = 'Internal stage for synthetic structured Medical Affairs CSV datasets';

-- Internal stage for Markdown/text scientific evidence and manifests.
-- No default file format is assigned because the evidence corpus is retained as raw files
-- until Round 7 defines the deterministic document-loading pattern.
CREATE STAGE IF NOT EXISTS SCIENTIFIC_DOCUMENT_STAGE
  DIRECTORY = (ENABLE = TRUE)
  COMMENT = 'Internal stage for synthetic Medical Affairs scientific-document corpus';

-- Internal stage for JSON metadata/configuration artifacts when needed by later rounds.
CREATE STAGE IF NOT EXISTS METADATA_STAGE
  FILE_FORMAT = MEDICAL_AFFAIRS_JSON_FF
  DIRECTORY = (ENABLE = TRUE)
  COMMENT = 'Internal stage for synthetic Medical Affairs demo JSON metadata';
