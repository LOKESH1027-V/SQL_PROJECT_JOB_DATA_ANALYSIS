WITH remote_job_skills AS(
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim
        INNER JOIN
        job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_postings_fact.job_work_from_home='True'
        AND
        job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY
        skills_job_dim.skill_id
)

SELECT skills,
       skill_count
FROM remote_job_skills 
     INNER JOIN
     skills_dim ON remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;    
   
