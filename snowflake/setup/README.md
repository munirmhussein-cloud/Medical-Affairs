# Round 5 — Snowflake Bootstrap

This directory contains the account/bootstrap SQL required before Git integration and data loading.

## Execution order

1. `00_bootstrap_role.sql` — run with `USERADMIN` or equivalent.
2. `01_bootstrap_objects.sql` — run with `SYSADMIN` or equivalent.
3. `02_bootstrap_grants.sql` — run with `SECURITYADMIN` or equivalent.
4. Optionally grant `MEDICAL_AFFAIRS_DEMO_ROLE` to the specific demo user after replacing the placeholder in `00_bootstrap_role.sql`.
5. `03_bootstrap_validate.sql` — run as `MEDICAL_AFFAIRS_DEMO_ROLE`.

## Objects created in Round 5

- Account role: `MEDICAL_AFFAIRS_DEMO_ROLE`
- Warehouse: `MEDICAL_AFFAIRS_DEMO_WH`
- Database: `MEDICAL_AFFAIRS_AI`
- Schema: `MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS`
- File formats:
  - `MEDICAL_AFFAIRS_CSV_FF`
  - `MEDICAL_AFFAIRS_JSON_FF`
- Internal stages:
  - `STRUCTURED_DATA_STAGE`
  - `SCIENTIFIC_DOCUMENT_STAGE`
  - `METADATA_STAGE`

## Cost posture

The warehouse is `XSMALL`, starts suspended, auto-resumes, and auto-suspends after 60 seconds. This is intentionally sized for a demonstration and can be adjusted later only if Search indexing or other workloads require it.

## Access model

The custom demo role receives:

- `USAGE` on the warehouse, database, schema, and named file formats.
- `READ, WRITE` on the internal stages.
- schema-level creation privileges needed by later dedicated rounds for tables/views, semantic views, Cortex Search, and Cortex Agents.
- future `SELECT` on tables and views in the demo schema.

Snowflake Cortex database roles are intentionally deferred. Later rounds should grant only the Cortex role(s) required for the exact feature implementation in the target account.

## Deliberately not created in Round 5

- tables or views
- Git repository objects/API integrations
- semantic views
- Cortex Search services
- Cortex Agents
- Cortex model-routing configuration

Those objects are created in their dedicated rounds.

## Idempotency

Bootstrap creation statements use `IF NOT EXISTS`. The scripts are designed to be safely rerunnable for this demo, but they do not overwrite existing object configuration. If an object already exists with different settings, inspect it before altering it.
