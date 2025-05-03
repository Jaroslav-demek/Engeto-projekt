----- 1.Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?  ---------

WITH salary_with_change AS (
SELECT
	payroll_year,
	industry_branch_name,
	ROUND(AVG(avg_salary),
	2) AS avg_salary,
	LAG(ROUND(AVG(avg_salary),
	2)) OVER (PARTITION BY industry_branch_name
ORDER BY
	payroll_year) AS prev_year_salary,
	CASE
		WHEN ROUND(AVG(avg_salary),
		2) > 
LAG(ROUND(AVG(avg_salary),
		2)) OVER (PARTITION BY industry_branch_name
	ORDER BY
		payroll_year)
THEN 1
		ELSE 0
	END AS increase_salary
FROM
	t_jaroslav_demek_project_SQL_primary_final
GROUP BY
	payroll_year,
	industry_branch_name
)
SELECT
	*
FROM
	salary_with_change
WHERE
	prev_year_salary IS NOT NULL
	AND increase_salary = 0
ORDER BY
	industry_branch_name,
	payroll_year;







