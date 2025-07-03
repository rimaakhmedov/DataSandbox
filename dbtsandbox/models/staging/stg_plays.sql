{{ config(materialized='view') }}

SELECT
    id AS play_id,
    user_id,
    track_id,
    played_at AT TIME ZONE 'UTC' AS played_at,
    lower(trim(device)) AS device
FROM {{ source('raw', 'plays') }}
