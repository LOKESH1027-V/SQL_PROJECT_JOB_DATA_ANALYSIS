SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS avg_year_salary,
    AVG(salary_hour_avg) AS avg_hour_salary
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023
  AND EXTRACT(MONTH FROM job_posted_date) > 5
GROUP BY job_schedule_type;
select * from job_postings_fact limit 10;

create table january_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table february_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

  create table march_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table april_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 4
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;


create table may_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 5
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table june_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 6
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table july_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 7
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table august_jobs AS
SELECT *  
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 8
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table september_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 9
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table october_jobs AS
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 10
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table november_jobs AS 
SELECT * 
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 11
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

create table december_jobs AS
SELECT *  
From job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 12


SELECT job_title_short,
        job_location,
        case
          when job_location='Anywhere' then 'Remote'
          when job_location='New York, NY' then 'local'
          else 'onsite'
          end as location_type
FROM job_postings_fact;


select company_id,
        job_no_degree_mention
from job_postings_fact
where job_no_degree_mention= true;

select name company_name,company_id
from company_dim
where company_id in (
    select distinct company_id
    from job_postings_fact
    where job_no_degree_mention= true
);


with job_count as (
  select company_id,
         count(*) as total_jobs
         from job_postings_fact
         group by company_id)

select 
company_dim.name as company_name,job_count.total_jobs
from company_dim
 left join job_count on job_count.company_id=company_dim.company_id
 ORDER BY total_jobs DESC;

-- Find the top 5 skillin skill_dim
with skill_level as (select skill_id,
        count(*) as skill_count
from skills_job_dim inner join job_postings_fact
on skills_job_dim.job_id=job_postings_fact.job_id
group by skill_id
)

select skill_level.skill_id,skills_dim.skills, skill_level.skill_count
from skill_level left join skills_dim on skill_level.skill_id=skills_dim.skill_id
 ORDER BY skill_count DESC
LIMIT 5;

select * from(SELECT * From january_jobs
UNION ALL
SELECT * From february_jobs
UNION ALL
SELECT * From march_jobs
UNION ALL
SELECT * From april_jobs) as stquater where stquater.salary_year_avg>75000
ORDER BY salary_year_avg DESC;