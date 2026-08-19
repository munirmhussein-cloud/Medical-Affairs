-- Round 6: Git Integration
-- Creates an account-level API integration for the public GitHub repository.
-- Run as ACCOUNTADMIN or another role with CREATE INTEGRATION privilege.

USE ROLE ACCOUNTADMIN;

CREATE API INTEGRATION IF NOT EXISTS MEDICAL_AFFAIRS_GIT_API_INTEGRATION
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/munirmhussein-cloud')
  ENABLED = TRUE
  COMMENT = 'Public GitHub access for the Medical Affairs Snowflake demo repository';

GRANT USAGE ON INTEGRATION MEDICAL_AFFAIRS_GIT_API_INTEGRATION
  TO ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
