WITH questions AS (
    SELECT * FROM {{ ref('stg_questions') }}
),

question_tags AS (
    SELECT * FROM {{ ref('int_question_tags') }}
),

tag_dim AS (
    SELECT * FROM {{ ref('dim_tag') }}
)

SELECT
    qt.tag_id,
    qt.tag_name,
    DATE(q.creation_date) AS created_date,
    
   
    COUNT(DISTINCT q.question_id) AS total_questions,
    SUM(CASE WHEN q.is_unanswered THEN 1 ELSE 0 END) AS unanswered_questions,
    SUM(CASE WHEN q.has_accepted_answer THEN 1 ELSE 0 END) AS questions_with_accepted_answer,
    
    
    AVG(q.answer_count) AS avg_answers_per_question,
    SUM(q.answer_count) AS total_answers,
    
   
    AVG(q.view_count) AS avg_views,
    AVG(q.score) AS avg_question_score,
    AVG(q.comment_count) AS avg_comments,
    
    
    SAFE_DIVIDE(
        SUM(CASE WHEN NOT q.is_unanswered THEN 1 ELSE 0 END),
        COUNT(DISTINCT q.question_id)
    ) AS answer_rate,
    
    
    SAFE_DIVIDE(
        SUM(CASE WHEN q.has_accepted_answer THEN 1 ELSE 0 END),
        COUNT(DISTINCT q.question_id)
    ) AS accepted_answer_rate

FROM questions q
INNER JOIN question_tags qt ON q.question_id = qt.question_id
GROUP BY 
    qt.tag_id,
    qt.tag_name,

    DATE(q.creation_date)
