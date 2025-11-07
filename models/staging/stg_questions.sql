WITH source AS (
    SELECT *
    FROM `bigquery-public-data.stackoverflow.posts_questions`
    WHERE creation_date >= '2020-01-01'  
      AND creation_date < '2023-01-01'   
)

SELECT
    id AS question_id,
    title,
    body,
    tags,
    owner_user_id,
    owner_display_name,
    creation_date,
    last_activity_date,
    answer_count,
    comment_count,
    favorite_count,
    score,
    view_count,
    accepted_answer_id,
    
    
    CASE 
        WHEN answer_count = 0 THEN TRUE 
        ELSE FALSE 
    END AS is_unanswered,
    
    CASE 
        WHEN accepted_answer_id IS NOT NULL THEN TRUE 
        ELSE FALSE 
    END AS has_accepted_answer,
    
    DATE(creation_date) AS created_date

FROM source

WHERE tags IS NOT NULL  -- Only questions with tags

