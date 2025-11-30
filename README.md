

# AWS RDS – MySQL Movie Database Project

This project demonstrates how to deploy and use a **MySQL database on AWS RDS** and run analytical SQL queries on a sample **Movie Database**. The work includes setting up a cloud-hosted database, connecting remotely, creating tables, inserting sample data, and executing multiple SQL queries to extract insights. All query outputs and screenshots are documented in the included PDF report.

## Project Overview

- Created and configured an **AWS RDS MySQL instance** using the Free Tier.
- Connected to the database using the **RDS endpoint** from a local SQL client.
- Implemented a Movie Database consisting of:
  - **Movie**
  - **Person**
  - **MoviePerson** (relationship table)
- Executed SQL queries to explore, analyze, and join datasets.
- Generated a final PDF report with results and screenshots.

## Technologies Used

- **Amazon Web Services (AWS)**
  - RDS – MySQL (Free Tier)
- **Database**
  - MySQL 8.x
- **Tools**
  - MySQL CLI / terminal
  - AWS Management Console

## SQL Queries Implemented

### 1. Movies released after the year 2000
```sql
SELECT * FROM Movie WHERE year > 2000;

2. List all directors

SELECT name FROM Person WHERE role = 'Director';

3. Movies with rating greater than 8.0

SELECT * FROM Movie WHERE rating > 8.0;

4. Total number of movies

SELECT COUNT(*) AS total_movies FROM Movie;

5. Movies and their directors (JOIN)

SELECT m.name AS movie_name, p.name AS director_name
FROM Movie m
JOIN MoviePerson mp ON m.id = mp.movie_id
JOIN Person p ON mp.person_id = p.id
WHERE p.role = 'Director';

6. Actors/Actresses and the number of movies they acted in

SELECT p.name AS actor_name, COUNT(mp.movie_id) AS movie_count
FROM Person p
JOIN MoviePerson mp ON p.id = mp.person_id
WHERE p.role IN ('Actor', 'Actress')
GROUP BY p.id, p.name
ORDER BY movie_count DESC;

7. Top 2 movies by rating

SELECT name, rating FROM Movie ORDER BY rating DESC LIMIT 2;

8. Actors/Actresses born before 1975 and their movies

SELECT p.name AS actor_name, p.birth_year, m.name AS movie_name
FROM Person p
JOIN MoviePerson mp ON p.id = mp.person_id
JOIN Movie m ON mp.movie_id = m.id
WHERE p.role IN ('Actor', 'Actress') AND p.birth_year < 1975
ORDER BY p.name, m.name;

9. Average movie rating by genre

SELECT genre, AVG(rating) AS avg_rating
FROM Movie
GROUP BY genre
ORDER BY avg_rating DESC;

10. Actors/Actresses who have worked with Christopher Nolan

SELECT DISTINCT p2.name AS actor_name
FROM Person p1
JOIN MoviePerson mp1 ON p1.id = mp1.person_id
JOIN Movie m ON mp1.movie_id = m.id
JOIN MoviePerson mp2 ON m.id = mp2.movie_id
JOIN Person p2 ON mp2.person_id = p2.id
WHERE p1.role = 'Director'
  AND p1.name = 'Christopher Nolan'
  AND p2.role IN ('Actor', 'Actress');

How to Run the Project
	1.	Launch an AWS RDS MySQL instance (Free Tier).
	2.	Connect through MySQL CLI using:

mysql -h <rds-endpoint> -u <username> -p


	3.	Create the Movie, Person, and MoviePerson tables.
	4.	Insert sample data into each table.
	5.	Run the SQL queries listed above.
	6.	Compare results with the screenshots in the PDF report.

Learning Outcomes
	•	Hands-on experience with AWS RDS and cloud-managed SQL databases.
	•	Practical understanding of SQL filtering, aggregation, joins, and analytics.
	•	Ability to connect external tools to managed cloud databases.
	•	Improved database documentation and project structuring skills.

⸻

Author: Ashfaaq Feroz Muhammad
ID: 2023EBCS005


