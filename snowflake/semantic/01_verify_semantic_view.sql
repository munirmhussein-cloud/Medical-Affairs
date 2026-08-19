-- Round 8: Verify CLINICAL_EVIDENCE_SEMANTIC_VIEW YAML before creation.
-- Reads the YAML directly from the synchronized Snowflake Git repository clone.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

-- Ensure the clone reflects the latest GitHub main branch.
ALTER GIT REPOSITORY MEDICAL_AFFAIRS_GIT_REPO FETCH;

DECLARE
  semantic_yaml STRING;
BEGIN
  SELECT LISTAGG($1, '\n') WITHIN GROUP (ORDER BY METADATA$FILE_ROW_NUMBER)
    INTO :semantic_yaml
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/snowflake/semantic/clinical_evidence_semantic_view.yaml
    (FILE_FORMAT => MEDICAL_AFFAIRS_TEXT_LINE_FF);

  CALL SYSTEM$CREATE_SEMANTIC_VIEW_FROM_YAML(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS',
    :semantic_yaml,
    TRUE
  );
END;
