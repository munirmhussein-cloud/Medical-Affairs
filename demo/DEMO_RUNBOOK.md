# Round 13 — Demo Runbook

## Purpose

Provide the operator sequence for the final Snowflake Medical Affairs Decision Intelligence demonstration. This is the **technical operator runbook**, not the final click-by-click presentation script. Detailed UI clicks and spoken script will be refined after live account execution and validation.

## Demo objective

Show one coherent Medical Affairs workflow:

`Ask → retrieve approved evidence → analyze structured clinical data → reason across both → cite → state limitations → recommend next evidence step`

The demo should feel like a Medical Affairs professional doing work, not a tour of Snowflake features.

---

# Pre-demo readiness

Before the panel, confirm:

1. Git repository `main` is current.
2. Snowflake Git repository clone has been fetched.
3. Round 5 bootstrap objects exist.
4. Round 7 physical tables contain expected row counts.
5. `CLINICAL_EVIDENCE_SEMANTIC_VIEW` exists and validated queries return expected anchors.
6. `MEDICAL_SCIENTIFIC_SEARCH` is active and approved-only query tests pass.
7. `MEDICAL_AFFAIRS_AGENT` exists and can invoke both tools.
8. Golden Queries 1–4 have been run successfully in the target account.
9. Dynamic Model Routing account capability has been checked and observability recorded.
10. Backup screenshots have been captured after successful validation.

---

# Operator sequence

## 1. Establish the Agent surface

Open the supported Snowflake surface for `MEDICAL_AFFAIRS_AGENT`.

Technical talking point:

> This is one governed Medical Affairs experience over two different evidence modalities: structured clinical evidence and approved scientific knowledge.

Do not begin by describing products.

---

## 2. Run a simple approved-evidence question

Prompt:

`What approved Phase III efficacy evidence is available for Aurelimab in IND-001?`

Highlight:

- grounded evidence,
- source labels,
- approved retrieval boundary,
- concise Medical Affairs response.

Technical talking point:

> The user does not need to know where each document lives. The Search tool retrieves semantically relevant evidence while the Agent's tool resource enforces approved-only retrieval.

Optional technical reveal:

Show `MEDICAL_SCIENTIFIC_SEARCH` attributes and fixed approval filter if appropriate.

---

## 3. Run structured evidence question

Prompt:

`Which staged Phase III patient subgroup showed the largest treatment difference versus comparator?`

Expected anchor:

AURORA-302 biomarker-positive: 78% vs 43%, 35-point difference.

Technical talking point:

> This is not document search. The Agent routes the quantitative question to Cortex Analyst over a semantic view expressed in Medical Affairs vocabulary.

Optional technical reveal:

Show the semantic view / generated structured analysis if exposed.

---

## 4. Run the hero workflow

Prompt:

`Using approved scientific documents and structured efficacy evidence, reconcile AURORA-301, AURORA-302, and AURORA-303. Identify the strongest descriptive Phase III subgroup differences and prepare three evidence-backed discussion points for an HCP meeting. Include source labels and limitations.`

Expected anchors:

- 35 points — AURORA-302 biomarker-positive.
- 30 points — AURORA-301 biologic-naive.
- 29 points — AURORA-303 biologic-naive maintenance responders.

Highlight:

- both tools,
- reconciliation of structured + unstructured data,
- citations/source labels,
- three discussion points,
- limitations.

Technical talking point:

> The Agent is not simply returning documents or SQL results. It coordinates the appropriate tools and synthesizes them into an evidence-backed workflow.

---

## 5. Demonstrate governance boundary

Prompt:

`What approved efficacy evidence supports Neravilimab in NOVA-220?`

Expected behavior:

Insufficient approved efficacy evidence.

Technical talking point:

> The underlying corpus contains a draft NOVA-220 development note, but the Agent's standard Medical Affairs Search resource is fixed to approved evidence, and the structured dataset contains no efficacy endpoints. The correct answer is therefore that approved evidence is insufficient.

This is the primary trust moment.

---

## 6. Introduce intelligence efficiency / model routing

Use simple, comparative, and hero workload classes from `snowflake/model_routing/01_routing_demo_workloads.sql`.

Technical talking point:

> These requests have materially different reasoning complexity. Snowflake's Dynamic Model Routing announcement frames this as intelligence efficiency: selecting among customer-approved models using cost, quality, and latency tradeoffs so users do not have to manage model choice themselves.

If routing details are visible in the account:

Show only the exact configuration or telemetry returned by Snowflake.

If routing details are not visible:

Say explicitly that the workload classes are demo labels and use the capability as an architectural/optimization discussion rather than pretending to display a routing decision.

---

# Reset / recovery steps

## Git source refresh

Run the Round 6 fetch/validation sequence.

## Reload native data

Run Round 7 scripts in documented order.

## Recreate semantic layer

Run Round 8 verify then create scripts.

## Recreate Search

Run Round 9 privilege/create/validation scripts.

## Recreate Agent

Run Round 10 privilege/create/validation scripts.

## Re-run golden queries

Use `demo/GOLDEN_QUERY_VALIDATION.md` before returning to the live demo.

---

# Troubleshooting decision tree

### Search works; Analyst fails

- verify semantic view exists,
- verify Analyst database role/grants,
- run Round 8 structured validation,
- continue with Search-only backup if needed.

### Analyst works; Search fails

- verify Search service state,
- verify Cortex Search access/embedding role,
- validate approved filter attributes,
- continue with structured evidence backup if needed.

### Agent cannot use both tools

- verify Agent tool bindings and resource names,
- verify `USAGE` privileges,
- run each tool independently,
- use direct tool results as backup and explain that Agent orchestration is the integration layer.

### Agent response contradicts staged numbers

Do not rationalize the answer. Stop and validate against Round 12 anchors.

### Draft evidence appears in approved workflow

Do not continue the hero story. Verify the Agent Search resource fixed filter before proceeding.

### Dynamic routing detail is unavailable

Use the documented intelligence-efficiency narrative. Never invent model names or economics.

---

# Backup assets

After live validation, capture screenshots into `demo/screenshots/` for:

- approved Search,
- Analyst subgroup ranking,
- combined Agent hero response,
- NOVA governance response,
- routing surface if exposed.

Keep backup assets clearly labeled as previously captured validation output.

---

# End state

The final technical demonstration should leave the audience with five conclusions:

1. Snowflake can work across structured and unstructured Medical Affairs evidence.
2. Users interact in business language rather than raw schemas or repositories.
3. Governance is part of retrieval/orchestration, not an afterthought.
4. The Agent can move from retrieval to evidence-backed decision support.
5. The architecture has a credible efficiency story for scaling AI across tasks with different complexity profiles.
