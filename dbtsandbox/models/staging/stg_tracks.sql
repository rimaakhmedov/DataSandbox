{{ config(materialized='view') }}

SELECT
    id AS track_id,
    lower(trim(title)) AS track_title,
    lower(trim(artist)) AS artist_name,
    lower(trim(genre)) AS genre
FROM {{ source('raw', 'tracks') }}
