-- Select database
USE moviedb;

-- Create Movie table
CREATE TABLE Movie (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    year YEAR,
    rating FLOAT,
    genre VARCHAR(100)
);

-- Create Person table
CREATE TABLE Person (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    role ENUM('Actor', 'Actress', 'Director'),
    birth_year YEAR
);

-- Create MoviePerson table (junction table)
CREATE TABLE MoviePerson (
    movie_id INT,
    person_id INT,
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

-- Insert data into Movie table
INSERT INTO Movie VALUES
(1, 'Inception', 'A mind-bending sci-fi thriller', 2010, 8.8, 'Science Fiction'),
(2, 'The Dark Knight', 'Batman faces the Joker', 2008, 9.0, 'Action'),
(3, 'Interstellar', 'Space exploration drama', 2014, 8.6, 'Science Fiction'),
(4, 'Titanic', 'A love story on a doomed ship', 1997, 7.9, 'Romance'),
(5, 'The Shawshank Redemption', 'A tale of hope in a prison', 1994, 9.3, 'Drama');

-- Insert data into Person table
INSERT INTO Person VALUES
(1, 'Christopher Nolan', 'Director', 1970),
(2, 'Leonardo DiCaprio', 'Actor', 1974),
(3, 'Christian Bale', 'Actor', 1974),
(4, 'Anne Hathaway', 'Actress', 1982),
(5, 'Morgan Freeman', 'Actor', 1937),
(6, 'Kate Winslet', 'Actress', 1975),
(7, 'James Cameron', 'Director', 1954),
(8, 'Tim Robbins', 'Actor', 1958),
(9, 'Matthew McConaughey', 'Actor', 1969);

-- Insert data into MoviePerson table
INSERT INTO MoviePerson VALUES
(1, 1), (1, 2), (1, 4), 
(2, 1), (2, 3), 
(3, 1), (3, 4), (3, 9), 
(4, 6), (4, 7), 
(5, 5), (5, 8);

-- 1. Retrieve all movies released after the year 2000.
SELECT *
FROM Movie
WHERE year > 2000;

-- 2. List all directors from the Person table.
SELECT name
FROM Person
WHERE role = 'Director';

-- 3. Find all movies with a rating greater than 8.0.
SELECT *
FROM Movie
WHERE rating > 8.0;

-- 4. Count the number of movies in the Movie table.
SELECT COUNT(*) AS total_movies
FROM Movie;

-- 5. Find all movies along with the names of their directors.
SELECT m.name AS movie_name,
       p.name AS director_name
FROM Movie m
JOIN MoviePerson mp ON m.id = mp.movie_id
JOIN Person p ON mp.person_id = p.id
WHERE p.role = 'Director';

-- 6. Retrieve the total number of movies each actor or actress has been in.
SELECT p.name AS actor_name,
       COUNT(mp.movie_id) AS movie_count
FROM Person p
JOIN MoviePerson mp ON p.id = mp.person_id
WHERE p.role IN ('Actor', 'Actress')
GROUP BY p.id, p.name
ORDER BY movie_count DESC;

-- 7. List the top 2 highest-rated movies.
SELECT name, rating
FROM Movie
ORDER BY rating DESC
LIMIT 2;

-- 8. Retrieve all actors and actresses born before 1975, along with the movies they acted in.
SELECT p.name AS actor_name,
       p.birth_year,
       m.name AS movie_name
FROM Person p
JOIN MoviePerson mp ON p.id = mp.person_id
JOIN Movie m ON mp.movie_id = m.id
WHERE p.role IN ('Actor', 'Actress')
  AND p.birth_year < 1975
ORDER BY p.name, m.name;

-- 9. Find the average rating of movies grouped by genre.
SELECT genre,
       AVG(rating) AS avg_rating
FROM Movie
GROUP BY genre
ORDER BY avg_rating DESC;

-- 10. List the names of actors/actresses who have acted in movies directed by 'Christopher Nolan'.
SELECT DISTINCT p2.name AS actor_name
FROM Person p1
JOIN MoviePerson mp1 ON p1.id = mp1.person_id
JOIN Movie m ON mp1.movie_id = m.id
JOIN MoviePerson mp2 ON m.id = mp2.movie_id
JOIN Person p2 ON mp2.person_id = p2.id
WHERE p1.role = 'Director'
  AND p1.name = 'Christopher Nolan'
  AND p2.role IN ('Actor', 'Actress');

