# Snowflake Object Registry

These names are reserved for consistency across build rounds. Round 5 implements the bootstrap objects; Round 6 adds Git integration; later rounds implement data, semantic, Search, and Agent objects.

| Object | Name | Status |
|---|---|---|
| Role | `MEDICAL_AFFAIRS_DEMO_ROLE` | Round 5 bootstrap SQL ready |
| Warehouse | `MEDICAL_AFFAIRS_DEMO_WH` | Round 5 bootstrap SQL ready |
| Database | `MEDICAL_AFFAIRS_AI` | Round 5 bootstrap SQL ready |
| Schema | `MEDICAL_AFFAIRS` | Round 5 bootstrap SQL ready |
| CSV File Format | `MEDICAL_AFFAIRS_CSV_FF` | Round 5 bootstrap SQL ready |
| JSON File Format | `MEDICAL_AFFAIRS_JSON_FF` | Round 5 bootstrap SQL ready |
| Structured Data Stage | `STRUCTURED_DATA_STAGE` | Round 5 bootstrap SQL ready |
| Scientific Document Stage | `SCIENTIFIC_DOCUMENT_STAGE` | Round 5 bootstrap SQL ready |
| Metadata Stage | `METADATA_STAGE` | Round 5 bootstrap SQL ready |
| Git API Integration | `MEDICAL_AFFAIRS_GIT_API_INTEGRATION` | Round 6 SQL ready |
| Git Repository Clone | `MEDICAL_AFFAIRS_GIT_REPO` | Round 6 SQL ready |
| Cortex Search Service | `MEDICAL_SCIENTIFIC_SEARCH` | Reserved for Round 9 |
| Semantic View | `CLINICAL_EVIDENCE_SEMANTIC_VIEW` | Reserved for Round 8 |
| Cortex Agent | `MEDICAL_AFFAIRS_AGENT` | Reserved for Round 10 |

## Git source-of-truth layer

Round 6 establishes `MEDICAL_AFFAIRS_GIT_REPO` inside `MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS`, pointing to:

`https://github.com/munirmhussein-cloud/Medical-Affairs.git`

The repository is public, so the integration does not use a Snowflake secret or `GIT_CREDENTIALS`. `ALTER GIT REPOSITORY ... FETCH` synchronizes GitHub changes into the Snowflake repository clone. Repository files are addressable through paths such as:

`@MEDICAL_AFFAIRS_GIT_REPO/branches/main/data/structured/`

Round 7 will materialize the appropriate Git repository artifacts into native Snowflake tables/stages. The demo should not query GitHub CSV files directly as the final runtime architecture.

## Planned structured objects

These are not created in Rounds 5–6. Round 7 will create/load the physical data objects using the canonical contracts in `docs/DATA_MODEL.md` and `data/schemas/`.

- `THERAPEUTIC_AREA`
- `PRODUCT`
- `INDICATION`
- `STUDY`
- `TREATMENT_ARM`
- `PATIENT_POPULATION`
- `EFFICACY_ENDPOINT`
- `SAFETY_EVENT`
- `SCIENTIFIC_DOCUMENT`
- `DOCUMENT_CITATION`
- `APPROVED_MEDICAL_RESPONSE`

## Execution references

- Bootstrap: `snowflake/setup/README.md`
- Git integration: `snowflake/git/README.md`
