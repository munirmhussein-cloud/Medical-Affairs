-- Round 7: Materialize Git repository artifacts into named internal stages.
-- Requires Round 5 stages and Round 6 Git repository clone.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

ALTER GIT REPOSITORY MEDICAL_AFFAIRS_GIT_REPO FETCH;

-- Copy structured CSVs from the synchronized Git clone to the structured stage.
COPY FILES INTO @STRUCTURED_DATA_STAGE/
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/structured/
  PATTERN = '.*[.]csv'
  DETAILED_OUTPUT = TRUE;

-- Copy document metadata CSVs to the metadata stage.
COPY FILES INTO @METADATA_STAGE/
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/
  FILES = ('document_manifest.csv', 'document_citation.csv', 'approved_medical_response.csv')
  DETAILED_OUTPUT = TRUE;

-- Copy each Markdown corpus directory to a stable path under the scientific-document stage.
COPY FILES INTO @SCIENTIFIC_DOCUMENT_STAGE/study_summaries/
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/study_summaries/
  PATTERN = '.*[.]md'
  DETAILED_OUTPUT = TRUE;

COPY FILES INTO @SCIENTIFIC_DOCUMENT_STAGE/publications/
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/publications/
  PATTERN = '.*[.]md'
  DETAILED_OUTPUT = TRUE;

COPY FILES INTO @SCIENTIFIC_DOCUMENT_STAGE/prescribing_information/
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/prescribing_information/
  PATTERN = '.*[.]md'
  DETAILED_OUTPUT = TRUE;

COPY FILES INTO @SCIENTIFIC_DOCUMENT_STAGE/approved_medical_responses/
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/approved_medical_responses/
  PATTERN = '.*[.]md'
  DETAILED_OUTPUT = TRUE;

COPY FILES INTO @SCIENTIFIC_DOCUMENT_STAGE/scientific_faqs/
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/scientific_faqs/
  PATTERN = '.*[.]md'
  DETAILED_OUTPUT = TRUE;

COPY FILES INTO @SCIENTIFIC_DOCUMENT_STAGE/medical_affairs_sops/
  FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/medical_affairs_sops/
  PATTERN = '.*[.]md'
  DETAILED_OUTPUT = TRUE;

-- Inspect staged artifacts before table loads.
LIST @STRUCTURED_DATA_STAGE;
LIST @METADATA_STAGE;
LIST @SCIENTIFIC_DOCUMENT_STAGE;
