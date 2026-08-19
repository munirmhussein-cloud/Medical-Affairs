-- Round 9: Demo-oriented Cortex Search queries.
-- These are intentionally business-facing and will later be invoked by the Cortex Agent.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

-- A. Search approved Phase III efficacy evidence for Aurelimab.
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
    'MEDICAL_SCIENTIFIC_SEARCH',
    '{
      "query": "What approved Phase III evidence describes clinical response, remission, and the patient populations with the largest treatment differences?",
      "columns": ["document_id","title","document_type","study_id","approval_status","citation_label","content"],
      "filter": {
        "@and": [
          {"@eq": {"approval_status": "APPROVED"}},
          {"@eq": {"product_id": "PRD-001"}},
          {"@eq": {"indication_id": "IND-001"}}
        ]
      },
      "limit": 5
    }'
  )
)['results'] AS results;

-- B. Search a specific study's approved evidence.
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
    'MEDICAL_SCIENTIFIC_SEARCH',
    '{
      "query": "biomarker-positive subgroup evidence",
      "columns": ["document_id","title","study_id","approval_status","citation_label","content"],
      "filter": {
        "@and": [
          {"@eq": {"approval_status": "APPROVED"}},
          {"@eq": {"study_id": "ST-302"}}
        ]
      },
      "limit": 3
    }'
  )
)['results'] AS results;

-- C. Search only approved US Medical Information content.
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
    'MEDICAL_SCIENTIFIC_SEARCH',
    '{
      "query": "efficacy evidence response",
      "columns": ["document_id","title","document_type","approval_status","region","citation_label","content"],
      "filter": {
        "@and": [
          {"@eq": {"approval_status": "APPROVED"}},
          {"@eq": {"document_type": "APPROVED_MEDICAL_RESPONSE"}},
          {"@eq": {"region": "US"}}
        ]
      },
      "limit": 3
    }'
  )
)['results'] AS results;
