# Snowflake Object Registry

These names are reserved for consistency across build rounds. Round 5 implements the bootstrap objects; later rounds implement data, semantic, Search, and Agent objects.

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
| Cortex Search Service | `MEDICAL_SCIENTIFIC_SEARCH` | Reserved for Round 9 |
| Semantic View | `CLINICAL_EVIDENCE_SEMANTIC_VIEW` | Reserved for Round 8 |
| Cortex Agent | `MEDICAL_AFFAIRS_AGENT` | Reserved for Round 10 |

## Planned structured objects

These are not created in Round 5. Round 7 will create/load the physical data objects using the canonical contracts in `docs/DATA_MODEL.md` and `data/schemas/`.

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

## Bootstrap execution

See `snowflake/setup/README.md` for role context, execution order, and validation steps.
