-- Round 9: Validate Cortex Search service configuration and governed retrieval behavior.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

-- Service metadata and indexing/serving state.
DESCRIBE CORTEX SEARCH SERVICE MEDICAL_SCIENTIFIC_SEARCH;

-- Inspect materialized index contents for validation/debugging.
SELECT *
FROM TABLE(CORTEX_SEARCH_DATA_SCAN(
  SERVICE_NAME => 'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_SCIENTIFIC_SEARCH'
))
ORDER BY document_id;

-- 1. Approved-only efficacy retrieval for Aurelimab / IND-001.
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_SCIENTIFIC_SEARCH',
    '{
      "query": "Phase III efficacy evidence and patient populations with the largest treatment differences",
      "columns": ["document_id","title","document_type","study_id","product_id","indication_id","approval_status","region","citation_label","content"],
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
)['results'] AS approved_efficacy_results;

-- 2. Study-specific retrieval should surface the AURORA-302 evidence package.
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_SCIENTIFIC_SEARCH',
    '{
      "query": "biomarker-positive subgroup clinical response treatment difference",
      "columns": ["document_id","title","document_type","study_id","approval_status","citation_label","content"],
      "filter": {
        "@and": [
          {"@eq": {"approval_status": "APPROVED"}},
          {"@eq": {"study_id": "ST-302"}}
        ]
      },
      "limit": 5
    }'
  )
)['results'] AS aurora_302_results;

-- 3. Medical Information response retrieval by document type and US region.
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_SCIENTIFIC_SEARCH',
    '{
      "query": "approved Medical Affairs efficacy response for Phase III evidence",
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
)['results'] AS approved_medical_response_results;

-- 4. Governance proof: querying the development-stage Neravilimab program WITH an APPROVED
-- filter should not return DOC-NOVA-220-DRAFT because its approval_status is DRAFT.
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_SCIENTIFIC_SEARCH',
    '{
      "query": "NOVA-220 efficacy results and clinical response",
      "columns": ["document_id","title","study_id","product_id","approval_status","content"],
      "filter": {
        "@and": [
          {"@eq": {"approval_status": "APPROVED"}},
          {"@eq": {"product_id": "PRD-002"}}
        ]
      },
      "limit": 5
    }'
  )
)['results'] AS approved_nova_results;

-- 5. Governance contrast: DRAFT is deliberately indexed and can be retrieved only when
-- the caller explicitly requests DRAFT content. This makes the control visible in the demo.
SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_SCIENTIFIC_SEARCH',
    '{
      "query": "NOVA-220 interim development note",
      "columns": ["document_id","title","study_id","product_id","approval_status","content"],
      "filter": {
        "@and": [
          {"@eq": {"approval_status": "DRAFT"}},
          {"@eq": {"study_id": "ST-220"}}
        ]
      },
      "limit": 5
    }'
  )
)['results'] AS draft_nova_results;
