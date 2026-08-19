-- Round 8: Semantic Layer privileges
-- Grant only the Cortex Analyst-specific database role needed for natural-language analysis.
-- Run with ACCOUNTADMIN or a role permitted to grant Snowflake database roles.

USE ROLE ACCOUNTADMIN;

GRANT DATABASE ROLE SNOWFLAKE.CORTEX_ANALYST_USER
  TO ROLE MEDICAL_AFFAIRS_DEMO_ROLE;

-- CREATE SEMANTIC VIEW on MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS was granted in Round 5.
-- Underlying table access is owned/managed by MEDICAL_AFFAIRS_DEMO_ROLE from the Round 7 build.
