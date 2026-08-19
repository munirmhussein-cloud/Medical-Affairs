# Build Status

| Round | Workstream | Status | Validation | Notes |
|---|---|---|---|---|
| 1 | Repository Scaffold | COMPLETE | Root project contract, secret handling, build docs established | Scaffold landed together with Round 2 because repo `main` initially contained only `.gitkeep` |
| 2 | Synthetic Data Model | COMPLETE | Canonical entity model, machine-readable schemas, referential rules, demo evidence requirements documented | Structured data contract established |
| 3 | Structured Synthetic Data | COMPLETE | 8 CSV datasets created; enrollment, subgroup, efficacy delta, evidence-boundary, and source-document checks documented | Deliberate Phase III, subgroup, maintenance, dose-response, safety, and no-evidence patterns staged for Cortex Analyst |
| 4 | Scientific Document Corpus | NOT STARTED | | Must create documents matching reserved source IDs and structured evidence facts |
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

Proceed to **Round 4 — Scientific Document Corpus** using `data/structured/VALIDATION.md` as the factual contract for all synthetic study documents. At minimum, create the reserved source documents `DOC-ST301-CSR`, `DOC-ST301-PUB`, `DOC-ST302-CSR`, `DOC-ST302-PUB`, `DOC-ST303-CSR`, `DOC-ST303-PUB`, and `DOC-ST210-CSR`. The unstructured documents must preserve the structured numerical facts so Cortex Search and Cortex Analyst can later converge on consistent grounded answers.
