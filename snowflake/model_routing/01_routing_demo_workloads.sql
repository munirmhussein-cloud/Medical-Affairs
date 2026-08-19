-- Round 11: staged workload classes for the Dynamic Model Routing narrative.
-- These prompts are intentionally runnable through the existing Cortex Agent.
-- They demonstrate increasing task complexity without claiming hidden routing metadata.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

-- A. Simple bounded evidence task.
SELECT 'SIMPLE' AS task_class,
       'Summarize the primary efficacy endpoint for AURORA-301 using approved evidence only.' AS prompt;

-- B. Comparative structured task.
SELECT 'COMPARATIVE' AS task_class,
       'Compare the Phase III treatment differences versus comparator for AURORA-301 and AURORA-302. Identify the larger overall treatment difference and cite the structured evidence.' AS prompt;

-- C. Hero multi-tool reasoning task.
SELECT 'HERO_COMPLEX' AS task_class,
       'Using approved scientific documents and structured efficacy evidence, reconcile AURORA-301, AURORA-302, and AURORA-303. Identify the strongest descriptive Phase III subgroup differences and prepare three evidence-backed discussion points for an HCP meeting. Include source labels and limitations.' AS prompt;

-- D. Governance-boundary task.
SELECT 'GOVERNANCE_BOUNDARY' AS task_class,
       'What approved efficacy evidence supports Neravilimab in NOVA-220?' AS prompt;

-- Execute prompts through the Agent using the target-account-supported Agent invocation surface during validation.
-- Preserve the raw response/tool trace where Snowflake exposes it.
-- Do not populate model-selection fields unless they are actually returned by Snowflake.
