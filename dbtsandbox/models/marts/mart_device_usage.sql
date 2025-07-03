{{ config(materialized='table') }}

SELECT
    device,
    COUNT(*) AS total_plays,
    COUNT(DISTINCT user_id) AS unique_users
FROM {{ ref('stg_plays') }}
GROUP BY device
ORDER BY total_plays DESC
