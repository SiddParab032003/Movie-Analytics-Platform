CREATE DATABASE MovieAnalytics;

USE MovieAnalytics;

CREATE TABLE cities (
    city_id INT PRIMARY KEY IDENTITY(1,1),
    city_name VARCHAR(50) NOT NULL
);

INSERT INTO cities (city_name)
VALUES
('Mumbai'),
('Pune'),
('Delhi'),
('Bangalore'),
('Hyderabad');

SELECT * FROM cities;

CREATE TABLE movies (
    movie_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(150),
    genre VARCHAR(100),
    language VARCHAR(50),
    release_date DATE,
    rating FLOAT,
    popularity_score FLOAT
);

INSERT INTO movies (title, genre, language, release_date, rating, popularity_score)
VALUES
('Jawan', 'Action', 'Hindi', '2023-09-07', 7.5, 90),
('Pathaan', 'Action', 'Hindi', '2023-01-25', 7.1, 85);

CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    gender VARCHAR(10),
    age INT,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

INSERT INTO users (gender, age, city_id)
VALUES
('Male', 25, 1),
('Female', 30, 2),
('Male', 22, 1);

SELECT * FROM cities;
SELECT * FROM movies;
SELECT * FROM users;

CREATE TABLE theatres (
    theatre_id INT PRIMARY KEY IDENTITY(1,1),
    theatre_name VARCHAR(100),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

INSERT INTO theatres (theatre_name, city_id)
VALUES
('PVR Phoenix Mall', 1),   -- Mumbai
('INOX R-City', 1),
('Cinepolis Seasons Mall', 2), -- Pune
('PVR Saket', 3);          -- Delhi

SELECT * FROM theatres;

CREATE TABLE shows (
    show_id INT PRIMARY KEY IDENTITY(1,1),
    movie_id INT,
    theatre_id INT,
    show_time DATETIME,
    ticket_price INT,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id)
);

INSERT INTO shows (movie_id, theatre_id, show_time, ticket_price)
VALUES
(1, 1, '2025-12-22 18:00:00', 250),
(1, 2, '2025-12-22 21:00:00', 300),
(2, 3, '2025-12-22 19:30:00', 220),
(2, 4, '2025-12-22 20:00:00', 280);

SELECT * FROM shows;

--Mini test

SELECT 
    m.title,
    t.theatre_name,
    c.city_name,
    s.show_time,
    s.ticket_price
FROM shows s
JOIN movies m ON s.movie_id = m.movie_id
JOIN theatres t ON s.theatre_id = t.theatre_id
JOIN cities c ON t.city_id = c.city_id;

--Booking table 

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    show_id INT,
    seats INT,
    booking_time DATETIME DEFAULT GETDATE(),
    total_amount INT,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

INSERT INTO bookings (user_id, show_id, seats, total_amount, status)
VALUES
(1, 1, 2, 500, 'CONFIRMED'),
(2, 2, 3, 900, 'CONFIRMED'),
(3, 3, 1, 220, 'CANCELLED'),
(1, 4, 4, 1120, 'CONFIRMED');


SELECT * FROM bookings;

--first one 

SELECT SUM(total_amount) AS total_revenue
FROM bookings
WHERE status = 'CONFIRMED';

--Bookings per Movie

SELECT 
    m.title,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
JOIN movies m ON s.movie_id = m.movie_id
GROUP BY m.title;

--City-wise Revenue

SELECT 
    c.city_name,
    SUM(b.total_amount) AS revenue
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
JOIN theatres t ON s.theatre_id = t.theatre_id
JOIN cities c ON t.city_id = c.city_id
WHERE b.status = 'CONFIRMED'
GROUP BY c.city_name;

ALTER TABLE movies
ADD 
    imdb_rating FLOAT,
    imdb_votes INT,
    runtime_minutes INT,
    imdb_year INT;

SELECT movie_id, title, YEAR(release_date) 
FROM movies
WHERE imdb_rating IS NULL

ALTER TABLE movies
ADD 
    tmdb_rating FLOAT,
    tmdb_votes INT,
    tmdb_popularity FLOAT;


SELECT title, tmdb_rating, tmdb_votes, tmdb_popularity FROM movies;

INSERT INTO movies (title, genre, language, release_date)
VALUES
('Animal', 'Action', 'Hindi', '2023-12-01'),
('Dunki', 'Drama', 'Hindi', '2023-12-21'),
('Jawan', 'Action', 'Hindi', '2023-09-07'),
('Pathaan', 'Action', 'Hindi', '2023-01-25'),
('KGF Chapter 2', 'Action', 'Kannada', '2022-04-14'),
('RRR', 'Action', 'Telugu', '2022-03-25'),
('Brahmastra Part One Shiva', 'Fantasy', 'Hindi', '2022-09-09'),
('Pushpa The Rise', 'Action', 'Telugu', '2021-12-17'),
('Baahubali The Beginning', 'Epic', 'Telugu', '2015-07-10'),
('Baahubali The Conclusion', 'Epic', 'Telugu', '2017-04-28'),
('3 Idiots', 'Comedy', 'Hindi', '2009-12-25'),
('Chak De India', 'Drama', 'Hindi', '2007-08-10'),
('War', 'Action', 'Hindi', '2019-10-02'),
('Kabir Singh', 'Drama', 'Hindi', '2019-06-21'),
('Sultan', 'Sports', 'Hindi', '2016-07-06');

SELECT title
FROM movies
WHERE tmdb_rating IS NULL;

UPDATE movies
SET tmdb_rating = 8.0,
    tmdb_votes = 15000,
    tmdb_popularity = 80
WHERE title = 'Baahubali The Beginning';

UPDATE movies
SET tmdb_rating = 8.2,
    tmdb_votes = 17000,
    tmdb_popularity = 85
WHERE title = 'Baahubali The Conclusion';

SELECT
    title,
    tmdb_rating,
    tmdb_votes,
    tmdb_popularity
FROM movies;

-- Rating & Revenue

SELECT
    m.title,
    m.tmdb_rating,
    SUM(b.total_amount) AS total_revenue,
    COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN shows s ON m.movie_id = s.movie_id
JOIN bookings b ON s.show_id = b.show_id
WHERE b.status = 'CONFIRMED'
GROUP BY m.title, m.tmdb_rating
ORDER BY total_revenue DESC;

--Bookings 

INSERT INTO shows (movie_id, theatre_id, show_time, ticket_price)
SELECT movie_id, 1, GETDATE(), 250
FROM movies;

INSERT INTO bookings (user_id, show_id, seats, total_amount, status)
SELECT
    (ABS(CHECKSUM(NEWID())) % 3) + 1 AS user_id,
    s.show_id,
    (ABS(CHECKSUM(NEWID())) % 4) + 1 AS seats,
    ((ABS(CHECKSUM(NEWID())) % 4) + 1) * s.ticket_price AS total_amount,
    'CONFIRMED'
FROM shows s
CROSS JOIN (SELECT TOP 50 1 AS n FROM sys.objects) t;

SELECT 
    m.title,
    COUNT(b.booking_id) AS bookings,
    SUM(b.total_amount) AS revenue
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
JOIN movies m ON s.movie_id = m.movie_id
GROUP BY m.title
ORDER BY revenue DESC;

