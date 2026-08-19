-- Round 6: Git Integration
-- Creates the Snowflake Git repository clone inside the demo schema.
-- The remote repository is public, so no Snowflake secret is required.

USE ROLE ACCOUNTADMIN;

GRANT CREATE GIT REPOSITORY ON SCHEMA MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS
  TO ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
GRANT USAGE ON INTEGRATION MEDICAL_AFFAIRS_GIT_API_INTEGRATION
  TO ROLE MEDICAL_AFFAIRS_DEMO_ROLE;

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

CREATE GIT REPOSITORY IF NOT EXISTS MEDICAL_AFFAIRS_GIT_REPO
  ORIGIN = 'https://github.com/munirmhussein-cloud/Medical-Affairs.git'
  API_INTEGRATION = MEDICAL_AFFAIRS_GIT_API_INTEGRATION
  COMMENT = 'Snowflake clone of munirmhussein-cloud/Medical-Affairs for the Medical Affairs Decision Intelligence demo';
