------ sloučení tabulek payroll ------------
CREATE TABLE t_jaroslav_demek_payroll AS
SELECT
	cp.payroll_year,
	cpvt.code AS value_type_code,
	cpvt.name AS value_type_name,
	cpib.code AS industry_branch_code,
	cpib.name AS industry_branch_name,
	AVG(cp.value) AS average_value
FROM
	czechia_payroll cp
LEFT JOIN czechia_payroll_value_type cpvt
ON
	cp.value_type_code = cpvt.code
LEFT JOIN czechia_payroll_unit cpu
ON
	cp.unit_code = cpu.code
LEFT JOIN czechia_payroll_calculation cpc
ON
	cp.calculation_code = cpc.code
LEFT JOIN czechia_payroll_industry_branch cpib
ON
	cp.industry_branch_code = cpib.code
WHERE
	cp.value IS NOT NULL
	AND cp.value_type_code = 5958
	AND cp.calculation_code = 200
GROUP BY
	cp.payroll_year,
	cpvt.code,
	cpvt.name,
	cpib.code,
	cpib.name
ORDER BY
	cp.payroll_year,
	cpib.code;

------ sloučení tabulek price ------------

CREATE TABLE t_jaroslav_demek_price AS 
SELECT
	p.category_code,
	c.name AS category_name,
	c.price_unit,
	EXTRACT(YEAR
FROM
	p.date_from) AS YEAR,
	AVG(p.value) AS avg_price
FROM
	czechia_price p
JOIN czechia_price_category c
ON
	p.category_code = c.code
WHERE
	p.region_code IS NULL
GROUP BY
	p.category_code,
	c.name,
	c.price_unit,
	EXTRACT(YEAR
FROM
	p.date_from);

---------- vytvoření tabulky Primary final -------------------¨

CREATE TABLE t_jaroslav_demek_project_SQL_primary_final AS
SELECT
	p.payroll_year,
	p.value_type_name,
	p.industry_branch_name,
	p.average_value AS avg_salary,
	pr.year,
	pr.category_name,
	pr.price_unit,
	pr.avg_price
FROM
	t_jaroslav_demek_payroll p
JOIN 
t_jaroslav_demek_price pr
ON
	p.payroll_year = pr.YEAR;

SELECT *
FROM t_jaroslav_demek_project_SQL_primary_final;











