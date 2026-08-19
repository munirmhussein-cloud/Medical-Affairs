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
| 9 | Cortex Search | NOT STARTED | | |
| 10 | Cortex Agent | NOT STARTED | | |
| 11 | AI / Model Routing | NOT STARTED | | |
| 12 | Validation | NOT STARTED | | |
| 13 | Demo Hardening | NOT STARTED | | |

## Current handoff

Proceed to **Round 9 — Cortex Search**. Round 8 now provides `snowflake/semantic/` with `CLINICAL_EVIDENCE_SEMANTIC_VIEW`, authored in Medical Affairs terminology over the native Round 7 tables. The view exposes focused study-overview, efficacy-evidence, and safety-evidence logical tables; includes synonyms, metrics, Analyst custom instructions, and verified questions; and preserves the staged evidence boundary for NOVA-220. Round 9 should build `MEDICAL_SCIENTIFIC_SEARCH` over the native `SCIENTIFIC_DOCUMENT` corpus with metadata attributes/filters for approval status, document type, study, product, indication, and region, while keeping the Cortex Agent for Round 10.
