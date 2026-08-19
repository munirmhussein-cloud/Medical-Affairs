# Security and Data Policy

This repository is public and must remain safe for demonstration use.

## Prohibited content

- PHI or PII
- Patient-level records
- Credentials, tokens, private keys, or passwords
- Confidential AbbVie information
- Internal Snowflake information not intended for public use
- Proprietary clinical datasets
- Copyrighted publications copied wholesale
- Fabricated clinical claims presented as real evidence about a real product

## Synthetic-data requirements

- Generated clinical/scientific artifacts must be labeled synthetic.
- Aggregate study counts and outcomes are acceptable when fictional.
- No row may contain patient name, DOB, MRN, address, phone, email, or other person-level identifier.
- Generated evidence should prefer fictional product names when making synthetic clinical claims.
- Public-source material may be referenced only with attribution and should remain distinguishable from generated content.

## Secret handling

- `.env` and private key formats are ignored by Git.
- `.env.example` contains variable names only.
- Snowflake credentials must be supplied outside source control.

## Medical-use boundary

This project demonstrates Medical Affairs evidence retrieval and decision support. It does not diagnose patients, prescribe therapy, replace professional medical judgment, or constitute medical guidance.
