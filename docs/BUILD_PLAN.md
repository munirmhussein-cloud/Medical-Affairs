# Build Plan

This repository is intentionally built in controlled rounds so the Snowflake demonstration remains reproducible and easy to validate.

| Round | Workstream | Goal |
|---|---|---|
| 1 | Repository Scaffold | Establish project contract, structure, naming, security, and documentation |
| 2 | Synthetic Data Model | Define canonical entities, relationships, schemas, evidence rules, and demo requirements |
| 3 | Structured Synthetic Data | Generate internally consistent CSV datasets against Round 2 contracts |
| 4 | Scientific Document Corpus | Generate synthetic unstructured evidence with metadata and citations |
| 5 | Snowflake Bootstrap | Create database, schema, warehouse, roles, grants, and base tables |
| 6 | Git Integration | Connect Snowflake to this GitHub repo and define reproducible deployment steps |
| 7 | Data Loading | Load validated structured and unstructured demo data into Snowflake |
| 8 | Semantic Layer | Build semantic view for Cortex Analyst |
| 9 | Cortex Search | Create scientific document retrieval service with metadata filters |
| 10 | Cortex Agent | Configure orchestration, tools, instructions, and guardrails |
| 11 | AI / Model Routing | Add native AI functions and supported model-routing/optimization demonstration |
| 12 | Validation | Validate golden queries, citations, tool choice, unsupported-evidence behavior, and performance |
| 13 | Demo Hardening | Final click path, backup plan, screenshots, reset procedure, and rehearsal checklist |

## Build Principle

GitHub is the versioned source of truth. Snowflake is the execution environment. The final demo should expose Snowflake capabilities through one coherent Medical Affairs workflow, not as disconnected product features.
