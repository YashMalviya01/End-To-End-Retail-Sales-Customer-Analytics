WITH first_purchase AS (

    SELECT
        s.customerkey,
        MIN( DATE_TRUNC('month', s.orderdate)) AS cohort_month
    FROM fact_sales s
    JOIN dim_date d ON s.orderdate = d.orderdate
    WHERE d.year BETWEEN 2022 AND 2023
    GROUP BY s.customerkey
),

customer_activity AS (

    SELECT
        s.customerkey,

        DATE_TRUNC(
            'month',
            s.orderdate
        ) AS activity_month,

        fp.cohort_month

    FROM fact_sales s

    JOIN first_purchase fp
        ON s.customerkey = fp.customerkey
),

cohort_data AS (

    SELECT
        cohort_month,
        activity_month,

        EXTRACT(
            MONTH FROM AGE(activity_month, cohort_month)) AS cohort_index,

        COUNT(DISTINCT customerkey) AS active_customers

    FROM customer_activity

    GROUP BY
        cohort_month,
        activity_month
)

SELECT
    TO_CHAR(cohort_month, 'YYYY-MM') AS cohort_month,

    TO_CHAR(activity_month, 'YYYY-MM') AS activity_month,

    cohort_index,

    active_customers

FROM cohort_data

ORDER BY
    cohort_month,
    cohort_index;