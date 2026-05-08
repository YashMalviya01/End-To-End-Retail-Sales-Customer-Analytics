WITH customer_revenue AS (

    SELECT
        c.full_name,

        ROUND(
            SUM(s.salesamount)::numeric,
            2
        ) AS total_revenue

    FROM fact_sales s

    JOIN dim_customer c
        ON s.customerkey = c.customerkey

    GROUP BY c.full_name
)

SELECT
    full_name,
    total_revenue,

    DENSE_RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS customer_rank

FROM customer_revenue
LIMIT 50
