-- Staging model: Extract individual tags from questions
WITH source AS (
    SELECT *
    FROM {{ ref('stg_questions') }}
)

SELECT DISTINCT
    tag AS tag_name
FROM source,
UNNEST(SPLIT(tags, '|')) AS tag
WHERE tag IS NOT NULL 
  AND tag != ''