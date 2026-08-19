# Round 6 — Snowflake Git Integration

This directory configures Snowflake to clone and refresh the public repository `https://github.com/munirmhussein-cloud/Medical-Affairs.git`.

## Scope

Round 6 does only four things:

1. Creates the account-level API integration used for Git-over-HTTPS.
2. Grants the demo role permission to use that integration and create a Git repository object in the demo schema.
3. Creates `MEDICAL_AFFAIRS_GIT_REPO` as a Snowflake Git repository clone.
4. Fetches and validates the `main` branch and the source artifacts needed for later rounds.

No native tables are loaded in this round. The Git repository stage is the synchronized source artifact layer; Round 7 will materialize structured CSVs and document metadata/content into Snowflake-native objects.

## Execution order

Run after the Round 5 bootstrap:

```sql
-- Account-level integration
EXECUTE IMMEDIATE FROM @<deployment-stage>/snowflake/git/00_create_git_api_integration.sql;

-- Repository clone in MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS
EXECUTE IMMEDIATE FROM @<deployment-stage>/snowflake/git/01_create_git_repository.sql;

-- Fetch and inspect
EXECUTE IMMEDIATE FROM @<deployment-stage>/snowflake/git/02_fetch_and_validate_git_repository.sql;
```

For the first Snowflake bootstrap, these scripts can also be pasted into Snowsight in sequence. Once `MEDICAL_AFFAIRS_GIT_REPO` exists, later SQL committed to this repository can be executed directly with `EXECUTE IMMEDIATE FROM @MEDICAL_AFFAIRS_GIT_REPO/branches/main/<path>.sql` after a fetch.

## Authentication decision

The GitHub repository is public. Round 6 intentionally uses Snowflake's no-authentication Git setup:

- `API_PROVIDER = git_https_api`
- `API_ALLOWED_PREFIXES = ('https://github.com/munirmhussein-cloud')`
- no `SECRET`
- no `GIT_CREDENTIALS`

If the repository is made private later, this design must be revisited and a supported Snowflake secret/OAuth or Snowflake GitHub App flow should be used. Never commit GitHub credentials to this repository.

## Refresh workflow

After pushing changes to GitHub:

```sql
USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

ALTER GIT REPOSITORY MEDICAL_AFFAIRS_GIT_REPO FETCH;
SHOW GIT BRANCHES IN GIT REPOSITORY MEDICAL_AFFAIRS_GIT_REPO;
LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/;
```

`FETCH` synchronizes remote branches/tags/commits into the Snowflake repository clone and prunes remote references that no longer exist.

## Expected objects

- API integration: `MEDICAL_AFFAIRS_GIT_API_INTEGRATION`
- Git repository: `MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_AFFAIRS_GIT_REPO`
- Default branch expected: `main`

## Round 6 validation

A successful run should show:

- `MEDICAL_AFFAIRS_GIT_REPO` in `SHOW GIT REPOSITORIES`.
- `main` in `SHOW GIT BRANCHES`.
- repository origin equal to the GitHub HTTPS URL.
- repository files visible through `LS @MEDICAL_AFFAIRS_GIT_REPO/branches/main/`.
- Round 3 CSVs and Round 4 document metadata visible in their expected repository paths.

Do not use Round 6 validation as evidence that the data is queryable through Cortex. Native materialization, semantic modeling, Search, and Agent configuration remain later rounds.
