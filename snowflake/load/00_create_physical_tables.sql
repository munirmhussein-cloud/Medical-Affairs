-- Round 7: Data Loading
-- Creates physical Snowflake tables only. No semantic view, Cortex Search service, or Agent.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

CREATE TABLE IF NOT EXISTS THERAPEUTIC_AREA (
  therapeutic_area_id STRING NOT NULL,
  therapeutic_area_name STRING NOT NULL,
  description STRING NOT NULL,
  PRIMARY KEY (therapeutic_area_id)
);

CREATE TABLE IF NOT EXISTS PRODUCT (
  product_id STRING NOT NULL,
  product_name STRING NOT NULL,
  therapeutic_area_id STRING NOT NULL,
  mechanism_summary STRING NOT NULL,
  lifecycle_status STRING NOT NULL,
  PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS INDICATION (
  indication_id STRING NOT NULL,
  product_id STRING NOT NULL,
  indication_name STRING NOT NULL,
  disease_area STRING NOT NULL,
  approval_status STRING NOT NULL,
  region STRING NOT NULL,
  PRIMARY KEY (indication_id)
);

CREATE TABLE IF NOT EXISTS STUDY (
  study_id STRING NOT NULL,
  study_name STRING NOT NULL,
  product_id STRING NOT NULL,
  indication_id STRING NOT NULL,
  phase STRING NOT NULL,
  study_design STRING NOT NULL,
  comparator STRING,
  n_patients NUMBER(10,0) NOT NULL,
  primary_endpoint_name STRING NOT NULL,
  study_status STRING NOT NULL,
  start_date DATE NOT NULL,
  completion_date DATE,
  publication_date DATE,
  evidence_tier STRING NOT NULL,
  PRIMARY KEY (study_id)
);

CREATE TABLE IF NOT EXISTS TREATMENT_ARM (
  treatment_arm_id STRING NOT NULL,
  study_id STRING NOT NULL,
  arm_name STRING NOT NULL,
  treatment_type STRING NOT NULL,
  n_patients NUMBER(10,0) NOT NULL,
  dosing_description STRING,
  PRIMARY KEY (treatment_arm_id)
);

CREATE TABLE IF NOT EXISTS PATIENT_POPULATION (
  population_id STRING NOT NULL,
  study_id STRING NOT NULL,
  population_name STRING NOT NULL,
  population_description STRING NOT NULL,
  n_patients NUMBER(10,0) NOT NULL,
  biomarker_status STRING,
  prior_therapy_status STRING,
  PRIMARY KEY (population_id)
);

CREATE TABLE IF NOT EXISTS EFFICACY_ENDPOINT (
  endpoint_id STRING NOT NULL,
  study_id STRING NOT NULL,
  treatment_arm_id STRING NOT NULL,
  population_id STRING NOT NULL,
  endpoint_name STRING NOT NULL,
  endpoint_type STRING NOT NULL,
  timepoint STRING NOT NULL,
  result_value NUMBER(10,3) NOT NULL,
  result_unit STRING NOT NULL,
  comparator_value NUMBER(10,3),
  delta_vs_comparator NUMBER(10,3),
  p_value NUMBER(18,8),
  confidence_interval STRING,
  source_document_id STRING NOT NULL,
  PRIMARY KEY (endpoint_id)
);

CREATE TABLE IF NOT EXISTS SAFETY_EVENT (
  safety_event_id STRING NOT NULL,
  study_id STRING NOT NULL,
  treatment_arm_id STRING NOT NULL,
  event_category STRING NOT NULL,
  event_term STRING NOT NULL,
  event_rate NUMBER(10,3) NOT NULL,
  serious_event_flag BOOLEAN NOT NULL,
  source_document_id STRING NOT NULL,
  PRIMARY KEY (safety_event_id)
);

-- Metadata table retains file_path for deterministic document materialization.
CREATE TABLE IF NOT EXISTS SCIENTIFIC_DOCUMENT_MANIFEST (
  document_id STRING NOT NULL,
  title STRING NOT NULL,
  document_type STRING NOT NULL,
  therapeutic_area_id STRING NOT NULL,
  product_id STRING,
  indication_id STRING,
  study_id STRING,
  publication_date DATE NOT NULL,
  effective_date DATE NOT NULL,
  expiration_date DATE,
  approval_status STRING NOT NULL,
  region STRING NOT NULL,
  source_type STRING NOT NULL,
  citation_label STRING NOT NULL,
  file_path STRING NOT NULL,
  synthetic_flag BOOLEAN NOT NULL,
  PRIMARY KEY (document_id)
);

CREATE TABLE IF NOT EXISTS DOCUMENT_CITATION (
  citation_id STRING NOT NULL,
  document_id STRING NOT NULL,
  citation_order NUMBER(10,0) NOT NULL,
  citation_text STRING NOT NULL,
  source_reference STRING,
  public_source_flag BOOLEAN NOT NULL,
  PRIMARY KEY (citation_id)
);

CREATE TABLE IF NOT EXISTS APPROVED_MEDICAL_RESPONSE (
  response_id STRING NOT NULL,
  document_id STRING NOT NULL,
  question_category STRING NOT NULL,
  approved_question STRING NOT NULL,
  approved_response_summary STRING NOT NULL,
  approval_status STRING NOT NULL,
  effective_date DATE NOT NULL,
  region STRING NOT NULL,
  PRIMARY KEY (response_id)
);

-- Raw line table used to preserve/reconstruct Markdown content in file order.
CREATE TABLE IF NOT EXISTS SCIENTIFIC_DOCUMENT_LINE (
  staged_file_name STRING NOT NULL,
  file_row_number NUMBER(38,0) NOT NULL,
  line_text STRING
);

-- Final document table consumed later by Cortex Search.
CREATE TABLE IF NOT EXISTS SCIENTIFIC_DOCUMENT (
  document_id STRING NOT NULL,
  title STRING NOT NULL,
  document_type STRING NOT NULL,
  therapeutic_area_id STRING NOT NULL,
  product_id STRING,
  indication_id STRING,
  study_id STRING,
  publication_date DATE NOT NULL,
  effective_date DATE NOT NULL,
  expiration_date DATE,
  approval_status STRING NOT NULL,
  region STRING NOT NULL,
  source_type STRING NOT NULL,
  citation_label STRING NOT NULL,
  content STRING NOT NULL,
  synthetic_flag BOOLEAN NOT NULL,
  PRIMARY KEY (document_id)
);
