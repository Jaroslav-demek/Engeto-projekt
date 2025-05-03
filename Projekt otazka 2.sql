-------2.Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední 
srovnatelné období v dostupných datech cen a mezd.----------------

SELECT 
payroll_year,
category_name,
avg_salary,
avg_price,
FLOOR(avg_salary / avg_price) AS salary_to_price_ratio
FROM 
t_jaroslav_demek_project_SQL_primary_final
WHERE 
industry_branch_name IS NULL
AND (
category_name = 'Chléb konzumní kmínový'
OR category_name = 'Mléko polotučné pasterované'
)
AND (
payroll_year = '2006'
OR payroll_year = '2018')
ORDER BY 
payroll_year;




