WITH sales_channel AS (

    SELECT
        CASE
            WHEN st.countryname = 'Online'
                THEN 'Online'
            ELSE 'Physical Store'
        END AS sales_channel,

        COUNT(DISTINCT s.orderkey) AS total_orders,

        ROUND(
            SUM(s.salesamount)::numeric,
            2
        ) AS total_revenue,

        ROUND(
            AVG(s.salesamount)::numeric,
            2
        ) AS avg_order_value

    FROM fact_sales s

    JOIN dim_store st
        ON s.storekey = st.storekey

    GROUP BY sales_channel
)

SELECT *
FROM sales_channel;