WITH date_spine AS (
    SELECT DISTINCT 
        created_date AS date_day
    FROM {{ ref('stg_questions') }}
)

SELECT
    date_day,
    EXTRACT(YEAR FROM date_day) AS year,
    EXTRACT(QUARTER FROM date_day) AS quarter,
    EXTRACT(MONTH FROM date_day) AS month,
    EXTRACT(WEEK FROM date_day) AS week,
    EXTRACT(DAYOFWEEK FROM date_day) AS day_of_week,
    FORMAT_DATE('%B', date_day) AS month_name,
    FORMAT_DATE('%A', date_day) AS day_name,
    
    
    CASE WHEN EXTRACT(DAYOFWEEK FROM date_day) IN (1, 7) THEN TRUE ELSE FALSE END AS is_weekend
    

FROM date_spine
