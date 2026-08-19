# Dynamic Model Routing — Panel Narrative

## One-line message

Snowflake's Dynamic Model Routing supports **intelligence efficiency**: matching each task to an appropriate approved model across quality, cost, and latency rather than standardizing every workflow on one model.

## 30-second talk track

Medical Affairs requests vary dramatically in complexity. A bounded summary, a quantitative comparison, and a multi-source HCP-preparation workflow should not automatically consume the same reasoning budget. Snowflake's announced Dynamic Model Routing in Cortex AI Gateway is designed to evaluate tasks against customer-approved model policies and cost/performance tradeoffs so the system—not the end user—manages that complexity.

## What this demo proves

The repository stages three complexity classes against one governed Medical Affairs Agent. The live workflow can show that the same business surface supports simple retrieval, structured comparison, and multi-tool reasoning. If the target account exposes routing policy or model-selection details, they may be shown exactly as returned.

## What this demo does not claim

Unless Snowflake exposes the values live, do not claim:

- which model was selected,
- why a particular model won,
- precise per-request cost,
- precise cost savings,
- precise latency savings,
- internal evaluation scores.

## Executive bridge

The point is not model novelty. The point is operating AI economically at enterprise scale while preserving quality and governance.

## Technical bridge

The Agent remains grounded on the same Search and Analyst tools. Routing optimizes the model layer beneath the workflow; it does not weaken the approval filter, semantic model, citations, or evidence boundaries.
