{{ config(materialized='view') }}

SELECT
    id AS payment_id,
    user_id,
    amount::numeric(10,2) AS amount,
    paid_at::date AS payment_date,
    lower(trim(payment_method)) AS payment_method
FROM {{ source('raw', 'payments') }}
