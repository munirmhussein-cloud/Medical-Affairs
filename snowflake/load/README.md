# Round 7 — Data Loading

This directory materializes the synthetic Medical Affairs demo assets from the synchronized Snowflake Git repository into Snowflake-native stages and physical tables.

## Scope

Round 7 creates and loads only physical data objects required by later Cortex Analyst and Cortex Search rounds.

It does **not** create:

- `CLINICAL_EVIDENCE_SEMANTIC_VIEW`
- `MEDICAL_SCIENTIFIC_SEARCH`
- `MEDICAL_AFFAIRS_AGENT`

## Prerequisites

Complete Rounds 5 and 6 first:

- bootstrap objects exist
- `MEDICAL_AFFAIRS_GIT_REPO` exists and can fetch `main`
- `MEDICAL_AFFAIRS_DEMO_ROLE` can read the Git repository and read/write the internal demo stages

## Execution order

Run:

1. `00_create_physical_tables.sql`
2. `01_stage_repository_files.sql`
3. `02_load_structured_tables.sql`
4. `03_load_document_metadata.sql`
5. `04_materialize_document_content.sql`
6. `05_validate_loaded_data.sql`

## Data flow

```text
GitHub main
  ↓
Snowflake GIT REPOSITORY clone
  ↓ COPY FILES
Internal named stages
  ├─ STRUCTURED_DATA_STAGE
  ├─ METADATA_STAGE
  └─ SCIENTIFIC_DOCUMENT_STAGE
  ↓
Native Snowflake tables
```

Structured CSVs are loaded using `MEDICAL_AFFAIRS_CSV_FF` with `MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE`.

Markdown documents are copied to `SCIENTIFIC_DOCUMENT_STAGE`, read one line at a time with `MEDICAL_AFFAIRS_TEXT_LINE_FF`, and reconstructed in source order using `METADATA$FILE_ROW_NUMBER` plus `LISTAGG`. The final `SCIENTIFIC_DOCUMENT` table combines corpus metadata with complete document content.

## Idempotency

The load scripts truncate demo tables before reloading and use `FORCE = TRUE` where Snowflake load history could otherwise suppress unchanged source files. The repository and internal stages are intentionally retained across runs.

## Validation expectations

Round 7 is ready for Round 8 when:

- every manifest record has a non-empty row in `SCIENTIFIC_DOCUMENT`
- every efficacy/safety `source_document_id` resolves to a materialized document
- the staged Phase III subgroup ranking still places `EP-302-002` first at a 35-point difference
- `ST-220` has zero efficacy endpoints
- `DOC-NOVA-220-DRAFT` remains `DRAFT`
- approved documents can be filtered cleanly for later Cortex Search configuration

## Important note

The SQL is source-controlled setup code. It is not evidence that the target Snowflake account has executed it successfully. Account execution and output checks remain an environment step before the live demo.
