# Round 4 Scientific Document Corpus Validation

## Synthetic-only boundary
All documents in this directory are fictional demonstration content. None are real AbbVie documents, real prescribing information, real publications, or medical guidance.

## Corpus coverage
The corpus includes:
- Phase III study summaries for ST-301, ST-302, ST-303;
- Phase II study summary for ST-210;
- publication-style abstracts for the three Phase III studies;
- synthetic product information for Aurelimab;
- one approved Medical Information efficacy response;
- one scientific FAQ;
- one Medical Affairs evidence-response SOP;
- one deliberately DRAFT ongoing-study note for ST-220.

## Cross-modal consistency checks
The following values must agree with `data/structured/efficacy_endpoint.csv`:

| Evidence | Expected value |
|---|---:|
| ST-301 overall Week 12 response delta | 26.0 points |
| ST-301 biologic-naive response delta | 30.0 points |
| ST-302 overall Week 12 response delta | 27.0 points |
| ST-302 biomarker-positive response delta | 35.0 points |
| ST-302 biomarker-negative response delta | 22.0 points |
| ST-303 Week 52 remission delta | 24.0 points |
| ST-303 biologic-naive remission delta | 29.0 points |
| ST-210 high-dose response delta | 34.0 points |
| ST-210 low-dose response delta | 20.0 points |

## Hero-query expected synthesis
For a question asking which staged Phase III populations showed the strongest response differences, the system should identify:
1. ST-302 biomarker-positive subgroup — 35.0 points.
2. ST-301 biologic-naive subgroup — 30.0 points.
3. ST-303 biologic-naive responder subgroup — 29.0 points.

The response must preserve the caveat that these are descriptive, synthetic cross-study observations and not evidence of superiority or predictive validity.

## Governance test
`DOC-NOVA-220-DRAFT` is intentionally DRAFT. It states that ST-220 is ongoing and contains no approved efficacy results. Future Search/Agent logic must not use it as support for an approved efficacy conclusion.

## Retrieval metadata requirements
Round 7/9 ingestion should preserve at least:
- document_id
- document_type
- product_id
- indication_id
- study_id
- approval_status
- region
- source_type
- citation_label
- synthetic_flag

Cortex Search should support filtering on `approval_status` and relevant business metadata so an approved Medical Affairs answer can be grounded only in approved evidence.
