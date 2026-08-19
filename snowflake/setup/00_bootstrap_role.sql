-- Round 5 — Snowflake Bootstrap
-- Creates the custom account role only. Run with USERADMIN (or a role with CREATE ROLE).
-- No user assignment is performed here because the target Snowflake username is environment-specific.

USE ROLE USERADMIN;

CREATE ROLE IF NOT EXISTS MEDICAL_AFFAIRS_DEMO_ROLE
  COMMENT = 'Custom role for the synthetic Medical Affairs Decision Intelligence Snowflake demonstration';

-- Keep the custom role visible/manageable through the standard Snowflake role hierarchy.
GRANT ROLE MEDICAL_AFFAIRS_DEMO_ROLE TO ROLE SYSADMIN;

-- OPTIONAL, execute manually after replacing <DEMO_USER>:
-- GRANT ROLE MEDICAL_AFFAIRS_DEMO_ROLE TO USER <DEMO_USER>;
