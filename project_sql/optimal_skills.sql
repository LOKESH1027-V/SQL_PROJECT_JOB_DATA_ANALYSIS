WITH top_paying_skills AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim 
            ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim 
            ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        salary_year_avg IS NOT NULL
        AND job_title_short = 'Data Analyst'
        AND job_postings_fact.job_work_from_home = 'True'
    GROUP BY
        skills_dim.skill_id
),
remote_job_skills AS (
    SELECT 
        skills_job_dim.skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
        INNER JOIN job_postings_fact 
            ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_postings_fact.job_work_from_home = 'True'
        AND job_postings_fact.job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id 
)

SELECT
    top_paying_skills.skill_id,
    top_paying_skills.skills,
    top_paying_skills.average_salary,
    remote_job_skills.skill_count
FROM top_paying_skills  
INNER JOIN remote_job_skills 
    ON top_paying_skills.skill_id = remote_job_skills.skill_id
WHERE
    remote_job_skills.skill_count > 10
ORDER BY
    top_paying_skills.average_salary DESC,
    remote_job_skills.skill_count DESC
LIMIT 10

;