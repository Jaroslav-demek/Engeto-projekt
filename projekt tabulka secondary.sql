
CREATE TABLE t_jaroslav_demek_project_sql_secondary_final AS
SELECT
	c.country AS country_name,
	c.continent,
	e.year,
	e.gdp,
	e.population
FROM
	countries c
LEFT JOIN 
	economies e 
	ON c.country = e.country
WHERE
	c.continent = 'Europe'
	AND e.year BETWEEN 2006 AND 2018;

