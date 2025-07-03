{{ config(materialized='view') }}

SELECT
    id AS user_id,
    lower(trim(name)) AS user_name,
    created_at::date AS registration_date
FROM {{ source('raw', 'users') }}
