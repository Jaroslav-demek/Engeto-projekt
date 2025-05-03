
SELECT 
    country_name, 
    year, 
    ROUND((gdp / population)::numeric, 2) AS gdp_per_capita,
    ROUND(LAG((gdp / population)::numeric) OVER (PARTITION BY country_name ORDER BY year), 2) AS gdp_per_capita_prev_year,
    ROUND(
        ((gdp / population)::numeric / NULLIF(LAG((gdp / population)::numeric) OVER (PARTITION BY country_name ORDER BY year), 0)) * 100 - 100, 
    2) AS gdp_per_capita_growth_pct
FROM t_jaroslav_demek_project_sql_secondary_final
WHERE country_name = 'Czech Republic'
  AND year BETWEEN 2006 AND 2018;






























