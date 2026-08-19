# Build Status

| Round | Workstream | Status | Validation | Notes |
|---|---|---|---|---|
| 1 | Repository Scaffold | COMPLETE | Root project contract, secret handling, build docs established | Scaffold landed together with Round 2 because repo `main` initially contained only `.gitkeep` |
| 2 | Synthetic Data Model | COMPLETE | Canonical entity model, machine-readable schemas, referential rules, demo evidence requirements documented | Structured data contract established |
| 3 | Structured Synthetic Data | COMPLETE | 8 CSV datasets created; enrollment, subgroup, efficacy delta, evidence-boundary, and source-document checks documented | Deliberate Phase III, subgroup, maintenance, dose-response, safety, and no-evidence patterns staged for Cortex Analyst |
| 4 | Scientific Document Corpus | COMPLETE | Approved/draft document corpus, manifest, citation index, approved-response index, and cross-modal consistency checks created | Cortex Search corpus matches Round 3 structured evidence and includes governance test content |
| 5 | Snowflake Bootstrap | COMPLETE | Role/warehouse/database/schema/file-format/stage/grant SQL plus read-only validation script created | SQL is staged in repo; execution against target Snowflake account remains an environment step |
| 6 | Git Integration | COMPLETE | API integration, Git repository clone, fetch, branch/path inspection, and validation SQL created | Public GitHub repository uses no-auth Git integration |
| 7 | Data Loading | COMPLETE | Physical table DDL, Git-to-stage COPY FILES, structured/metadata COPY INTO, Markdown reconstruction, and business-evidence validation SQL created | SQL is source-controlled; target Snowflake account execution remains an environment step |
| 8 | Semantic Layer | COMPLETE | Business-language semantic-view YAML, Analyst-specific privileges, verify/create scripts, semantic SQL validation, synonyms, metrics, custom instructions, and verified queries created | `CLINICAL_EVIDENCE_SEMANTIC_VIEW` is source-controlled; execution in target Snowflake account remains an environment step |
| 9 | Cortex Search | COMPLETE | Search privilege script, governed Search-service definition, service/index validation, approved-only retrieval tests, draft-governance contrast, and business-facing demo queries created | `MEDICAL_SCIENTIFIC_SEARCH` indexes both approved and draft synthetic evidence; approval is enforced dynamically through search attributes/filters |
| 10 | Cortex Agent | COMPLETE | Agent privileges, Search + Analyst tool bindings, hard APPROVED Search filter, orchestration instructions, sample questions, hero-workflow and governance validation queries created | `MEDICAL_AFFAIRS_AGENT` is source-controlled; target Snowflake execution remains an environment step |
| 11 | AI / Model Routing | NOT STARTED | | |
| 12 | Validation | NOT STARTED | | |
| 13 | Demo Hardening | NOT STARTED | | |

## Current handoff

Proceed to **Round 11 — AI / Model Routing**. Round 10 now provides `snowflake/agent/` with `MEDICAL_AFFAIRS_AGENT`, combining the approved-only `MEDICAL_SCIENTIFIC_SEARCH` tool and the `CLINICAL_EVIDENCE_SEMANTIC_VIEW` Cortex Analyst tool. The Search tool resource is hard-filtered to `approval_status = APPROVED`; the Agent cannot retrieve DRAFT evidence through its standard Medical Affairs path. Orchestration instructions explicitly route narrative/source questions to Search, quantitative clinical questions to Analyst, and mixed evidence questions to both. The canonical hero query is staged in `02_validate_medical_affairs_agent.sql`, alongside the NOVA-220 governance boundary test. Round 11 should add model-selection / routing optimization in a way that is observable and faithful to the capabilities exposed by the target Snowflake account, without fabricating routing telemetry.
