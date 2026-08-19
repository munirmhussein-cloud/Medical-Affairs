# Model Routing Observability Contract

## Purpose

Prevent the panel demo from overstating what the target Snowflake account exposes.

## Allowed live claims

A claim is allowed only when it is supported by one of these sources:

1. The August 18, 2026 Snowflake Dynamic Model Routing announcement.
2. Current Snowflake product documentation.
3. A value visibly returned by the target Snowflake account during the demo.

## Observable fields we may show

- prompt text,
- task class assigned by this demo (`SIMPLE`, `COMPARATIVE`, `HERO_COMPLEX`, `GOVERNANCE_BOUNDARY`),
- Search/Analyst tool usage when exposed,
- retrieved source labels,
- structured evidence returned,
- final response,
- elapsed wall-clock time measured by the operator,
- routing-policy configuration if exposed in the account,
- model name only if Snowflake explicitly returns it.

## Never fabricate

- router decision score,
- model-selection probability,
- model-evaluator score,
- token-cost estimate,
- cost-savings percentage,
- latency-savings percentage,
- quality uplift,
- hidden chain of thought.

## Fallback presentation

If the account exposes no routing details, use the three staged workload classes as the demonstration and explain the routing capability as a recently announced optimization layer. Do not present the task-class labels as Snowflake-generated telemetry.

## Live validation note template

Record before rehearsal:

- Date checked:
- Snowflake account/region (non-secret identifier only):
- Surface used:
- Routing configuration visible: YES / NO
- Selected model visible: YES / NO
- Cost data visible: YES / NO
- Latency data visible: YES / NO
- Tool trace visible: YES / NO
- Notes:
