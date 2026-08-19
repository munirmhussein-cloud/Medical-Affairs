# Structured Synthetic Data — Round 3

All files in this directory are **fictional synthetic demo data** created for the Medical Affairs Decision Intelligence Snowflake demonstration. They are not AbbVie data, do not represent real products or clinical studies, and must not be used for medical decision-making.

## Files

- `therapeutic_area.csv`
- `product.csv`
- `indication.csv`
- `study.csv`
- `treatment_arm.csv`
- `patient_population.csv`
- `efficacy_endpoint.csv`
- `safety_event.csv`

The authoritative field and relationship contract is `data/schemas/structured_schema.json`.

## Deliberate analytical patterns

The dataset intentionally contains patterns that make natural-language analysis meaningful without requiring a large dataset:

1. **Replicated Phase III efficacy** — AURORA-301 and AURORA-302 both show a clear synthetic treatment effect over placebo at Week 12.
2. **Subgroup differentiation** — biologic-naive participants in AURORA-301 and biomarker-positive participants in AURORA-302 have the largest synthetic treatment deltas.
3. **Maintenance durability** — AURORA-303 demonstrates a synthetic Week 52 remission advantage after induction response.
4. **Balanced safety context** — common adverse events are somewhat higher for active therapy, while synthetic serious-event rates remain low and broadly balanced versus placebo.
5. **Dose-response signal** — AURORA-210 includes synthetic low- and high-dose arms to support a simple dose-response question.
6. **Evidence boundary** — NOVA-220 is ongoing and intentionally has no efficacy endpoint rows. The eventual agent should not invent results for it.

## Analyst-ready questions

Examples the semantic layer should eventually support:

- Which Phase III study had the largest treatment effect on its primary endpoint?
- Compare the primary endpoint results in AURORA-301 and AURORA-302.
- Which studied population showed the strongest response to Aurelimab?
- How did biologic-naive and biologic-experienced participants differ in AURORA-301?
- What was the Week 52 remission difference in AURORA-303?
- Summarize serious adverse event rates for active therapy versus placebo across the Phase III program.
- Is there evidence of a dose-response relationship in AURORA-210?
- What efficacy results are available for NOVA-220? The correct answer is that none are staged because the synthetic study is ongoing.

## Reserved document IDs

`efficacy_endpoint.csv` and `safety_event.csv` reference document IDs such as `DOC-ST301-CSR` and `DOC-ST301-PUB`. These are intentional forward references. Round 4 must create matching synthetic scientific documents so every evidence row can later be cited back to an unstructured source.
