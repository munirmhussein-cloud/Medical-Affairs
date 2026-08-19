# Snowflake Object Registry

These names are reserved for consistency across build rounds. Round 5 implements bootstrap objects, Round 6 Git integration, and Round 7 physical data materialization. Later rounds implement the semantic, Search, and Agent objects.

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
| Cortex Search Service | `MEDICAL_SCIENTIFIC_SEARCH` | Reserved for Round 9 |
| Semantic View | `CLINICAL_EVIDENCE_SEMANTIC_VIEW` | Reserved for Round 8 |
| Cortex Agent | `MEDICAL_AFFAIRS_AGENT` | Reserved for Round 10 |

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

`SCIENTIFIC_DOCUMENT_LINE` is an ingestion helper table. `SCIENTIFIC_DOCUMENT` is the final governed unstructured corpus intended for later Cortex Search configuration.

## Execution references

- Bootstrap: `snowflake/setup/README.md`
- Git integration: `snowflake/git/README.md`
- Data loading: `snowflake/load/README.md`
