WITH product_profit AS (

    SELECT
        p.productname,
        p.categoryname,

        SUM(s.quantity) AS total_quantity,
        ROUND(SUM(s.salesamount)::numeric, 2) AS total_sales,
        ROUND(SUM((s.unitprice - s.unitcost) * s.quantity)::numeric,2) AS total_profit

    FROM fact_sales s
    JOIN dim_product p ON s.productkey = p.productkey
    JOIN dim_date d ON s.orderdate = d.orderdate
    WHERE d.year BETWEEN 2022 AND 2023
    GROUP BY
        p.productname,
        p.categoryname
)

SELECT *
FROM product_profit
ORDER BY total_profit DESC
LIMIT 50 