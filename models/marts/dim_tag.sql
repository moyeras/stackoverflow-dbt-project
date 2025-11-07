SELECT
    ROW_NUMBER() OVER (ORDER BY tag_name) AS tag_id,
    tag_name
FROM {{ ref('stg_tags') }}
ORDER BY tag_name

