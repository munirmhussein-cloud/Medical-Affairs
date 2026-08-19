-- Round 9: Create governed Cortex Search service over the native scientific-document corpus.
-- All documents remain indexed, including DRAFT content, so governance can be demonstrated
-- through attribute filtering at query time rather than by silently removing non-approved data.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

CREATE OR REPLACE CORTEX SEARCH SERVICE MEDICAL_SCIENTIFIC_SEARCH
  ON content
  PRIMARY KEY (document_id)
  ATTRIBUTES approval_status, document_type, study_id, product_id, indication_id, region
  WAREHOUSE = MEDICAL_AFFAIRS_DEMO_WH
  TARGET_LAG = '1 hour'
  REFRESH_MODE = INCREMENTAL
  INITIALIZE = ON_CREATE
  REQUEST_LOGGING = TRUE
  COMMENT = 'Governed semantic retrieval over the synthetic Medical Affairs scientific-document corpus'
AS
SELECT
  document_id,
  title,
  document_type,
  therapeutic_area_id,
  product_id,
  indication_id,
  study_id,
  publication_date,
  effective_date,
  expiration_date,
  approval_status,
  region,
  source_type,
  citation_label,
  content,
  synthetic_flag
FROM SCIENTIFIC_DOCUMENT;
