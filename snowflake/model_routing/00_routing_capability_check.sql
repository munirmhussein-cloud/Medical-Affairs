-- Round 11: Dynamic Model Routing capability check
-- Purpose: gather account-visible information without guessing undocumented router configuration syntax.
-- IMPORTANT: Snowflake announced Dynamic Model Routing in Cortex AI Gateway on 2026-08-18.
-- This script does not claim that routing configuration is exposed through SQL in every account/surface.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

-- Confirm existing demo objects before attempting any routing demo.
SHOW AGENTS LIKE 'MEDICAL_AFFAIRS_AGENT';
SHOW CORTEX SEARCH SERVICES LIKE 'MEDICAL_SCIENTIFIC_SEARCH';
SHOW SEMANTIC VIEWS LIKE 'CLINICAL_EVIDENCE_SEMANTIC_VIEW';

-- Capture current session context for the demo runbook.
SELECT CURRENT_ROLE() AS current_role,
       CURRENT_WAREHOUSE() AS current_warehouse,
       CURRENT_DATABASE() AS current_database,
       CURRENT_SCHEMA() AS current_schema,
       CURRENT_TIMESTAMP() AS checked_at;

-- ACCOUNT VALIDATION STEP (manual):
-- Inspect Snowsight / CoWork / Cortex AI Gateway surfaces available in the target account
-- for Dynamic Model Routing configuration and observability.
-- Record only fields actually exposed by Snowflake.
-- Do not infer selected model, policy score, cost, latency savings, or quality score.

SELECT 'PENDING_LIVE_ACCOUNT_VALIDATION' AS routing_configuration_status,
       'Do not add router configuration SQL until the target Snowflake account exposes supported/documented syntax.' AS instruction;
