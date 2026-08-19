-- Round 6: Git Integration
-- Refreshes the Snowflake Git repository clone and validates the expected branch/files.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

ALTER GIT REPOSITORY MEDICAL_AFFAIRS_GIT_REPO FETCH;

SHOW GIT REPOSITORIES LIKE 'MEDICAL_AFFAIRS_GIT_REPO' IN SCHEMA MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS;
SHOW GIT BRANCHES IN GIT REPOSITORY MEDICAL_AFFAIRS_GIT_REPO;
DESCRIBE GIT REPOSITORY MEDICAL_AFFAIRS_GIT_REPO;

-- Repository stages support LIST/LS by branch, tag, or commit.
LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/;
LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/structured/;
LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/;
LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/snowflake/;

-- Spot-check Round 3 and Round 4 source artifacts without loading them yet.
LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/structured/study.csv;
LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/structured/efficacy_endpoint.csv;
LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/documents/document_manifest.csv;

-- Round 7 will materialize these repository artifacts into native Snowflake stages/tables.
