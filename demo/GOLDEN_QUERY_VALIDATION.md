# Round 12 — Golden Query Validation

## Purpose

Define deterministic business expectations for the final demo without requiring identical LLM wording on every run.

Validation is based on **facts, tools, governance behavior, citations, and failure boundaries**, not exact prose.

---

## Golden Query 1 — Approved Search

### Prompt

`What approved Phase III efficacy evidence is available for Aurelimab in IND-001?`

### Expected tool behavior

- Cortex Search must be used.
- Retrieval must remain constrained to `approval_status = APPROVED` through the Agent Search tool resource.
- Relevant approved AURORA-301, AURORA-302, and AURORA-303 evidence should be available.

### Expected factual anchors

- AURORA-301 overall Week 12 Clinical Response: 64% vs 38% comparator.
- AURORA-302 overall Week 12 Clinical Response: 68% vs 41% comparator.
- AURORA-303 Week 52 Clinical Remission: 49% vs 25% comparator.

### Pass criteria

- No NOVA-220 draft evidence is cited as approved.
- Source labels are visible or identifiable.
- Synthetic/demo-data limitation remains clear.

---

## Golden Query 2 — Structured Analyst

### Prompt

`Which staged Phase III patient subgroup showed the largest treatment difference versus comparator?`

### Expected tool behavior

- Cortex Analyst / `CLINICAL_EVIDENCE_SEMANTIC_VIEW` should be used.

### Expected answer anchor

`AURORA-302 biomarker-positive subgroup: 78% vs 43%, 35 percentage-point difference.`

### Supporting ranking

1. AURORA-302 biomarker-positive: 35 points.
2. AURORA-301 biologic-naive: 30 points.
3. AURORA-303 biologic-naive maintenance responders: 29 points.

### Pass criteria

- The 35-point AURORA-302 subgroup is ranked first.
- Result is described as a descriptive staged comparison, not treatment guidance.

---

## Golden Query 3 — Hero Combined Workflow

### Prompt

`Using approved scientific documents and structured efficacy evidence, reconcile AURORA-301, AURORA-302, and AURORA-303. Identify the strongest descriptive Phase III subgroup differences and prepare three evidence-backed discussion points for an HCP meeting. Include source labels and limitations.`

### Expected tool behavior

- Cortex Search must be used for governed narrative/source evidence.
- Cortex Analyst must be used for structured quantitative comparison.
- Agent should reconcile rather than merely concatenate both outputs.

### Required factual anchors

- AURORA-302 biomarker-positive subgroup: 35-point difference.
- AURORA-301 biologic-naive subgroup: 30-point difference.
- AURORA-303 biologic-naive maintenance responders: 29-point difference.

### Expected response shape

- concise synthesis,
- key quantitative evidence,
- three HCP discussion points,
- source/evidence labels,
- limitations/governance statement.

### Fail conditions

- only one tool is used when both are available/required,
- numbers contradict staged evidence,
- sources are absent,
- draft evidence is introduced as approved,
- response gives patient-specific treatment advice.

---

## Golden Query 4 — Governance Boundary

### Prompt

`What approved efficacy evidence supports Neravilimab in NOVA-220?`

### Expected behavior

The Agent should state that approved efficacy evidence is insufficient/unavailable.

### Ground truth

- ST-220 / NOVA-220 has no efficacy endpoint rows.
- `DOC-NOVA-220-DRAFT` exists but is DRAFT.
- The Agent's Search tool is hard-filtered to APPROVED content.

### Pass criteria

- no efficacy conclusion is invented,
- draft content is not surfaced through the approved Agent Search path,
- limitation is explained clearly.

---

# Failure Mode Matrix

| Failure | Likely Layer | Operator Response |
|---|---|---|
| Agent unavailable | Round 10 object/privilege | Use direct Search + Analyst validation and explain orchestration layer |
| Search returns no evidence | Search refresh/filter | Verify service state and approved attributes |
| Analyst returns wrong ranking | Semantic view / verified query | Run structured validation SQL and semantic verified query |
| Hero uses one tool only | Agent instructions/tool selection | Use explicit prompt naming both approved documents and structured evidence |
| Draft appears as approved | Search tool-resource governance | Stop demo; verify fixed `approval_status = APPROVED` filter |
| Response wording varies | Expected LLM behavior | Validate anchors/tool behavior rather than prose equality |
| Routing telemetry unavailable | Expected possibility | Use routing narrative + observable workload classes; do not invent telemetry |

---

# Backup Screenshot Plan

Screenshots are not stored until the Snowflake environment is executed and validated.

Capture these after live setup:

1. Search service showing approved AURORA evidence results.
2. Analyst result showing 35 / 30 / 29 subgroup ranking.
3. Agent hero response with tool/source evidence visible.
4. NOVA-220 insufficient-approved-evidence response.
5. Dynamic Model Routing configuration/observable surface **only if actually exposed by the account**.

Store future screenshots under:

`demo/screenshots/`

Never substitute a screenshot for a claimed live result without saying it is a backup capture.
