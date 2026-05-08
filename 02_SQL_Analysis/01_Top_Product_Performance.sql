
WITH category_sales AS (
    SELECT 
        p.categoryname,
        COUNT(DISTINCT s.orderkey) AS total_orders,
        SUM(s.quantity) AS total_quantity,
        ROUND(SUM(s.salesamount)::numeric,2) AS total_revenue
    FROM 
        fact_sales s
    JOIN dim_product p ON s.productkey = p.productkey
    JOIN dim_date d ON s.orderdate = d.orderdate
    WHERE d.year BETWEEN 2022 AND 2023
    GROUP BY p.categoryname 
)  
SELECT *
FROM category_sales
ORDER BY total_revenue DESC     