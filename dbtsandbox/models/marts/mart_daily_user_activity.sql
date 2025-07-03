{{ config(materialized='table') }}

WITH plays AS (
    SELECT
        user_id,
        date_trunc('day', played_at) AS play_date,
        COUNT(*) AS total_plays,
        COUNT(DISTINCT track_id) AS unique_tracks
    FROM {{ ref('stg_plays') }}
    GROUP BY 1, 2
)

SELECT
    p.user_id,
    u.user_name,
    p.play_date,
    p.total_plays,
    p.unique_tracks
FROM plays p
LEFT JOIN {{ ref('stg_users') }} u
    ON p.user_id = u.user_id
