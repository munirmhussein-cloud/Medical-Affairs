-- Round 7: Materialize Markdown scientific documents into native Snowflake rows.
-- The text file format treats each line as a single field so file order can be reconstructed.

USE ROLE MEDICAL_AFFAIRS_DEMO_ROLE;
USE WAREHOUSE MEDICAL_AFFAIRS_DEMO_WH;
USE DATABASE MEDICAL_AFFAIRS_AI;
USE SCHEMA MEDICAL_AFFAIRS;

CREATE FILE FORMAT IF NOT EXISTS MEDICAL_AFFAIRS_TEXT_LINE_FF
  TYPE = CSV
  FIELD_DELIMITER = NONE
  RECORD_DELIMITER = '\n'
  SKIP_HEADER = 0
  SKIP_BLANK_LINES = FALSE
  TRIM_SPACE = FALSE
  ESCAPE_UNENCLOSED_FIELD = NONE
  EMPTY_FIELD_AS_NULL = FALSE
  COMPRESSION = NONE
  COMMENT = 'Line-oriented plain-text format for synthetic Markdown scientific documents';

TRUNCATE TABLE SCIENTIFIC_DOCUMENT_LINE;
TRUNCATE TABLE SCIENTIFIC_DOCUMENT;

COPY INTO SCIENTIFIC_DOCUMENT_LINE (staged_file_name, file_row_number, line_text)
  FROM (
    SELECT METADATA$FILENAME, METADATA$FILE_ROW_NUMBER, $1
    FROM @SCIENTIFIC_DOCUMENT_STAGE
      (FILE_FORMAT => MEDICAL_AFFAIRS_TEXT_LINE_FF, PATTERN => '.*[.]md')
  )
  FORCE = TRUE;

INSERT INTO SCIENTIFIC_DOCUMENT (
  document_id,
  title,
  document_type,
  therapeutic_area_id,
  product_id,
  indication_id,
  study_id,
  publication_date,
  effective_date,
  expiration_date,
  approval_status,
  region,
  source_type,
  citation_label,
  content,
  synthetic_flag
)
SELECT
  m.document_id,
  m.title,
  m.document_type,
  m.therapeutic_area_id,
  m.product_id,
  m.indication_id,
  m.study_id,
  m.publication_date,
  m.effective_date,
  m.expiration_date,
  m.approval_status,
  m.region,
  m.source_type,
  m.citation_label,
  LISTAGG(COALESCE(l.line_text, ''), '\n') WITHIN GROUP (ORDER BY l.file_row_number) AS content,
  m.synthetic_flag
FROM SCIENTIFIC_DOCUMENT_MANIFEST m
JOIN SCIENTIFIC_DOCUMENT_LINE l
  ON l.staged_file_name = REGEXP_REPLACE(m.file_path, '^data/documents/', '')
GROUP BY
  m.document_id,
  m.title,
  m.document_type,
  m.therapeutic_area_id,
  m.product_id,
  m.indication_id,
  m.study_id,
  m.publication_date,
  m.effective_date,
  m.expiration_date,
  m.approval_status,
  m.region,
  m.source_type,
  m.citation_label,
  m.synthetic_flag;
