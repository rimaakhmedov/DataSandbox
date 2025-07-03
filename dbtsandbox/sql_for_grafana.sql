--Ежедневная активность пользователей
SELECT
  play_date AS "time",
  total_plays
FROM analytics.mart_daily_user_activity
ORDER BY played_date

--Популярность треков (топ 10)
SELECT
  track_title AS metric,
  total_plays
FROM analytics.mart_track_popularity
ORDER BY play_count DESC
LIMIT 10

--Использование устройств (распределение по типам)
SELECT
  device,
  total_plays
FROM analytics.mart_device_usage

--Выручка по пользователям (топ 10)
SELECT
  user_id AS metric,
  total_revenue
FROM analytics.mart_revenue_by_user
ORDER BY total_revenue DESC
LIMIT 10
