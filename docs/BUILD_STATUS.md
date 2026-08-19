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
| 10 | Cortex Agent | NOT STARTED | | |
| 11 | AI / Model Routing | NOT STARTED | | |
| 12 | Validation | NOT STARTED | | |
| 13 | Demo Hardening | NOT STARTED | | |

## Current handoff

Proceed to **Round 10 — Cortex Agent**. Round 9 now provides `snowflake/search/` with `MEDICAL_SCIENTIFIC_SEARCH` over `SCIENTIFIC_DOCUMENT`, using `content` as the semantic search column and `approval_status`, `document_type`, `study_id`, `product_id`, `indication_id`, and `region` as filterable attributes. The service deliberately indexes DRAFT content so governance can be demonstrated explicitly: standard Medical Affairs retrieval must apply `approval_status = APPROVED`, while controlled internal workflows can request DRAFT evidence intentionally. Round 10 should attach both `MEDICAL_SCIENTIFIC_SEARCH` and `CLINICAL_EVIDENCE_SEMANTIC_VIEW` as Agent tools, define clear tool descriptions and orchestration instructions, preserve the approval filter policy, and support combined structured + unstructured evidence synthesis.
