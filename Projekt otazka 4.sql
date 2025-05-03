
-----4.Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)-------

WITH price_with_prev AS (
    SELECT
        avg_salary,
        year,
        category_name,
        CAST(avg_price AS DECIMAL(10,4)) AS avg_price,
        LAG(CAST(avg_price AS DECIMAL(10,4))) OVER (
            PARTITION BY category_name
            ORDER BY year
        ) AS price_prev_year,
        LAG(avg_salary) OVER (
            ORDER BY year
        ) AS avg_salary_prev_year
    FROM
        t_jaroslav_demek_project_SQL_primary_final
    WHERE
        industry_branch_name IS NULL
),
calc_changes AS (
    SELECT *,
           ROUND((avg_price / price_prev_year - 1) * 100, 2) AS price_change_percent,
           ROUND((avg_salary / avg_salary_prev_year - 1) * 100, 2) AS salary_change_percent
    FROM price_with_prev
    WHERE price_prev_year IS NOT NULL AND avg_salary_prev_year IS NOT NULL
)
SELECT 
    year,
    ROUND(AVG(price_change_percent), 2) AS avg_price_change_percent,
    ROUND(AVG(salary_change_percent), 2) AS avg_salary_change_percent,
    ROUND(AVG(price_change_percent) - AVG(salary_change_percent), 2) AS price_vs_salary_diff
FROM calc_changes
GROUP BY year
ORDER BY year;



