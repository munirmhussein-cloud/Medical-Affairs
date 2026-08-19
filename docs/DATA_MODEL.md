# Synthetic Data Model

## Objective

Define the canonical synthetic data model for the Medical Affairs Decision Intelligence demonstration. Later rounds must generate data that is internally consistent, safe for public use, and sufficient to demonstrate:

1. unstructured scientific evidence retrieval,
2. structured clinical evidence analysis,
3. cross-source reasoning,
4. source citation and provenance,
5. unsupported-question handling.

No real patient-level data is required or permitted.

---

## Design Principles

- **Synthetic-first:** all operational and clinical values are fictional unless explicitly marked as public reference metadata.
- **Aggregate only:** no patient-identifiable or row-level patient records.
- **Relational consistency:** study IDs, indications, arms, endpoints, documents, and approved responses must resolve across datasets.
- **Demo determinism:** the model must support a known set of golden questions with reproducible evidence.
- **Governed evidence:** documents carry approval status, source type, region, effective dates, and citation metadata.
- **Separation of fact and synthesis:** retrieved source content must remain distinguishable from agent-generated summaries.

---

# Domain Model

```text
THERAPEUTIC_AREA
    |
    +-- PRODUCT
    |     |
    |     +-- INDICATION
    |            |
    |            +-- STUDY
    |                   |
    |                   +-- TREATMENT_ARM
    |                   +-- EFFICACY_ENDPOINT
    |                   +-- SAFETY_EVENT
    |                   +-- PATIENT_POPULATION
    |
    +-- SCIENTIFIC_DOCUMENT
            |
            +-- DOCUMENT_CITATION
            +-- APPROVED_MEDICAL_RESPONSE
```

---

# Canonical Entities

## 1. THERAPEUTIC_AREA

Represents a broad scientific domain.

| Field | Type | Required | Notes |
|---|---|---:|---|
| therapeutic_area_id | VARCHAR | Yes | Stable synthetic key, e.g. `TA_IMMUNOLOGY` |
| therapeutic_area_name | VARCHAR | Yes | e.g. Immunology |
| description | VARCHAR | Yes | Synthetic high-level description |

Expected demo values initially: `Immunology`, with later optional expansion into Oncology and Neuroscience.

---

## 2. PRODUCT

Synthetic product entity used to anchor studies and documents.

| Field | Type | Required | Notes |
|---|---|---:|---|
| product_id | VARCHAR | Yes | Synthetic stable key |
| product_name | VARCHAR | Yes | Prefer fictional product name for generated clinical content |
| therapeutic_area_id | VARCHAR | Yes | FK to THERAPEUTIC_AREA |
| mechanism_summary | VARCHAR | Yes | Synthetic, non-medical-advice description |
| lifecycle_status | VARCHAR | Yes | `MARKETED`, `DEVELOPMENT`, `DISCONTINUED` |

**Rule:** Public product names may be referenced in presentation materials, but generated clinical evidence in the repo should default to fictional product names to avoid implying fabricated trial claims about a real therapy.

---

## 3. INDICATION

| Field | Type | Required | Notes |
|---|---|---:|---|
| indication_id | VARCHAR | Yes | Stable key |
| product_id | VARCHAR | Yes | FK |
| indication_name | VARCHAR | Yes | Synthetic disease/condition label or generic public disease area |
| disease_area | VARCHAR | Yes | Higher-level grouping |
| approval_status | VARCHAR | Yes | `APPROVED_DEMO`, `INVESTIGATIONAL_DEMO` |
| region | VARCHAR | Yes | e.g. `US`, `EU`, `GLOBAL_DEMO` |

---

## 4. STUDY

One record per synthetic clinical study.

| Field | Type | Required | Notes |
|---|---|---:|---|
| study_id | VARCHAR | Yes | e.g. `STUDY_IMM_301` |
| study_name | VARCHAR | Yes | Human-readable fictional study name |
| product_id | VARCHAR | Yes | FK |
| indication_id | VARCHAR | Yes | FK |
| phase | VARCHAR | Yes | `PHASE_2`, `PHASE_3` |
| study_design | VARCHAR | Yes | e.g. randomized, double-blind, synthetic description |
| comparator | VARCHAR | No | Synthetic comparator label |
| n_patients | INTEGER | Yes | Aggregate count |
| primary_endpoint_name | VARCHAR | Yes | Text label |
| study_status | VARCHAR | Yes | `COMPLETED`, `ONGOING`, `PLANNED` |
| start_date | DATE | Yes | Synthetic |
| completion_date | DATE | No | Synthetic |
| publication_date | DATE | No | Synthetic |
| evidence_tier | VARCHAR | Yes | `PRIMARY`, `SUPPORTING` |

---

## 5. TREATMENT_ARM

