-- Round 8: Validate semantic view metadata and core semantic queries.
-- SEMANTIC_VIEW() projects flat output column names, so WHERE / ORDER BY clauses
-- must reference the projected aliases without logical-table qualification.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

SHOW SEMANTIC VIEWS LIKE 'CLINICAL_EVIDENCE_SEMANTIC_VIEW';
DESCRIBE SEMANTIC VIEW CLINICAL_EVIDENCE_SEMANTIC_VIEW;

-- Expected: strongest staged Phase III subgroup difference is AURORA-302 biomarker-positive at 35.0 pp.
SELECT *
FROM SEMANTIC_VIEW(
  CLINICAL_EVIDENCE_SEMANTIC_VIEW
  DIMENSIONS efficacy_evidence.study_name,
             efficacy_evidence.patient_population,
             efficacy_evidence.endpoint,
             efficacy_evidence.timepoint,
             efficacy_evidence.phase,
             efficacy_evidence.endpoint_type
  METRICS efficacy_evidence.largest_treatment_difference_pp
)
WHERE phase = 'Phase III'
  AND endpoint_type = 'SUBGROUP'
ORDER BY largest_treatment_difference_pp DESC
LIMIT 1;

-- Expected: three Phase III primary rows, AURORA-301 / 302 / 303.
SELECT *
FROM SEMANTIC_VIEW(
  CLINICAL_EVIDENCE_SEMANTIC_VIEW
  DIMENSIONS efficacy_evidence.study_name,
             efficacy_evidence.patient_population,
             efficacy_evidence.endpoint,
             efficacy_evidence.timepoint,
             efficacy_evidence.phase,
             efficacy_evidence.endpoint_type
  METRICS efficacy_evidence.average_active_response_rate,
          efficacy_evidence.average_treatment_difference_pp
)
WHERE phase = 'Phase III'
  AND endpoint_type = 'PRIMARY'
ORDER BY study_name;

-- Expected: serious adverse-event observations for active and placebo arms in AURORA-301/302/303.
SELECT *
FROM SEMANTIC_VIEW(
  CLINICAL_EVIDENCE_SEMANTIC_VIEW
  DIMENSIONS safety_evidence.study_name,
             safety_evidence.treatment_arm,
             safety_evidence.adverse_event,
             safety_evidence.phase,
             safety_evidence.serious_event
  METRICS safety_evidence.average_adverse_event_rate
)
WHERE phase = 'Phase III'
  AND serious_event = TRUE
ORDER BY study_name,
         treatment_arm;

-- Expected: NOVA-220 exists in study_overview and is ongoing, while the efficacy_evidence
-- logical table has no staged endpoint rows for it. This boundary is intentional.
SELECT *
FROM SEMANTIC_VIEW(
  CLINICAL_EVIDENCE_SEMANTIC_VIEW
  DIMENSIONS study_overview.study_name,
             study_overview.study_status,
             study_overview.phase
  METRICS study_overview.total_enrollment
)
WHERE study_name = 'NOVA-220';
