WITH questions AS (
    SELECT * FROM {{ ref('stg_questions') }}
),

tags AS (
    SELECT * FROM {{ ref('dim_tag') }}
)

SELECT
    q.question_id,
    t.tag_id,
    t.tag_name
FROM questions q,
UNNEST(SPLIT(q.tags, '|')) AS tag_str
INNER JOIN tags t ON t.tag_name = tag_str

