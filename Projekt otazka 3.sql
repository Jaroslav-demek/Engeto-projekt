
-------3.Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?--------

WITH data_with_lag AS (
SELECT
	YEAR,
	category_name,
	price_unit,
	avg_price,
	LAG(avg_price) OVER (
PARTITION BY category_name
ORDER BY
	YEAR
) AS avg_prev_year
FROM
	t_jaroslav_demek_project_SQL_primary_final
GROUP BY
	YEAR,
	category_name,
	price_unit,
	avg_price
),
data_with_ratio AS (
SELECT
	YEAR,
	category_name,
	price_unit,
	avg_price,
	avg_prev_year,
	ROUND((avg_price::NUMERIC / NULLIF(avg_prev_year,
	0)::NUMERIC) * 100,
	1) AS ratio_percent
FROM
	data_with_lag
WHERE
	avg_prev_year IS NOT NULL
)
SELECT
	category_name,
	ROUND(AVG(ratio_percent),
	1) AS avg_ratio_percent
FROM
	data_with_ratio
GROUP BY
	category_name
ORDER BY
	avg_ratio_percent;