| Field | Type | Required | Notes |
|---|---|---:|---|
| treatment_arm_id | VARCHAR | Yes | Stable key |
| study_id | VARCHAR | Yes | FK |
| arm_name | VARCHAR | Yes | e.g. `Therapy A`, `Comparator` |
| treatment_type | VARCHAR | Yes | `ACTIVE`, `COMPARATOR`, `PLACEBO_DEMO` |
| n_patients | INTEGER | Yes | Must reconcile to study totals within documented tolerance |
| dosing_description | VARCHAR | No | Synthetic and non-prescriptive |

---

## 6. EFFICACY_ENDPOINT

Primary structured dataset for Cortex Analyst demonstration.

| Field | Type | Required | Notes |
|---|---|---:|---|
| endpoint_id | VARCHAR | Yes | Stable key |
| study_id | VARCHAR | Yes | FK |
| treatment_arm_id | VARCHAR | Yes | FK |
| population_id | VARCHAR | Yes | FK |
| endpoint_name | VARCHAR | Yes | e.g. `Clinical Response - Week 12` |
| endpoint_type | VARCHAR | Yes | `PRIMARY`, `SECONDARY`, `EXPLORATORY` |
| timepoint | VARCHAR | Yes | e.g. `WEEK_12` |
| result_value | NUMBER(10,4) | Yes | Synthetic aggregate metric |
| result_unit | VARCHAR | Yes | `%`, `mean`, etc. |
| comparator_value | NUMBER(10,4) | No | Synthetic |
| delta_vs_comparator | NUMBER(10,4) | No | Derivable or stored |
| p_value | NUMBER(10,6) | No | Synthetic; clearly demo-only |
| confidence_interval | VARCHAR | No | Synthetic string |
| source_document_id | VARCHAR | Yes | FK to SCIENTIFIC_DOCUMENT |

---

## 7. SAFETY_EVENT

Aggregate synthetic safety observations only.

| Field | Type | Required | Notes |
|---|---|---:|---|
| safety_event_id | VARCHAR | Yes | Stable key |
| study_id | VARCHAR | Yes | FK |
| treatment_arm_id | VARCHAR | Yes | FK |
| event_category | VARCHAR | Yes | Broad synthetic category |
| event_term | VARCHAR | Yes | Generic synthetic term |
| event_rate | NUMBER(10,4) | Yes | Aggregate percentage |
| serious_event_flag | BOOLEAN | Yes | Demo aggregate flag |
| source_document_id | VARCHAR | Yes | FK |

**Rule:** Safety data exists to demonstrate evidence synthesis, not medical decision-making.

---

## 8. PATIENT_POPULATION

Defines aggregate study cohorts, not individuals.

| Field | Type | Required | Notes |
|---|---|---:|---|
| population_id | VARCHAR | Yes | Stable key |
| study_id | VARCHAR | Yes | FK |
| population_name | VARCHAR | Yes | e.g. `Overall Population`, `Prior Therapy Exposed` |
| population_description | VARCHAR | Yes | Synthetic inclusion grouping |
| n_patients | INTEGER | Yes | Aggregate only |
| biomarker_status | VARCHAR | No | Synthetic category where useful |
| prior_therapy_status | VARCHAR | No | Synthetic category |

This entity supports the hero question asking which **studied populations** demonstrated the strongest response without introducing patient-level records.

---

## 9. SCIENTIFIC_DOCUMENT

Canonical metadata for all unstructured evidence.

| Field | Type | Required | Notes |
|---|---|---:|---|
| document_id | VARCHAR | Yes | Stable key |
| title | VARCHAR | Yes | Synthetic title |
| document_type | VARCHAR | Yes | Controlled vocabulary below |
| therapeutic_area_id | VARCHAR | Yes | FK |
| product_id | VARCHAR | No | FK |
| indication_id | VARCHAR | No | FK |
| study_id | VARCHAR | No | FK |
| publication_date | DATE | Yes | Synthetic |
| effective_date | DATE | Yes | Governing date |
| expiration_date | DATE | No | Optional |
| approval_status | VARCHAR | Yes | `APPROVED`, `DRAFT`, `EXPIRED` |
| region | VARCHAR | Yes | Controlled region |
| source_type | VARCHAR | Yes | `SYNTHETIC_INTERNAL`, `SYNTHETIC_PUBLICATION` |
| citation_label | VARCHAR | Yes | Human-readable citation |
| content | VARCHAR | Yes | Full synthetic text body |
| synthetic_flag | BOOLEAN | Yes | Always true for generated content |

### Controlled document types

- `STUDY_SUMMARY`
- `PUBLICATION_ABSTRACT`
- `PRESCRIBING_INFORMATION_DEMO`
- `APPROVED_MEDICAL_RESPONSE`
- `SCIENTIFIC_FAQ`
- `MEDICAL_AFFAIRS_SOP`
- `EVIDENCE_SUMMARY`

---

## 10. DOCUMENT_CITATION

Optional normalized citation layer for demonstrating provenance.

