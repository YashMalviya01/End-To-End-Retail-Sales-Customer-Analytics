
WITH store_sales AS(
    SELECT
        st.countryname,
        st.state,
        st.store_size,
        st.status,
        COUNT(DISTINCT s.orderkey) AS total_orders,
        ROUND(SUM(s.salesamount)::numeric,2) AS total_revenue,
        ROUND(AVG(s.salesamount)::numeric,2) AS avg_order_value
    FROM 
        fact_sales s
    JOIN dim_store as st ON s.storekey = st.storekey
    JOIN dim_date d ON s.orderdate = d.orderdate
    WHERE d.year BETWEEN 2022 AND 2023

    GROUP BY  
        st.countryname,
        st.state,
        st.store_size,
        st.status       
) 

SELECT*
FROM 
    store_sales
ORDER BY total_revenue DESC    