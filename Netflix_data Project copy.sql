
-- Create Table 

DROP TABLE IF EXISTS Netflix_data;
CREATE TABLE Netflix_data
(
  title VARCHAR(250),
  show_type VARCHAR(10),
  genre VARCHAR(100),
  year_release INT,
  rating NUMERIC(2,1),
  votes INT
  )

 SELECT *
 FROM Netflix_data; 

 --- Business Problems
--- 1. Total movies and shows, whats the ratio? 
--- 2. Growth trend of movies and TV shows over time. 
--- 3. Distribution of different genres, most movies/TV shows are from which genre.  
--- 4. Ranking of genres according to the rating and number of votes, which genre is more popular. 
--- 5. Top 5 most popular movies and TV shows


--- 1. Total movies and shows, whats the ratio? 
 
 SELECT show_type, 
        count(*), 
		ROUND((count(*)::numeric/(SELECT count(*) FROM Netflix_data)::numeric) * 100, 2) AS ratio
 FROM Netflix_data
 GROUP BY show_type;

--- 2. Growth trend of movies and TV shows over time. 

 SELECT show_type, year_release, count(*)
 FROM Netflix_data
 GROUP BY 1,2
 ORDER BY 1,2; 

--- 3. Distribution of different genres, most movies/TV shows are from which genre.

 SELECT TRIM(UNNEST(STRING_TO_ARRAY(genre,','))) AS new_genre, COUNT(*)
 FROM Netflix_data
 GROUP BY new_genre
 ORDER BY COUNT(*) DESC; 

--- 4. Ranking of genres according to the rating and number of votes, which genre is more popular. 

SELECT TRIM(UNNEST(STRING_TO_ARRAY(genre,','))) AS new_genre,
       ROUND(AVG(votes),2) AS average_votes,
       ROUND(AVG(rating),2) AS average_rating
 FROM Netflix_data
 GROUP BY new_genre
 ORDER BY 2 DESC NULLS LAST, 3 DESC NULLS LAST;

--- 5. Top 5 most popular movies and TV shows by engagemnet(votes)

(SELECT title, show_type, votes
FROM Netflix_data
WHERE show_type = 'movie'
ORDER BY show_type, votes desc NULLS LAST
LIMIT 5)

UNION ALL

(SELECT title, show_type, votes
FROM Netflix_data
WHERE show_type = 'tv'
ORDER BY show_type, votes desc NULLS LAST
LIMIT 5) 

