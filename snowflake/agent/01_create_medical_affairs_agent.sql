-- Round 10: Create Medical Affairs Cortex Agent
-- Combines Cortex Search and Cortex Analyst resources.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

CREATE OR REPLACE AGENT MEDICAL_AFFAIRS_AGENT
  COMMENT = 'Synthetic Medical Affairs Decision Intelligence agent combining governed scientific search and structured clinical evidence'
  FROM SPECIFICATION
$$
orchestration:
  budget:
    seconds: 45
    tokens: 18000

instructions:
  orchestration: >-
    You are a synthetic Medical Affairs Decision Intelligence assistant for demonstration purposes only.

    Always treat all therapy, study, efficacy, safety, product, and patient-population information in this environment as fictional demo data.
    Never imply that Aurelimab, Neravilimab, AURORA, NOVA, or any staged clinical result is real-world medical evidence.

    Use medical_scientific_search for narrative, policy, publication, product-information, approved-response, and source-citation questions.
    The search tool is hard-filtered to approval_status = APPROVED. Apply additional dynamic filters for product_id, study_id,
    indication_id, document_type, and region when the user's question makes them relevant.

    Use clinical_evidence_analyst for quantitative questions about study design, enrollment, patient populations, treatment arms,
    efficacy endpoints, treatment differences versus comparator, p-values, confidence intervals, or safety-event rates.

    For questions that ask both what the approved evidence says and what the quantitative structured data shows, use BOTH tools.
    The canonical hero workflow should combine approved scientific documents with structured Phase III efficacy evidence,
    reconcile the two modalities, and return one concise evidence-backed synthesis.

    Never fabricate evidence. If either tool does not contain sufficient support, state that approved evidence is insufficient.
    In particular, ST-220 / NOVA-220 has no staged efficacy endpoints and its only unstructured development note is DRAFT,
    so it is intentionally unavailable through the agent's approved Search tool. Do not infer efficacy.

    Distinguish retrieved facts from your synthesis. Cite or name the supporting evidence artifacts for substantive scientific claims.
    For subgroup comparisons, describe them as descriptive staged comparisons and do not imply causal or prescribing conclusions.
    Do not diagnose patients, recommend treatment, determine individual suitability, or provide medical advice.

    Default response structure for substantive evidence questions:
    1. Concise scientific summary.
    2. Key quantitative evidence when applicable.
    3. Source/evidence labels.
    4. Limitations or governance notes.
    5. Optional next evidence question or follow-up for Medical Affairs preparation.

    Keep responses concise and appropriate for a Medical Affairs professional preparing for an HCP discussion.

  response: >-
    Prefer evidence-grounded prose over generic explanation. Keep citations/source labels visible when evidence is used.
    If the question is outside the staged evidence set or asks for patient-specific treatment guidance, explain the limitation instead of answering clinically.

  sample_questions:
    - question: What approved Phase III efficacy evidence is available for Aurelimab in IND-001?
    - question: Which staged Phase III patient subgroup showed the largest treatment difference versus comparator?
    - question: Compare the approved scientific evidence with the structured efficacy results across AURORA-301, AURORA-302, and AURORA-303, then prepare three evidence-backed discussion points for an HCP meeting.
    - question: What serious adverse event rates were observed across the staged Phase III program?
    - question: What approved efficacy evidence supports Neravilimab in NOVA-220?

tools:
  - tool_spec:
      type: cortex_search
      name: medical_scientific_search
      description: >-
        Retrieves approved synthetic scientific evidence for Medical Affairs, including clinical-study summaries,
        publication abstracts, synthetic product information, approved Medical Information responses, scientific FAQs,
        and Medical Affairs SOPs. This tool is permanently restricted to APPROVED documents.
  - tool_spec:
      type: cortex_analyst_text_to_sql
      name: clinical_evidence_analyst
      description: >-
        Answers quantitative or structured clinical evidence questions involving study design, enrollment,
        treatment arms, patient subgroups, efficacy endpoints, treatment differences, safety-event rates, study phase,
        timing, and evidence status using Medical Affairs terminology.

tool_resources:
  medical_scientific_search:
    name: MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_SCIENTIFIC_SEARCH
    max_results: '10'
    filter:
      '@eq':
        approval_status: APPROVED
    title_column: title
    id_column: document_id
    columns_and_descriptions:
      content:
        description: Full synthetic scientific document text used for evidence retrieval and citation.
        type: string
        searchable: true
        filterable: false
      approval_status:
        description: Governance state of the document. The Agent resource is fixed to APPROVED only.
        type: string
        searchable: false
        filterable: true
      document_type:
        description: Evidence category such as STUDY_SUMMARY, PUBLICATION_ABSTRACT, PRESCRIBING_INFORMATION_DEMO, APPROVED_MEDICAL_RESPONSE, SCIENTIFIC_FAQ, MEDICAL_AFFAIRS_SOP, or EVIDENCE_SUMMARY.
        type: string
        searchable: false
        filterable: true
      study_id:
        description: Synthetic study identifier such as ST-301, ST-302, ST-303, ST-210, or ST-220.
        type: string
        searchable: false
        filterable: true
      product_id:
        description: Synthetic product identifier, for example PRD-001 for Aurelimab or PRD-002 for Neravilimab.
        type: string
        searchable: false
        filterable: true
      indication_id:
        description: Synthetic indication identifier associated with the document.
        type: string
        searchable: false
        filterable: true
      region:
        description: Governance/geographic scope such as US or GLOBAL.
        type: string
        searchable: false
        filterable: true
      citation_label:
        description: Human-readable evidence label suitable for source attribution.
        type: string
        searchable: false
        filterable: false
      source_type:
        description: Synthetic source classification, such as SYNTHETIC_INTERNAL or SYNTHETIC_PUBLICATION.
        type: string
        searchable: false
        filterable: false

  clinical_evidence_analyst:
    semantic_view: MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.CLINICAL_EVIDENCE_SEMANTIC_VIEW
    execution_environment:
      type: warehouse
      warehouse: MEDICAL_AFFAIRS_DEMO_WH
$$;

GRANT USAGE ON AGENT MEDICAL_AFFAIRS_AI.MEDICAL_AFFAIRS.MEDICAL_AFFAIRS_AGENT
  TO ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
