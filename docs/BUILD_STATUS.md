# Build Status

| Round | Workstream | Status | Validation | Notes |
|---|---|---|---|---|
| 1 | Repository Scaffold | COMPLETE | Root project contract, secret handling, build docs established | Scaffold landed together with Round 2 because repo `main` initially contained only `.gitkeep` |
| 2 | Synthetic Data Model | COMPLETE | Canonical entity model, machine-readable schemas, referential rules, demo evidence requirements documented | Structured data contract established |
| 3 | Structured Synthetic Data | COMPLETE | 8 CSV datasets created; enrollment, subgroup, efficacy delta, evidence-boundary, and source-document checks documented | Deliberate Phase III, subgroup, maintenance, dose-response, safety, and no-evidence patterns staged for Cortex Analyst |
| 4 | Scientific Document Corpus | COMPLETE | Approved/draft document corpus, manifest, citation index, approved-response index, and cross-modal consistency checks created | Cortex Search corpus now matches Round 3 structured evidence and includes governance test content |
| 5 | Snowflake Bootstrap | NOT STARTED | | |
| 6 | Git Integration | NOT STARTED | | |
| 7 | Data Loading | NOT STARTED | | |
| 8 | Semantic Layer | NOT STARTED | | |
| 9 | Cortex Search | NOT STARTED | | |
| 10 | Cortex Agent | NOT STARTED | | |
| 11 | AI / Model Routing | NOT STARTED | | |
| 12 | Validation | NOT STARTED | | |
| 13 | Demo Hardening | NOT STARTED | | |

## Current handoff

Proceed to **Round 5 — Snowflake Bootstrap**. The repository now has both modalities required for the eventual demo: structured clinical evidence for Cortex Analyst and a governed unstructured corpus for Cortex Search. Round 5 should create Snowflake-native bootstrap SQL for role, warehouse, database, schema, stages/file formats as needed, and grants using the reserved object names in `docs/SNOWFLAKE_OBJECTS.md`. It should not yet create the semantic view, Cortex Search service, or Cortex Agent; those remain later rounds.
