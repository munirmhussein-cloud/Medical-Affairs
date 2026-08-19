-- Round 10: Validate Medical Affairs Cortex Agent
-- Run after privileges, semantic view, Search service, and agent creation are complete.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

SHOW AGENTS LIKE 'MEDICAL_AFFAIRS_AGENT' IN SCHEMA MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS;
DESCRIBE AGENT MEDICAL_AFFAIRS_AGENT;

-- 1. Search-oriented approved evidence question.
SELECT TRY_PARSE_JSON(
  SNOWFLAKE.CORTEX.DATA_AGENT_RUN(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_AFFAIRS_AGENT!LIVE',
    $$
    {
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": "What approved Phase III efficacy evidence is available for Aurelimab in IND-001? Name the supporting evidence documents."
            }
          ]
        }
      ],
      "stream": false,
      "tool_choice": {
        "type": "auto",
        "name": ["medical_scientific_search", "clinical_evidence_analyst"]
      }
    }
    $$
  )
) AS approved_evidence_response;

-- 2. Analyst-oriented quantitative question.
SELECT TRY_PARSE_JSON(
  SNOWFLAKE.CORTEX.DATA_AGENT_RUN(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_AFFAIRS_AGENT!LIVE',
    $$
    {
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": "Which staged Phase III patient subgroup showed the largest treatment difference versus comparator, and what was the percentage-point difference?"
            }
          ]
        }
      ],
      "stream": false,
      "tool_choice": {
        "type": "auto",
        "name": ["medical_scientific_search", "clinical_evidence_analyst"]
      }
    }
    $$
  )
) AS strongest_subgroup_response;

-- Expected staged answer: AURORA-302 biomarker-positive subgroup, 35 percentage points.

-- 3. Hero workflow: both structured and unstructured evidence.
SELECT TRY_PARSE_JSON(
  SNOWFLAKE.CORTEX.DATA_AGENT_RUN(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_AFFAIRS_AGENT!LIVE',
    $$
    {
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": "Compare the approved scientific evidence with the structured efficacy results across AURORA-301, AURORA-302, and AURORA-303. Identify the staged populations with the strongest descriptive treatment differences and prepare three evidence-backed discussion points for an upcoming HCP meeting. Include source labels and limitations."
            }
          ]
        }
      ],
      "stream": false,
      "tool_choice": {
        "type": "auto",
        "name": ["medical_scientific_search", "clinical_evidence_analyst"]
      }
    }
    $$
  )
) AS hero_workflow_response;

-- Expected behavior:
--   * Agent uses BOTH medical_scientific_search and clinical_evidence_analyst.
--   * Search results are restricted to APPROVED documents by the tool-resource filter.
--   * The response reconciles document and structured values rather than inventing new facts.
--   * The largest staged subgroup difference is 35 points in AURORA-302 biomarker-positive participants.
--   * AURORA-301 biologic-naive = 30 points; AURORA-303 biologic-naive maintenance responders = 29 points.
--   * Response labels all evidence as synthetic and avoids treatment recommendations.

-- 4. Governance boundary: no approved evidence exists for NOVA-220 efficacy.
SELECT TRY_PARSE_JSON(
  SNOWFLAKE.CORTEX.DATA_AGENT_RUN(
    'MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_AFFAIRS_AGENT!LIVE',
    $$
    {
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": "What approved efficacy evidence supports Neravilimab in NOVA-220?"
            }
          ]
        }
      ],
      "stream": false,
      "tool_choice": {
        "type": "auto",
        "name": ["medical_scientific_search", "clinical_evidence_analyst"]
      }
    }
    $$
  )
) AS governance_boundary_response;

-- Expected behavior: state that approved efficacy evidence is insufficient/unavailable.
-- The agent must not use DOC-NOVA-220-DRAFT because its Search tool is hard-filtered to APPROVED.
