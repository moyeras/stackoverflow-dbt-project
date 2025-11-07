WITH question_tags AS (
    SELECT * FROM {{ ref('int_question_tags') }}
),

questions AS (
    SELECT * FROM {{ ref('stg_questions') }}
)

SELECT
    qt.tag_id,
    qt.tag_name,
    
    
    COUNT(DISTINCT q.question_id) AS total_questions,
    SUM(CASE WHEN q.is_unanswered THEN 1 ELSE 0 END) AS unanswered_questions,
    SUM(CASE WHEN q.has_accepted_answer THEN 1 ELSE 0 END) AS questions_with_accepted_answer,
    SUM(q.answer_count) AS total_answers,
    
  
    AVG(q.answer_count) AS avg_answers_per_question,
    AVG(q.view_count) AS avg_views,
    AVG(q.score) AS avg_question_score,
    
   
    SAFE_DIVIDE(
        COUNT(DISTINCT q.question_id) - SUM(CASE WHEN q.is_unanswered THEN 1 ELSE 0 END),
        COUNT(DISTINCT q.question_id)
    ) * 100 AS answer_rate_pct,
    
  
    SAFE_DIVIDE(
        SUM(CASE WHEN q.has_accepted_answer THEN 1 ELSE 0 END),
        COUNT(DISTINCT q.question_id)
    ) * 100 AS accepted_answer_rate_pct,
    
   
    SUM(CASE WHEN q.is_unanswered THEN 1 ELSE 0 END) + 
    (SAFE_DIVIDE(
        SUM(CASE WHEN q.is_unanswered THEN 1 ELSE 0 END), 
        COUNT(DISTINCT q.question_id)
    ) * 1000) AS answer_need_score

FROM questions q
INNER JOIN question_tags qt ON q.question_id = qt.question_id
GROUP BY qt.tag_id, qt.tag_name
HAVING COUNT(DISTINCT q.question_id) >= 100  
ORDER BY answer_need_score DESC

