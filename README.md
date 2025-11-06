# 🧠 Stack Overflow Analysis — Insighta Assessment

**Candidate:** Yusuf Songur  
**Email:** [yusufsongur31@gmail.com](mailto:yusufsongur31@gmail.com)  
**Submission Date:** November 7, 2024  

---

## 📘 Executive Summary

This project analyzes Stack Overflow questions from **2020–2022** to identify which **developer topics have the highest need for answers**.  
Using **dimensional modeling** and **modern data engineering practices**, a full data pipeline was built to process over **23 million questions**, highlighting under-served areas in the developer community.

**Key Finding:**  
> Python, JavaScript, and Java are the most popular topics, yet have significant answer gaps —  
> **171K**, **127K**, and **75K** unanswered questions respectively.

---

## 🚀 Deliverables

### 1. [dbt Project Repository](https://github.com/moyeras/stackoverflow-dbt-project)
Includes:
- Staging models for raw data cleaning  
- Dimensional models (star schema)  
- Fact and mart tables  
- Data quality tests  
- Comprehensive documentation  

---

### 2. BigQuery Dataset (Public Access)
**Project ID:** `stackoverflow-analysis-477422`

**Datasets:**
| Dataset | Description |
|----------|--------------|
| `stackoverflow_dw_staging` | Cleaned source data |
| `stackoverflow_dw_intermediate` | Bridge tables |
| `stackoverflow_dw_marts` | Final dimensional model |

> All datasets are shared publicly with `allAuthenticatedUsers` as **BigQuery Data Viewer**.

---

### 3. Data Model Diagram

<img width="944" height="860" alt="star schema" src="https://github.com/user-attachments/assets/aed6a7d6-d697-4896-bf41-72904c447194" />

The star schema includes:

- **Join Keys**
  - `dim_tag.tag_id` → `fact_question_metrics.tag_id`  
  - `dim_date.date_day` → `fact_question_metrics.created_date`  
  - `int_question_tags` bridges questions to tags (many-to-many)

- **Hierarchies & Dimensions**
  - **Time Hierarchy:** day → week → month → quarter → year  
  - **Tag Dimension:** simple `tag_id`, `tag_name` attributes  
  - **Date Attributes:** `month_name`, `day_name`, `is_weekend`  

- **Conformed Dimensions**
  - `dim_date` and `dim_tag` are reusable across multiple facts  
  - Referential integrity and consistent grain maintained

- **Fact Table Types**
  - `fact_question_metrics`: **Periodic Snapshot** fact table (daily metrics by tag)  
  - `int_question_tags`: **Bridge/Helper** fact table (many-to-many link)  
  - `mart_topic_answer_needs`: Aggregated summary for dashboards  

- **Design Highlights**
  - Denormalized `tag_name` for faster querying  
  - Filtered tags with <100 questions for relevance  
  - Custom **Answer Need Score** combining unanswered count and rate

---

### 4. [Looker Studio Dashboard](https://lookerstudio.google.com/reporting/1c4ad81e-1d90-40e9-aa53-55b258f3983f)

Interactive visualization of the findings:
- 📊 Top 20 topics ranked by *Answer Need Score*  
- 📈 Bar chart of unanswered question counts  
- ⚙️ Scatter plot showing activity vs. answer rate  

---

## 🏗️ Technical Implementation

### Data Architecture Overview

**Source Data:**  
- `bigquery-public-data.stackoverflow` (filtered to 2020–2022)  
- ~23 million questions processed  

**Schema Design:**
- **Fact:** `fact_question_metrics` (daily metrics by tag)  
- **Dimensions:** `dim_date`, `dim_tag`  
- **Bridge:** `int_question_tags` (questions ↔ tags)  
- **Mart:** `mart_topic_answer_needs` (aggregated summaries)

---

### Key Design Decisions

| Decision | Rationale |
|-----------|------------|
| **Date Range 2020–2022** | Balanced performance and relevance |
| **Minimum 100 Questions per Tag** | Ensures statistical significance |
| **Answer Need Score** | Combines unanswered count + rate |
| **Denormalization** | Faster query performance |
| **Bridge Table** | Handles multiple tags per question |

---

### 🧪 Data Quality

Implemented **dbt tests** for:
- ✅ Uniqueness on primary keys  
- ✅ Not-null constraints on critical fields  
- ✅ Referential integrity across fact/dimension tables  

All tests **passed successfully**.

---

## 📊 Key Findings

| Topic | Total Questions | Unanswered | Answer Rate |
|--------|----------------|-------------|--------------|
| **Python** | 750,502 | 171,574 | 77% |
| **JavaScript** | 541,108 | 127,607 | 76% |
| **Java** | 277,597 | 75,928 | 73% |

**Insights:**
- 23–27% of questions in top languages remain unanswered  
- High opportunity for expert engagement  
- Answer Need Score pinpoints high-volume, low-answer areas

---

## 🧰 Tools & Technologies

| Category | Tools |
|-----------|-------|
| **Data Warehouse** | Google BigQuery |
| **Modeling & Transformation** | dbt |
| **Visualization** | Looker Studio |
| **Version Control** | GitHub |
| **Languages** | SQL |

---

## ⚙️ Assumptions & Limitations

**Assumptions**
- `answer_count = 0` → question considered unanswered  
- Tags represent discussion topics  
- 2020–2022 data is representative of recent activity  

**Limitations**
- No analysis of answer quality or timing  
- Tags with <100 questions excluded  
- No temporal “time-to-answer” analysis  
- Bridge model may need scaling optimization  

---

## 🔮 Future Enhancements

If extended further:
- ⏱️ Add time-to-answer metric  
- ⭐ Score answer quality (votes & acceptance)  
- 👤 Add user dimension for contributor analysis  
- 🧱 Implement SCD for tag popularity over time  
- ⚡ Build incremental models for production use  
- 🧩 Enhance data lineage and testing coverage  

---

## ✅ Conclusion

This project demonstrates end-to-end **data engineering and analytics capabilities** including:
- Robust **dimensional modeling** and **star schema design**  
- Production-grade **dbt transformations and testing**  
- Scalable **BigQuery data warehousing**  
- Insightful **dashboard storytelling** with Looker Studio  

**Business Question Answered:**  
> Which developer topics on Stack Overflow have the highest need for answers?

---

## 📬 Contact

**Yusuf Songur**  
📧 [yusufsongur31@gmail.com](mailto:yusufsongur31@gmail.com)  
🔗 [GitHub Repository](https://github.com/moyeras/stackoverflow-dbt-project)

---
