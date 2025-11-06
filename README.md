Stack Overflow Analysis - Insighta Assessment
Candidate: Yusuf Songur
 Email: yusufsongur31@gmail.com
 Submission Date: November 7, 2024

Executive Summary
This project analyzes Stack Overflow questions from 2020-2022 to identify which topics have the highest need for answers. Using dimensional modeling techniques, I built a data pipeline that processes 23+ million questions and identifies under-served topics in the developer community.
Key Finding: Python, JavaScript, and Java are the most popular topics but have significant answer gaps, with 171K, 127K, and 75K unanswered questions respectively.

Deliverables
1. dbt Project Repository
GitHub Repository: https://github.com/moyeras/stackoverflow-dbt-project
The repository contains:
Staging models for data cleaning
Dimensional models (star schema)
Fact and mart tables
Data quality tests
Documentation
2. BigQuery Dataset (Public Access)
Project ID: stackoverflow-analysis-477422
Datasets:
stackoverflow_dw_staging - Cleaned source data
stackoverflow_dw_intermediate - Bridge tables
stackoverflow_dw_marts - Final dimensional model
All datasets have been shared publicly with allAuthenticatedUsers as BigQuery Data Viewer.
3. Data Model Diagram

See attached star schema diagram with detailed explanations of:
Join keys and relationships
Hierarchies and dimensions
Conformed dimensions
Fact table types
Data Model Explanation
1. Join Keys
dim_tag.tag_id joins to fact_question_metrics.tag_id
dim_date.date_day joins to fact_question_metrics.created_date
int_question_tags bridges questions to multiple tags (many-to-many relationship)
2. Hierarchies & Dimensions
Time Hierarchy: date_day → week → month → quarter → year
Tag Dimension: Simple dimension with tag_id and tag_name attributes
Date Dimension Attributes: month_name, day_name, is_weekend for flexible filtering
3. Conformed Dimensions
dim_date: Conformed dimension that can be reused across multiple fact tables
dim_tag: Conformed dimension for consistent tag definitions across analyses
Both dimensions maintain referential integrity and consistent grain
4. Fact Table Types
fact_question_metrics: PERIODIC SNAPSHOT fact table - Daily snapshots of question metrics aggregated by tag
Grain: One row per tag per day
Measures: Semi-additive (counts, averages) and fully additive (totals)
int_question_tags: BRIDGE/HELPER fact table - Resolves many-to-many relationship between questions and tags
mart_topic_answer_needs: Aggregated mart - Summary table for dashboard consumption (derived from fact table)
5. Design Decisions
Denormalization: tag_name included in fact table for query performance (avoiding joins for common use case)
Date Range: Limited to 2020-2022 for performance and relevance
Minimum Threshold: Mart filters tags with <100 questions to focus on significant topics
Answer Need Score: Composite metric combining absolute unanswered count with rate for prioritization
4. Looker Studio Dashboard
Public Dashboard URL: https://lookerstudio.google.com/reporting/1c4ad81e-1d90-40e9-aa53-55b258f3983f
The dashboard visualizes topics with the highest need for answers through:
Ranked table of top 20 topics by answer need score
Bar chart showing absolute unanswered question counts
Scatter plot showing relationship between topic activity and answer rates

Technical Implementation
Data Architecture
Source Data:
bigquery-public-data.stackoverflow (public dataset)
Filtered to 2020-2022 for relevance and performance
~23 million questions analyzed
Star Schema Design:
Fact Table:
fact_question_metrics - Periodic snapshot fact table with daily question metrics by tag
Grain: One row per tag per day
Contains metrics: total questions, unanswered questions, answer rates, engagement metrics
Dimension Tables:
dim_date - Conformed time dimension with date hierarchies (day → week → month → quarter → year)
dim_tag - Topic/tag dimension with unique identifiers
Bridge Table:
int_question_tags - Resolves many-to-many relationship between questions and tags
Analytical Mart:
mart_topic_answer_needs - Pre-aggregated summary for dashboard consumption
Key Design Decisions
Date Range (2020-2022): Limited scope for performance while maintaining analytical relevance
Minimum Threshold: Filtered topics with <100 questions to focus on statistically significant tags
Answer Need Score: Composite metric combining absolute unanswered count with answer rate percentage for holistic prioritization
Denormalization: Included tag_name in fact table to optimize query performance
Bridge Table: Implemented to handle one question having multiple tags
Data Quality
Implemented dbt tests for:
Uniqueness constraints on primary keys
Not-null constraints on critical fields
Referential integrity between facts and dimensions
All tests passed successfully.

Key Findings
Topics with Highest Answer Need:
Python - 750,502 total questions, 171,574 unanswered (77% answer rate)
JavaScript - 541,108 total questions, 127,607 unanswered (76% answer rate)
Java - 277,597 total questions, 75,928 unanswered (73% answer rate)
Insights:
Even the most popular programming topics have 23-27% of questions remaining unanswered
This represents a significant opportunity for community engagement and expert contribution
The answer need score successfully identifies topics that combine high volume with low answer rates

Tools & Technologies Used
Google BigQuery - Data warehouse and query engine
dbt (Data Build Tool) - Transformation and modeling
Looker Studio - Data visualization
GitHub - Version control
SQL - Data transformation language

Assumptions & Limitations
Assumptions:
Questions with answer_count = 0 are considered "unanswered"
Tags are the primary dimension for "topics"
2020-2022 data is representative of current patterns
Limitations:
Does not analyze answer quality (only count and acceptance)
Limited to tags with 100+ questions
Does not include temporal analysis of answer time gaps
Bridge table implementation could be optimized for very large scale

Future Enhancements
If given more time, I would:
Add time-to-answer metrics to identify which topics have the longest wait times
Implement answer quality scoring based on votes and acceptance rates
Add user dimension to analyze contributor patterns
Create slowly changing dimension (SCD) for tracking tag popularity over time
Build incremental models for production scalability
Add more granular tests and data lineage documentation

Conclusion
This project demonstrates end-to-end data engineering capabilities including:
Dimensional modeling and star schema design
Production-quality dbt development practices
Data quality assurance through testing
Clear visualization and storytelling with data
The analysis successfully answers the question "which topics have the highest need for answers?" and provides actionable insights for Stack Overflow community management.

Contact Information:
 Yusuf Songur
 yusufsongur31@gmail.com

