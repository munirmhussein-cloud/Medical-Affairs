# Planned Snowflake Objects

These names are reserved for consistency across future build rounds. Syntax and implementation details will be validated against the live Snowflake account before deployment.

| Object | Planned Name |
|---|---|
| Role | `MEDICAL_AFFAIRS_DEMO_ROLE` |
| Warehouse | `MEDICAL_AFFAIRS_DEMO_WH` |
| Database | `MEDICAL_AFFAIRS_AI` |
| Schema | `MEDICAL_AFFAIRS` |
| Cortex Search Service | `MEDICAL_SCIENTIFIC_SEARCH` |
| Semantic View | `CLINICAL_EVIDENCE_SEMANTIC_VIEW` |
| Cortex Agent | `MEDICAL_AFFAIRS_AGENT` |

## Planned structured objects

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

The canonical field contracts are defined in `docs/DATA_MODEL.md` and `data/schemas/`.
