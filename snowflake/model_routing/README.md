# Round 11 — Dynamic Model Routing / Intelligence Efficiency

## Purpose

Stage the model-routing portion of the Medical Affairs Decision Intelligence demo without fabricating routing telemetry or assuming account capabilities that have not been validated.

Snowflake announced Dynamic Model Routing in Cortex AI Gateway on August 18, 2026. The product narrative is **intelligence efficiency**: customers define approved models and the tradeoffs they care about; Cortex AI Gateway evaluates tasks against those policies plus cost/performance signals and selects an appropriate model. The announcement also describes a feedback loop in which output quality can inform future routing decisions.

This repository deliberately separates:

1. **Supported public product narrative** — safe to explain during the panel.
2. **Account-validated configuration** — must be confirmed in the target Snowflake account before the live demo.
3. **Observable demo behavior** — response, latency/runtime observations, task class, and policy intent that we can show without inventing hidden router telemetry.

## Business narrative

The Medical Affairs workflow contains tasks with different complexity profiles:

- simple evidence summarization,
- quantitative comparison,
- multi-source scientific synthesis and HCP preparation.

The executive point is not that every task should use the same frontier model. The point is that an enterprise should optimize the system around the task across **quality, cost, and latency** while preserving approved model policy and governed data access.

## Demo classes

### Class A — Simple

Example: `Summarize the primary endpoint for AURORA-301.`

Desired story: a bounded task should not require the same reasoning budget as a multi-source synthesis.

### Class B — Comparative

Example: `Compare the Phase III treatment differences across AURORA-301 and AURORA-302.`

Desired story: moderate reasoning and structured comparison.

### Class C — Hero / complex

Example: `Reconcile approved scientific documents with structured efficacy evidence across AURORA-301, AURORA-302, and AURORA-303 and prepare three evidence-backed HCP discussion points.`

Desired story: higher reasoning complexity, multiple tools, governance checks, citations, and synthesis.

## What may be shown live

Safe observable elements:

- exact user prompt,
- Agent tools invoked when Snowflake exposes that information,
- retrieved/cited sources,
- structured results,
- final grounded response,
- elapsed time measured externally by the operator if useful,
- configured/approved routing policy **only if the target account exposes it**,
- explicitly labeled task class used for the demo narrative.

## What must never be fabricated

Do not invent:

- selected model name,
- router score,
- hidden quality score,
- token cost,
- routing confidence,
- model-evaluator result,
- cost savings percentage,
- latency savings percentage.

If the live account does not expose those fields, say:

> Dynamic Model Routing is designed to optimize model selection across the cost, quality, and latency tradeoff. In this demo I am showing the workload classes and governed workflow; I am not claiming hidden router telemetry that Snowflake does not expose in this surface.

## Files

- `00_routing_capability_check.sql` — account-safe discovery queries and comments; no guessed configuration syntax.
- `01_routing_demo_workloads.sql` — staged workload prompts for simple, comparative, and hero requests.
- `ROUTING_NARRATIVE.md` — panel talking points and claims boundary.
- `OBSERVABILITY_CONTRACT.md` — what can/cannot be shown.

## Completion boundary

Round 11 repository staging is complete when these files exist. Account-specific router configuration remains **PENDING LIVE ACCOUNT VALIDATION** until Snowflake exposes/documented syntax is confirmed in the target account.