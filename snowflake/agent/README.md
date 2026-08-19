# Round 10 — Cortex Agent

This directory defines `MEDICAL_AFFAIRS_AGENT`, the orchestration layer for the synthetic Medical Affairs Decision Intelligence demo.

## Purpose

The Agent combines two governed Snowflake-native tools:

1. `MEDICAL_SCIENTIFIC_SEARCH` for approved unstructured scientific evidence.
2. `CLINICAL_EVIDENCE_SEMANTIC_VIEW` through Cortex Analyst for structured clinical evidence.

The Agent is intentionally narrow. It does not provide patient-specific treatment recommendations or general medical advice.

## Governance design

The Search tool resource is hard-filtered to:

```yaml
filter:
  '@eq':
    approval_status: APPROVED
```

This means the Agent cannot retrieve DRAFT or EXPIRED documents through its standard scientific-evidence tool. The draft NOVA-220 development note remains in the underlying Search service for direct governance demonstrations, but it is intentionally unavailable to `MEDICAL_AFFAIRS_AGENT`.

The orchestration instructions also require the Agent to:

- treat all staged therapy/study data as synthetic;
- distinguish retrieved facts from synthesis;
- use Analyst for quantitative evidence;
- use Search for narrative/source evidence;
- use both tools for mixed questions;
- state when approved evidence is insufficient;
- avoid patient diagnosis, prescribing, and treatment recommendations.

## Files

Run in this order after Rounds 5–9 have been executed in the target Snowflake account:

1. `00_agent_privileges.sql`
2. `01_create_medical_affairs_agent.sql`
3. `02_validate_medical_affairs_agent.sql`

## Hero workflow

The primary demonstration prompt is:

> Compare the approved scientific evidence with the structured efficacy results across AURORA-301, AURORA-302, and AURORA-303. Identify the staged populations with the strongest descriptive treatment differences and prepare three evidence-backed discussion points for an upcoming HCP meeting. Include source labels and limitations.

Expected orchestration:

```text
User question
    ↓
Cortex Agent
    ├── Cortex Search → APPROVED scientific documents
    └── Cortex Analyst → structured efficacy evidence
             ↓
       Evidence reconciliation
             ↓
       Grounded synthesis
       + source labels
       + limitations
```

The deliberate strongest Phase III subgroup signal in the synthetic dataset is:

- AURORA-302 biomarker-positive subgroup: 78% vs 43%, a 35 percentage-point difference.

Other staged comparison anchors:

- AURORA-301 biologic-naive subgroup: 72% vs 42%, a 30-point difference.
- AURORA-303 biologic-naive maintenance responders: 56% vs 27%, a 29-point difference.

## Governance test

Ask:

> What approved efficacy evidence supports Neravilimab in NOVA-220?

Expected response: approved evidence is insufficient/unavailable. ST-220 has no staged efficacy endpoints and the only unstructured development note is DRAFT, which the Agent Search tool cannot retrieve.

## Scope boundary

Round 10 does not configure explicit orchestration-model optimization or Dynamic Model Routing. That remains Round 11.
