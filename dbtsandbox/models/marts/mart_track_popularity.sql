{{ config(materialized='table') }}

WITH track_plays AS (
    SELECT
        track_id,
        COUNT(*) AS total_plays
    FROM {{ ref('stg_plays') }}
    GROUP BY 1
)

SELECT
    t.track_id,
    t.track_title,
    t.artist_name,
    t.genre,
    tp.total_plays
FROM track_plays tp
LEFT JOIN {{ ref('stg_tracks') }} t
    ON tp.track_id = t.track_id
ORDER BY tp.total_plays DESC
