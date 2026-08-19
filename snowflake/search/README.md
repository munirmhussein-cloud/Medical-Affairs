# Round 9 — Cortex Search

This directory builds and validates `MEDICAL_SCIENTIFIC_SEARCH`, the governed retrieval layer for the synthetic Medical Affairs Decision Intelligence demonstration.

## Design intent

The service is created over the native `SCIENTIFIC_DOCUMENT` table produced in Round 7. The searchable text column is `content`.

The following metadata columns are configured as Cortex Search `ATTRIBUTES` so callers can apply retrieval-time governance and scope filters:

- `approval_status`
- `document_type`
- `study_id`
- `product_id`
- `indication_id`
- `region`

The source query also returns document identity and citation-oriented fields including `document_id`, `title`, `citation_label`, dates, source type, and the full synthetic document content.

## Why DRAFT documents remain indexed

The corpus intentionally includes `DOC-NOVA-220-DRAFT`. It is not removed from the search index.

This is deliberate: the demonstration should show that governance is an explicit retrieval control rather than an invisible preprocessing decision. Approved Medical Affairs workflows must apply:

```json
{"@eq": {"approval_status": "APPROVED"}}
```

The Round 9 validation script demonstrates both sides of this behavior:

1. an APPROVED-filtered query for the NOVA program should not surface the draft development note; and
2. an explicitly DRAFT-filtered query can retrieve it for controlled internal context.

Round 10 Agent instructions must preserve this rule and apply APPROVED filtering for standard Medical Affairs evidence retrieval.

## Execution order

Run after Rounds 5–8 have been deployed in the target Snowflake account:

1. `00_cortex_search_privileges.sql`
2. `01_create_cortex_search_service.sql`
3. Wait for the service to finish initial indexing if necessary.
4. `02_validate_cortex_search_service.sql`
5. `03_demo_search_queries.sql`

## Service architecture

```text
SCIENTIFIC_DOCUMENT
        |
        | content = semantic search column
        |
        | attributes = approval/document/study/product/indication/region
        v
MEDICAL_SCIENTIFIC_SEARCH
        |
        +--> approved-evidence retrieval
        +--> study-specific retrieval
        +--> Medical Information retrieval
        +--> explicit governance filtering
```

## Search quality vs. governance

Semantic relevance does not override approval state.

A highly relevant DRAFT artifact is still unsuitable for an approved Medical Affairs response unless the workflow explicitly permits draft/internal evidence. The later Agent must therefore treat `approval_status` as a required policy control, not merely optional search metadata.

## Query validation

`02_validate_cortex_search_service.sql` uses `SNOWFLAKE.CORTEX.SEARCH_PREVIEW` only for build validation and demonstration rehearsal. It validates:

- service metadata/state;
- approved Aurelimab Phase III retrieval;
- AURORA-302 study-specific retrieval;
- US approved Medical Information response retrieval;
- exclusion of DRAFT NOVA-220 evidence under an APPROVED filter; and
- explicit retrieval of DRAFT NOVA-220 evidence when requested.

## Deferred to Round 10

Round 9 does **not** create a Cortex Agent. Round 10 will attach this service as a Search tool and will define tool descriptions, returned columns, orchestration rules, and dynamic approval/status filters.
