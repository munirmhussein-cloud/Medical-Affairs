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
| 9 | Cortex Search | COMPLETE | Search privilege script, governed Search-service definition, service/index validation, approved-only retrieval tests, draft-governance contrast, and business-facing demo queries created | `MEDICAL_SCIENTIFIC_SEARCH` indexes both approved and draft synthetic evidence; Agent approval enforcement occurs in Round 10 |
| 10 | Cortex Agent | COMPLETE | Agent privileges, Search + Analyst tool bindings, hard APPROVED Search filter, orchestration instructions, sample questions, hero-workflow and governance validation queries created | `MEDICAL_AFFAIRS_AGENT` is source-controlled; target Snowflake execution remains an environment step |
| 11 | AI / Model Routing | STAGED | Capability-check script, workload classes, intelligence-efficiency narrative, and observability contract created | Dynamic Model Routing was announced 2026-08-18; account-specific configuration/telemetry remains pending live account validation and must not be fabricated |
| 12 | Golden Query Validation | STAGED | Four golden queries, required factual anchors, tool expectations, governance pass/fail criteria, failure-mode matrix, and screenshot plan created | Live Agent/Search/Analyst execution and screenshot capture remain pending |
| 13 | Demo Runbook | STAGED | Operator sequence, technical talking points, reset/recovery order, troubleshooting decision tree, and backup-asset plan created | Exact UI click path and final spoken script will be refined after target-account execution/validation |

## Current handoff

Repository-level technical staging is complete through Round 13. The project now has the repository structure, Snowflake object specifications, synthetic structured/unstructured evidence, semantic/Search/Agent definitions, routing rules and claims boundary, golden-query validation contract, and operator runbook.

The next phase is **live Snowflake implementation and validation**. Execute the source-controlled rounds against the target account, record actual behavior and supported Dynamic Model Routing observability, capture backup screenshots, then refine the final click-by-click implementation requirements and demo script from observed Snowflake behavior rather than assumptions.
