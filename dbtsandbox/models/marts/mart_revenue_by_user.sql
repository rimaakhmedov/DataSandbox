{{ config(materialized='table') }}

WITH payments AS (
    SELECT
        user_id,
        SUM(amount) AS total_revenue,
        COUNT(*) AS payment_count
    FROM {{ ref('stg_payments') }}
    GROUP BY 1
)

SELECT
    p.user_id,
    u.user_name,
    p.total_revenue,
    p.payment_count
FROM payments p
LEFT JOIN {{ ref('stg_users') }} u
    ON p.user_id = u.user_id
ORDER BY total_revenue DESC
