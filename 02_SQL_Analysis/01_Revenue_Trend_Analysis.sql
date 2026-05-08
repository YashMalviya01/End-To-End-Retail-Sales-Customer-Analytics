-- REVENUE TREND ANALYSIS
WITH monthly_sales AS(

SELECT  
    d.year,
    d.month,
    ROUND(SUM(s.salesamount)::numeric,2) AS total_revenue,
    SUM(s.quantity) AS total_quantity
FROM fact_sales s
LEFT JOIN dim_date d ON s.orderdate = d.orderdate
WHERE d.year BETWEEN 2022 AND 2023
GROUP BY
    d.year,
    d.month
)

SELECT *
FROM monthly_sales
ORDER BY 
    year,
    month