# Snowflake Object Registry

These names are reserved for consistency across build rounds. Rounds 5–10 now cover bootstrap, Git integration, physical data materialization, the Cortex Analyst semantic layer, governed Cortex Search, and the Medical Affairs Cortex Agent.

| Object | Name | Status |
|---|---|---|
| Role | `MEDICAL_AFFAIRS_DEMO_ROLE` | Round 5 bootstrap SQL ready |
| Warehouse | `MEDICAL_AFFAIRS_DEMO_WH` | Round 5 bootstrap SQL ready |
| Database | `MEDICAL_AFFAIRS_AI` | Round 5 bootstrap SQL ready |
| Schema | `MEDICAL_AFFAIRS` | Round 5 bootstrap SQL ready |
| CSV File Format | `MEDICAL_AFFAIRS_CSV_FF` | Round 5 bootstrap SQL ready |
| JSON File Format | `MEDICAL_AFFAIRS_JSON_FF` | Round 5 bootstrap SQL ready |
| Text-Line File Format | `MEDICAL_AFFAIRS_TEXT_LINE_FF` | Round 7 SQL ready |
| Structured Data Stage | `STRUCTURED_DATA_STAGE` | Round 5 bootstrap SQL ready; populated by Round 7 |
| Scientific Document Stage | `SCIENTIFIC_DOCUMENT_STAGE` | Round 5 bootstrap SQL ready; populated by Round 7 |
| Metadata Stage | `METADATA_STAGE` | Round 5 bootstrap SQL ready; populated by Round 7 |
| Git API Integration | `MEDICAL_AFFAIRS_GIT_API_INTEGRATION` | Round 6 SQL ready |
| Git Repository Clone | `MEDICAL_AFFAIRS_GIT_REPO` | Round 6 SQL ready |
| Semantic View | `CLINICAL_EVIDENCE_SEMANTIC_VIEW` | Round 8 YAML + verify/create/validation SQL ready |
| Cortex Search Service | `MEDICAL_SCIENTIFIC_SEARCH` | Round 9 create/validation SQL ready |
| Cortex Agent | `MEDICAL_AFFAIRS_AGENT` | Round 10 create/validation SQL ready |

## Git source-of-truth layer

`MEDICAL_AFFAIRS_GIT_REPO` points to:

`https://github.com/munirmhussein-cloud/Medical-Affairs.git`

Round 7 uses `COPY FILES` to copy synchronized repository artifacts from the Git repository clone into internal named stages. Native Snowflake tables—not GitHub CSV files—are the runtime data layer for later AI features.

## Round 7 physical objects

The following native tables are created by `snowflake/load/00_create_physical_tables.sql`:

- `THERAPEUTIC_AREA`
- `PRODUCT`
- `INDICATION`
- `STUDY`
- `TREATMENT_ARM`
- `PATIENT_POPULATION`
- `EFFICACY_ENDPOINT`
- `SAFETY_EVENT`
- `SCIENTIFIC_DOCUMENT_MANIFEST`
- `DOCUMENT_CITATION`
- `APPROVED_MEDICAL_RESPONSE`
- `SCIENTIFIC_DOCUMENT_LINE`
- `SCIENTIFIC_DOCUMENT`

`SCIENTIFIC_DOCUMENT_LINE` is an ingestion helper table. `SCIENTIFIC_DOCUMENT` is the final governed unstructured corpus used by Round 9 Cortex Search.

## Round 8 semantic layer

`CLINICAL_EVIDENCE_SEMANTIC_VIEW` is authored in `snowflake/semantic/clinical_evidence_semantic_view.yaml` and created with Snowflake's semantic-view system procedure. It exposes three focused logical domains:

- `study_overview`
- `efficacy_evidence`
- `safety_evidence`

The model includes Medical Affairs synonyms, business descriptions, aggregate metrics, verified questions, and Analyst-specific instructions. `SNOWFLAKE.CORTEX_ANALYST_USER` is granted to `MEDICAL_AFFAIRS_DEMO_ROLE` in the Round 8 privilege script.

## Round 9 governed Search layer

`MEDICAL_SCIENTIFIC_SEARCH` is created over `SCIENTIFIC_DOCUMENT` with `content` as the searchable text and these filterable attributes:

- `approval_status`
- `document_type`
- `study_id`
- `product_id`
- `indication_id`
- `region`

The source query also exposes `document_id`, title, citation label, dates, source type, therapeutic-area metadata, and the full synthetic document text as returnable columns. A text primary key on `document_id` is configured for stable document identity and efficient refresh behavior.

Round 9 grants `SNOWFLAKE.CORTEX_EMBED_USER` to `MEDICAL_AFFAIRS_DEMO_ROLE` for managed Cortex Search embeddings. The intentionally staged `DOC-NOVA-220-DRAFT` remains indexed for direct Search-layer governance testing.

## Round 10 Cortex Agent

`MEDICAL_AFFAIRS_AGENT` combines:

- `medical_scientific_search` → `MEDICAL_SCIENTIFIC_SEARCH`
- `clinical_evidence_analyst` → `CLINICAL_EVIDENCE_SEMANTIC_VIEW`

The Agent's Search tool resource is hard-filtered to `approval_status = APPROVED`, so DRAFT/EXPIRED documents cannot enter the normal Medical Affairs synthesis path. The orchestration policy sends narrative/source questions to Search, structured quantitative questions to Analyst, and mixed evidence questions to both tools.

Round 10 grants `SNOWFLAKE.CORTEX_AGENT_USER` to `MEDICAL_AFFAIRS_DEMO_ROLE` and includes synchronous `SNOWFLAKE.CORTEX.DATA_AGENT_RUN` validation for Search-oriented, Analyst-oriented, combined hero, and NOVA-220 governance-boundary prompts.

## Execution references

- Bootstrap: `snowflake/setup/README.md`
- Git integration: `snowflake/git/README.md`
- Data loading: `snowflake/load/README.md`
- Semantic layer: `snowflake/semantic/README.md`
- Cortex Search: `snowflake/search/README.md`
- Cortex Agent: `snowflake/agent/README.md`
