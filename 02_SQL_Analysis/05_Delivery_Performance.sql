WITH delivery_metrics AS (

    SELECT
        st.countryname,
        COUNT(orderkey) AS total_orders,
        ROUND(AVG(delivery_days)::numeric,2) AS avg_delivery_days,
        ROUND(MAX(delivery_days)::numeric,2) AS max_delivery_days

    FROM fact_sales s
    JOIN dim_store st ON s.storekey = st.storekey
    JOIN dim_date d ON s.orderdate = d.orderdate
    WHERE d.year BETWEEN 2022 AND 2023
    GROUP BY st.countryname
)

SELECT *
FROM delivery_metrics
ORDER BY avg_delivery_days;