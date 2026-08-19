-- Round 7: Validate native Snowflake materialization.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

-- Row-count inventory. Expected minimums reflect the Round 3/4 source corpus.
SELECT 'THERAPEUTIC_AREA' AS object_name, COUNT(*) AS row_count FROM THERAPEUTIC_AREA
UNION ALL SELECT 'PRODUCT', COUNT(*) FROM PRODUCT
UNION ALL SELECT 'INDICATION', COUNT(*) FROM INDICATION
UNION ALL SELECT 'STUDY', COUNT(*) FROM STUDY
UNION ALL SELECT 'TREATMENT_ARM', COUNT(*) FROM TREATMENT_ARM
UNION ALL SELECT 'PATIENT_POPULATION', COUNT(*) FROM PATIENT_POPULATION
UNION ALL SELECT 'EFFICACY_ENDPOINT', COUNT(*) FROM EFFICACY_ENDPOINT
UNION ALL SELECT 'SAFETY_EVENT', COUNT(*) FROM SAFETY_EVENT
UNION ALL SELECT 'SCIENTIFIC_DOCUMENT_MANIFEST', COUNT(*) FROM SCIENTIFIC_DOCUMENT_MANIFEST
UNION ALL SELECT 'DOCUMENT_CITATION', COUNT(*) FROM DOCUMENT_CITATION
UNION ALL SELECT 'APPROVED_MEDICAL_RESPONSE', COUNT(*) FROM APPROVED_MEDICAL_RESPONSE
UNION ALL SELECT 'SCIENTIFIC_DOCUMENT', COUNT(*) FROM SCIENTIFIC_DOCUMENT;

-- All manifest rows should have materialized content.
SELECT m.document_id, m.file_path
FROM SCIENTIFIC_DOCUMENT_MANIFEST m
LEFT JOIN SCIENTIFIC_DOCUMENT d ON d.document_id = m.document_id
WHERE d.document_id IS NULL OR LENGTH(TRIM(d.content)) = 0;

-- Structured evidence source-document IDs must resolve to materialized documents.
SELECT DISTINCT e.source_document_id
FROM EFFICACY_ENDPOINT e
LEFT JOIN SCIENTIFIC_DOCUMENT d ON d.document_id = e.source_document_id
WHERE d.document_id IS NULL
UNION
SELECT DISTINCT s.source_document_id
FROM SAFETY_EVENT s
LEFT JOIN SCIENTIFIC_DOCUMENT d ON d.document_id = s.source_document_id
WHERE d.document_id IS NULL;

-- Citation document references must resolve.
SELECT c.citation_id, c.document_id
FROM DOCUMENT_CITATION c
LEFT JOIN SCIENTIFIC_DOCUMENT d ON d.document_id = c.document_id
WHERE d.document_id IS NULL;

-- Deliberate Cortex Analyst evidence patterns must remain intact.
SELECT
  study_id,
  population_id,
  endpoint_name,
  result_value,
  comparator_value,
  delta_vs_comparator,
  source_document_id
FROM EFFICACY_ENDPOINT
WHERE endpoint_id IN ('EP-301-002', 'EP-302-002', 'EP-303-002')
ORDER BY delta_vs_comparator DESC;

-- Expected top staged Phase III subgroup difference: EP-302-002 = 35.0 percentage points.
SELECT endpoint_id, study_id, population_id, delta_vs_comparator
FROM EFFICACY_ENDPOINT
WHERE endpoint_type = 'SUBGROUP'
  AND study_id IN ('ST-301', 'ST-302', 'ST-303')
ORDER BY delta_vs_comparator DESC
LIMIT 1;

-- Governance boundary: NOVA-220 remains ongoing and has no loaded efficacy endpoint.
SELECT
  s.study_id,
  s.study_status,
  COUNT(e.endpoint_id) AS efficacy_endpoint_count
FROM STUDY s
LEFT JOIN EFFICACY_ENDPOINT e ON e.study_id = s.study_id
WHERE s.study_id = 'ST-220'
GROUP BY s.study_id, s.study_status;

-- Governance boundary: the NOVA document must remain DRAFT.
SELECT document_id, title, approval_status, study_id
FROM SCIENTIFIC_DOCUMENT
WHERE document_id = 'DOC-NOVA-220-DRAFT';

-- Approved-only corpus preview for later Cortex Search configuration.
SELECT document_id, document_type, approval_status, region, study_id, LENGTH(content) AS content_length
FROM SCIENTIFIC_DOCUMENT
WHERE approval_status = 'APPROVED'
ORDER BY document_type, document_id;
