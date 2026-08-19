# Round 3 Validation Contract

## Expected row counts

| Dataset | Rows |
|---|---:|
| therapeutic_area | 2 |
| product | 3 |
| indication | 4 |
| study | 5 |
| treatment_arm | 11 |
| patient_population | 11 |
| efficacy_endpoint | 14 |
| safety_event | 21 |

## Referential integrity checks

- Every `product.therapeutic_area_id` exists in `therapeutic_area`.
- Every `indication.product_id` exists in `product`.
- Every `study.product_id` and `study.indication_id` resolves to its parent records.
- Every `treatment_arm.study_id` and `patient_population.study_id` resolves to `study`.
- Every efficacy row resolves to its study, active treatment arm, population, and a reserved Round 4 `source_document_id`.
- Every safety row resolves to its study, treatment arm, and a reserved Round 4 `source_document_id`.

## Arithmetic checks

Treatment-arm counts sum to study enrollment for all five studies:

- ST-301: 300 + 300 = 600
- ST-302: 360 + 360 = 720
- ST-303: 240 + 240 = 480
- ST-210: 80 + 80 + 80 = 240
- ST-220: 150 + 150 = 300

Subgroup counts are internally consistent where subgroups partition the full population:

- ST-301: biologic-naive 300 + biologic-experienced 300 = 600
- ST-302: biomarker-positive 250 + biomarker-negative 470 = 720
- ST-303: biologic-naive responders 220 + biologic-experienced responders 260 = 480

For every populated efficacy row, `delta_vs_comparator = result_value - comparator_value`.

## Deliberate expected answers

These facts should remain stable through later rounds so the live demonstration is deterministic:

- AURORA-302 biomarker-positive participants show the largest staged Phase III subgroup delta: **35 percentage points**.
- AURORA-301 biologic-naive participants show a **30-point** synthetic response delta versus comparator.
- AURORA-303 biologic-naive maintenance responders show a **29-point** synthetic Week 52 remission delta.
- AURORA-302 has a **27-point** overall primary endpoint delta; AURORA-301 has **26 points**.
- AURORA-210 shows a synthetic dose-response pattern: high dose **34-point** delta versus low dose **20-point** delta.
- Serious adverse event rates are staged as low and broadly balanced across active and placebo arms in the Phase III studies.
- NOVA-220 intentionally has **no staged efficacy or safety outcome rows** because it is marked ongoing.

## Round 4 dependency

Round 4 must create the following source documents at minimum so all current evidence rows can be grounded:

- `DOC-ST301-CSR`
- `DOC-ST301-PUB`
- `DOC-ST302-CSR`
- `DOC-ST302-PUB`
- `DOC-ST303-CSR`
- `DOC-ST303-PUB`
- `DOC-ST210-CSR`

The unstructured corpus must reproduce the structured facts accurately enough that Cortex Search and Cortex Analyst can converge on the same answer during the hero workflow.
