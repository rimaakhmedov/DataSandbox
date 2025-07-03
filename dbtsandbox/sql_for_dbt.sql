CREATE SCHEMA analytics;
CREATE SCHEMA raw;

DROP TABLE IF EXISTS raw.users, raw.tracks, raw.plays, raw.payments;

-- Таблица пользователей
CREATE TABLE raw.users (
    id INT PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP
);

-- Генерация 100 пользователей
INSERT INTO raw.users (id, name, created_at)
SELECT
    g AS id,
    'User_' || g AS name,
    NOW() - (random() * INTERVAL '365 days')
FROM generate_series(1, 100) AS g;

-- Таблица треков
CREATE TABLE raw.tracks (
    id INT PRIMARY KEY,
    title TEXT,
    artist TEXT,
    genre TEXT
);

-- Генерация 50 треков
INSERT INTO raw.tracks (id, title, artist, genre)
SELECT
    g AS id,
    'Track_' || g AS title,
    'Artist_' || (1 + floor(random() * 20))::int AS artist,
    CASE WHEN random() < 0.33 THEN 'Pop'
         WHEN random() < 0.66 THEN 'Rock'
         ELSE 'Jazz'
    END AS genre
FROM generate_series(1, 50) AS g;

-- Таблица истории прослушиваний
CREATE TABLE raw.plays (
    id INT PRIMARY KEY,
    user_id INT REFERENCES raw.users(id),
    track_id INT REFERENCES raw.tracks(id),
    played_at TIMESTAMP,
    device TEXT
);

-- Генерация 5000 записей прослушиваний
INSERT INTO raw.plays (id, user_id, track_id, played_at, device)
SELECT
    g AS id,
    1 + floor(random() * 100)::int AS user_id,
    1 + floor(random() * 50)::int AS track_id,
    NOW() - (random() * INTERVAL '60 days') AS played_at,
    CASE WHEN random() < 0.33 THEN 'mobile'
         WHEN random() < 0.66 THEN 'desktop'
         ELSE 'tablet'
    END AS device
FROM generate_series(1, 5000) AS g;

-- Таблица платежей
CREATE TABLE raw.payments (
    id INT PRIMARY KEY,
    user_id INT REFERENCES raw.users(id),
    amount NUMERIC(10, 2),
    paid_at DATE,
    payment_method TEXT
);

-- Генерация 500 платежей
INSERT INTO raw.payments (id, user_id, amount, paid_at, payment_method)
SELECT
    g AS id,
    1 + floor(random() * 100)::int AS user_id,
    round((5 + random() * 20)::numeric, 2) AS amount,
    (NOW() - (random() * INTERVAL '180 days'))::date AS paid_at,
    CASE WHEN random() < 0.5 THEN 'card' ELSE 'paypal' END AS payment_method
FROM generate_series(1, 500) AS g;