| Field | Type | Required | Notes |
|---|---|---:|---|
| citation_id | VARCHAR | Yes | Stable key |
| document_id | VARCHAR | Yes | FK |
| citation_order | INTEGER | Yes | Ordering |
| citation_text | VARCHAR | Yes | Display-safe citation text |
| source_reference | VARCHAR | No | Synthetic URI or public URL if explicitly sourced |
| public_source_flag | BOOLEAN | Yes | False unless genuinely public-source material |

---

## 11. APPROVED_MEDICAL_RESPONSE

A curated response artifact that can be retrieved by Cortex Search.

| Field | Type | Required | Notes |
|---|---|---:|---|
| response_id | VARCHAR | Yes | Stable key |
| document_id | VARCHAR | Yes | FK to SCIENTIFIC_DOCUMENT |
| question_category | VARCHAR | Yes | e.g. `EFFICACY`, `SAFETY`, `POPULATION` |
| approved_question | VARCHAR | Yes | Synthetic example inquiry |
| approved_response_summary | VARCHAR | Yes | Synthetic approved response |
| approval_status | VARCHAR | Yes | `APPROVED`, `EXPIRED` |
| effective_date | DATE | Yes | Synthetic |
| region | VARCHAR | Yes | Region scope |

---

# Referential Integrity Rules

1. Every STUDY must resolve to one PRODUCT and one INDICATION.
2. Every TREATMENT_ARM must resolve to one STUDY.
3. Every EFFICACY_ENDPOINT must resolve to a STUDY, TREATMENT_ARM, PATIENT_POPULATION, and source SCIENTIFIC_DOCUMENT.
4. Every SAFETY_EVENT must resolve to a STUDY, TREATMENT_ARM, and source SCIENTIFIC_DOCUMENT.
5. PATIENT_POPULATION records must reference valid STUDY records.
6. Study-level arm counts should reconcile to `STUDY.n_patients` within explicit documented rules.
7. All generated clinical claims used in golden demo answers must have a resolvable `source_document_id`.
8. Documents with `approval_status != APPROVED` must be filterable so the future agent/search service can exclude them from governed answers.
9. `synthetic_flag` must be true for all generated documents.
10. No row may contain patient name, DOB, address, MRN, email, phone, or other person-level identifiers.

---

# Demo-Specific Evidence Design

Round 3 and Round 4 must generate enough interconnected data to support four deterministic scenarios.

## Scenario A — Search-only

Question intent: locate and summarize approved scientific evidence.

Required evidence:
- at least 3 approved documents relevant to one indication,
- at least 1 irrelevant/different indication document,
- at least 1 draft document that should be excluded by governance filters.

## Scenario B — Structured analysis

Question intent: compare efficacy outcomes across Phase III studies.

Required evidence:
- 3 synthetic Phase III studies,
- at least 2 treatment arms per study,
- primary endpoint results,
- population-level result variation.

## Scenario C — Combined hero query

Question intent: synthesize efficacy evidence, identify the strongest studied population response, and prepare 3 HCP discussion points.

Required evidence:
- structured efficacy results,
- study summaries,
- publication-style abstracts,
- one approved medical response,
- citation linkage across all substantive claims.

## Scenario D — Unsupported evidence / governance

Question asks for an unsupported indication or claim.

Required state:
- no approved source evidence for the requested claim,
- optionally one `DRAFT` or `EXPIRED` artifact that must not be treated as approved evidence.

Expected future behavior: clearly state insufficient approved evidence rather than fabricate an answer.

---

# Round 3 Target Volumes

Initial target volumes for structured synthetic data generation:

| Dataset | Target Rows |
|---|---:|
| THERAPEUTIC_AREA | 1-3 |
| PRODUCT | 2-3 |
| INDICATION | 3-5 |
| STUDY | 8-12 |
| TREATMENT_ARM | 16-30 |
| PATIENT_POPULATION | 20-40 |
| EFFICACY_ENDPOINT | 60-120 |
| SAFETY_EVENT | 40-80 |

These volumes are intentionally small enough for deterministic demo validation while large enough to support meaningful natural-language analysis.

Round 4 should target approximately 25-35 unstructured synthetic documents.

---

# Naming Conventions

- Keys use uppercase domain prefixes: `STUDY_IMM_301`, `POP_IMM_301_OVERALL`.
- Generated fictional products should use neutral demo names, e.g. `Therapy A`, until a later round intentionally designs branded synthetic names.
- Dataset column names use `UPPER_SNAKE_CASE` in Snowflake and `lower_snake_case` in source CSV files where practical.
- Dates use ISO-8601 (`YYYY-MM-DD`).
- Rates stored numerically must have explicit units.

---

# Round 2 Completion Criteria

Round 2 is complete when:

- the entity model is documented,
- field definitions exist,
- relationships and integrity rules are explicit,
- demo evidence requirements are documented,
- safety/synthetic-data boundaries are explicit,
- machine-readable schema contracts exist under `data/schemas/`,
- future structured data generation can proceed without redefining the domain model.
