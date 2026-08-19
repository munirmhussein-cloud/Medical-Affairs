# Architecture Decision Log

## ADR-001 — GitHub is source control; Snowflake is execution
Repository artifacts originate in GitHub, while live demo data and AI workloads execute inside Snowflake.

## ADR-002 — Synthetic data only
No confidential, PHI, PII, proprietary AbbVie data, or patient-level records are permitted.

## ADR-003 — Snowflake-native presentation surface
No Streamlit or external frontend is required for the critical demo path. A later round may add one only if it materially improves the walkthrough.

## ADR-004 — One narrow use case
The primary workload is **Medical Affairs Decision Intelligence**.

## ADR-005 — Business workflow before products
The final demonstration should expose Snowflake capabilities through one coherent Medical Affairs interaction rather than sequential feature demos.

## ADR-006 — Deterministic golden queries
The build must support validated search-only, structured, combined, and unsupported-evidence scenarios.

## ADR-007 — Fictional product evidence by default
Synthetic efficacy/safety claims should use fictional product/study names rather than fabricated claims attached to a real marketed therapy.

## ADR-008 — Aggregate evidence only
Patient populations are modeled as aggregate study cohorts, never as individual patient records.
