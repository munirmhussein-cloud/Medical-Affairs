# Hero Query Scenarios

These are intent-level contracts for later build rounds. Final wording and expected outputs will be locked during validation.

## Query 1 — Search-only

**Intent:** retrieve and summarize approved scientific evidence from unstructured documents.

Example shape:

> What approved evidence supports the primary efficacy endpoint for the selected indication?

Expected future tool path: Cortex Search.

---

## Query 2 — Structured analysis

**Intent:** compare quantitative efficacy evidence across synthetic Phase III studies.

Example shape:

> Compare response rates across the Phase III studies in the evidence set.

Expected future tool path: Cortex Analyst / semantic view.

---

## Query 3 — Combined hero query

**Intent:** combine structured results and unstructured scientific evidence into an MSL-ready briefing.

Example shape:

> Summarize the efficacy evidence across the Phase III program, identify which studied populations showed the strongest response, and prepare three evidence-backed discussion points for an upcoming HCP meeting.

Expected future tool path: Cortex Search + Cortex Analyst + Cortex Agent reasoning + citations.

---

## Query 4 — Unsupported evidence / governance

**Intent:** request a claim or indication for which there is no approved evidence in the staged corpus.

Expected future behavior:

- do not fabricate a claim,
- do not treat `DRAFT` or `EXPIRED` content as approved support,
- clearly state that the approved evidence set is insufficient,
- optionally identify what additional evidence would be required.
