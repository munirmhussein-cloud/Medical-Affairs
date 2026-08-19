# Round 8 — Semantic Layer

This directory defines `CLINICAL_EVIDENCE_SEMANTIC_VIEW`, the business-language layer used by Cortex Analyst for the Medical Affairs Decision Intelligence demo.

## Design goal

The semantic layer should let a Medical Affairs professional ask questions using terms such as:

- Phase III studies
- primary efficacy results
- patient subgroup
- biologic-naive population
- biomarker-positive population
- response rate
- comparator / placebo rate
- treatment difference
- serious adverse event rate
- maintenance response

without needing to know physical table or column names.

## Architecture

The semantic view intentionally stays focused. It exposes three logical tables:

1. `study_overview` — one row per study for program status, design, phase, enrollment, and dates.
2. `efficacy_evidence` — a flattened logical evidence table joining endpoint, study, product, indication, treatment arm, and patient-population context.
3. `safety_evidence` — a flattened logical safety table joining aggregate safety observations to study, product, indication, and treatment-arm context.

The flattened evidence definitions reduce relationship ambiguity for Cortex Analyst while still deriving exclusively from the native Round 7 Snowflake tables.

## Business rules encoded

The model explicitly instructs Cortex Analyst to:

- treat every result as synthetic demonstration evidence;
- rank 'strongest subgroup' questions by `delta_vs_comparator`, not active-arm rate alone;
- distinguish Week 12 induction from Week 52 maintenance outcomes;
- avoid inferring efficacy where no endpoint rows exist;
- describe subgroup comparisons as descriptive evidence rather than treatment guidance;
- reject patient-level diagnosis or treatment-selection questions.

## Verified queries

The YAML includes verified examples for:

- strongest Phase III subgroup difference;
- primary Phase III efficacy comparison;
- serious adverse-event comparison by arm;
- the staged boundary around NOVA-220 efficacy evidence.

These are intended both as Cortex Analyst guidance and as onboarding questions for the demo.

## Execution order

Run after Rounds 5–7 have been executed in the target Snowflake account:

1. `00_semantic_privileges.sql`
2. `01_verify_semantic_view.sql`
3. `02_create_semantic_view.sql`
4. `03_validate_semantic_view.sql`

`01_verify_semantic_view.sql` calls `SYSTEM$CREATE_SEMANTIC_VIEW_FROM_YAML(..., verify_only => TRUE)` before the object is created. The creation script uses create-or-alter behavior so later semantic refinements can preserve compatible object state.

## Source control pattern

`clinical_evidence_semantic_view.yaml` is authoritative and remains in GitHub. The SQL scripts fetch the latest `main` branch from `MEDICAL_AFFAIRS_GIT_REPO`, reconstruct the YAML text from the Git repository clone using the Round 7 line-oriented text file format, and pass that YAML into Snowflake's semantic-view system procedure.

## Cortex Analyst access

Round 8 grants `SNOWFLAKE.CORTEX_ANALYST_USER` to `MEDICAL_AFFAIRS_DEMO_ROLE`. This is intentionally narrower than granting the broader `SNOWFLAKE.CORTEX_USER` database role.

## Validation targets

The semantic layer must preserve the deliberate Round 3 evidence patterns:

- AURORA-302 biomarker-positive subgroup: 35.0 percentage-point staged difference — strongest Phase III subgroup.
- AURORA-301 biologic-naive subgroup: 30.0 points.
- AURORA-303 biologic-naive maintenance responders: 29.0 points.
- NOVA-220: ongoing study exists in study metadata but has no staged efficacy endpoint rows.

## Out of scope

Round 8 does not create:

- Cortex Search;
- a Cortex Agent;
- dynamic model routing;
- an application UI.

Those remain later rounds.
