# Architecture

## Business architecture

```text
Medical Affairs Question
       ↓
Enterprise Evidence
       ↓
Snowflake AI
       ↓
Evidence Synthesis
       ↓
Decision Support
```

## Planned technical architecture

```text
GitHub Repository
        │
        ▼
Snowflake Git Repository Clone
        │
        ▼
MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS
        │
        ├── Structured Clinical Tables
        ├── Scientific Document Corpus
        ├── Semantic View
        ├── Cortex Search Service
        └── Cortex Agent
                 │
                 ▼
          Live Snowflake Demo
```

## Architecture boundaries

- GitHub is source control and deployment input.
- Snowflake-native objects hold and query demo data at runtime.
- The final technical walkthrough should occur primarily inside Snowflake.
- CSV/Markdown files in GitHub are not intended to be queried directly by the live agent.
- No custom frontend is required unless explicitly added in a later round.

## Planned tool flow

- **Cortex Search:** narrative scientific evidence.
- **Cortex Analyst / Semantic View:** quantitative study evidence.
- **Cortex Agent:** decides which tools are needed and synthesizes the result.
- **Cortex AI/AISQL:** optional supporting summarization/extraction tasks.
- **Dynamic model routing / selection optimization:** demonstrated only through capabilities actually available in the live Snowflake account.
