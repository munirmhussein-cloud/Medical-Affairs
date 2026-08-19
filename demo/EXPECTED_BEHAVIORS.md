# Expected Demo Behaviors

The final Snowflake implementation must satisfy these behavioral contracts.

## Grounding

- Scientific claims must be grounded in staged evidence.
- Source documents should be identifiable in the response path.
- Structured results and narrative evidence should remain distinguishable.

## Governance

- `APPROVED` evidence may support governed answers.
- `DRAFT` and `EXPIRED` artifacts must be filterable and must not silently support approved-response claims.
- Unsupported questions should result in an explicit evidence limitation rather than hallucinated support.

## Safety boundary

- No patient diagnosis.
- No treatment recommendation.
- No patient-level data.
- No implication that synthetic content is real AbbVie evidence.

## Orchestration

- Search-only questions should not require unnecessary structured analysis.
- Quantitative questions should use the semantic/structured layer.
- Combined questions should be able to use both evidence types.
- The user should not need to select the underlying tool or model manually.

## Demo usability

- Responses should be concise enough for a Medical Affairs professional preparing for an HCP discussion.
- The hero response should expose a summary, supporting evidence, citations, and logical follow-up.
- Technical failure should fail safely and visibly rather than manufacture an answer.
