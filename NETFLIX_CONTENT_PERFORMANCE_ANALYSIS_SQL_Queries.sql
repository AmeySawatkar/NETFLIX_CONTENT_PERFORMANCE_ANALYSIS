-- =====================================================================
-- Project Title : Netflix Content & Performance Analysis
-- Intern Name   : Amey Kishor Sawatkar
-- Company       : SkillinfyTech Solutions Pvt. Ltd.
-- Domain        : Data Analytics
-- Database      : netflix_content_analysis
-- Table         : netflix_content
-- Description   : 50 SQL queries for Netflix content, trend, rating,
--                 popularity, genre, language, country, and performance analysis
-- =====================================================================

USE netflix_content_analysis;

-- =====================================================================
-- 1. BASIC DATASET OVERVIEW
-- =====================================================================

-- 1. Total number of movies in the dataset
SELECT COUNT(*) AS total_movies
FROM netflix_content;

-- 2. Total number of distinct countries represented in the dataset
SELECT COUNT(DISTINCT country) AS distinct_countries
FROM netflix_content;

-- 3. Total number of distinct languages represented in the dataset
SELECT COUNT(DISTINCT language) AS distinct_languages
FROM netflix_content;

-- 4. Earliest and latest release year in the dataset
SELECT MIN(release_year) AS earliest_release_year,
       MAX(release_year) AS latest_release_year
FROM netflix_content;

-- 5. Overall average rating and average vote score across all content
SELECT ROUND(AVG(rating), 2)       AS avg_rating,
       ROUND(AVG(vote_average), 2) AS avg_vote_average
FROM netflix_content;

-- =====================================================================
-- 2. CONTENT TREND ANALYSIS
-- =====================================================================

-- 6. Number of movies released year-wise
SELECT release_year, COUNT(*) AS movie_count
FROM netflix_content
GROUP BY release_year
ORDER BY release_year;

-- 7. Number of titles added to Netflix year-wise (based on date_added)
SELECT YEAR(date_added) AS year_added, COUNT(*) AS titles_added
FROM netflix_content
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added;

-- 8. Top 10 years with the highest number of releases
SELECT release_year, COUNT(*) AS movie_count
FROM netflix_content
GROUP BY release_year
ORDER BY movie_count DESC
LIMIT 10;

-- 9. Distribution of recent content (last 5 years) vs older content
SELECT
    CASE
        WHEN release_year >= (SELECT MAX(release_year) FROM netflix_content) - 5 THEN 'Recent (Last 5 Years)'
        ELSE 'Older Content'
    END AS content_age_group,
    COUNT(*) AS movie_count
FROM netflix_content
GROUP BY content_age_group;

-- 10. Average gap (in years) between release_year and year added to Netflix
SELECT ROUND(AVG(YEAR(date_added) - release_year), 2) AS avg_years_to_add
FROM netflix_content
WHERE date_added IS NOT NULL;

-- =====================================================================
-- 3. COUNTRY-WISE ANALYSIS
-- =====================================================================

-- 11. Top 10 countries by total movie count
SELECT country, COUNT(*) AS movie_count
FROM netflix_content
GROUP BY country
ORDER BY movie_count DESC
LIMIT 10;

-- 12. All movies released from a specific country (example: India)
SELECT title, release_year, rating, popularity
FROM netflix_content
WHERE country = 'India'
ORDER BY release_year DESC;

-- 13. Country-wise average rating (top 10 by average rating)
SELECT country, ROUND(AVG(rating), 2) AS avg_rating
FROM netflix_content
GROUP BY country
ORDER BY avg_rating DESC
LIMIT 10;

-- 14. Country-wise average popularity (top 10 by average popularity)
SELECT country, ROUND(AVG(popularity), 2) AS avg_popularity
FROM netflix_content
GROUP BY country
ORDER BY avg_popularity DESC
LIMIT 10;

-- 15. Country-wise total revenue (top 10 by total revenue generated)
SELECT country, SUM(revenue) AS total_revenue
FROM netflix_content
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 10;

-- 16. Country-wise total budget invested (top 10 by total budget)
SELECT country, SUM(budget) AS total_budget
FROM netflix_content
GROUP BY country
ORDER BY total_budget DESC
LIMIT 10;

-- =====================================================================
-- 4. GENRE ANALYSIS
-- =====================================================================

-- 17. Most common genres by content count
SELECT genres, COUNT(*) AS movie_count
FROM netflix_content
GROUP BY genres
ORDER BY movie_count DESC
LIMIT 10;

-- 18. Average rating by genre (top 10 highest rated genres)
SELECT genres, ROUND(AVG(rating), 2) AS avg_rating
FROM netflix_content
GROUP BY genres
ORDER BY avg_rating DESC
LIMIT 10;

-- 19. Top genres by average popularity
SELECT genres, ROUND(AVG(popularity), 2) AS avg_popularity
FROM netflix_content
GROUP BY genres
ORDER BY avg_popularity DESC
LIMIT 10;

-- 20. Top genres by total vote count
SELECT genres, SUM(vote_count) AS total_votes
FROM netflix_content
GROUP BY genres
ORDER BY total_votes DESC
LIMIT 10;

-- 21. Genre-wise average revenue (top 10 by average revenue)
SELECT genres, ROUND(AVG(revenue), 2) AS avg_revenue
FROM netflix_content
GROUP BY genres
ORDER BY avg_revenue DESC
LIMIT 10;

-- =====================================================================
-- 5. LANGUAGE ANALYSIS
-- =====================================================================

-- 22. Most common languages by content count
SELECT language, COUNT(*) AS movie_count
FROM netflix_content
GROUP BY language
ORDER BY movie_count DESC
LIMIT 10;

-- 23. Average rating and vote_average by language
SELECT language,
       ROUND(AVG(rating), 2)       AS avg_rating,
       ROUND(AVG(vote_average), 2) AS avg_vote_average
FROM netflix_content
GROUP BY language
ORDER BY avg_rating DESC;

-- 24. Top languages by average popularity
SELECT language, ROUND(AVG(popularity), 2) AS avg_popularity
FROM netflix_content
GROUP BY language
ORDER BY avg_popularity DESC
LIMIT 10;

-- 25. Language-wise total revenue generated
SELECT language, SUM(revenue) AS total_revenue
FROM netflix_content
GROUP BY language
ORDER BY total_revenue DESC
LIMIT 10;

-- =====================================================================
-- 6. DIRECTOR / CAST ANALYSIS
-- =====================================================================

-- 26. Directors with the most movies on the platform
SELECT director, COUNT(*) AS movie_count
FROM netflix_content
WHERE director IS NOT NULL AND director <> ''
GROUP BY director
ORDER BY movie_count DESC
LIMIT 10;

-- 27. Highest rated directors (minimum 3 movies) by average rating
SELECT director, ROUND(AVG(rating), 2) AS avg_rating, COUNT(*) AS movie_count
FROM netflix_content
WHERE director IS NOT NULL AND director <> ''
GROUP BY director
HAVING COUNT(*) >= 3
ORDER BY avg_rating DESC
LIMIT 10;

-- 28. Most frequently appearing cast members
SELECT cast, COUNT(*) AS appearance_count
FROM netflix_content
WHERE cast IS NOT NULL AND cast <> ''
GROUP BY cast
ORDER BY appearance_count DESC
LIMIT 10;

-- 29. Top directors by average popularity
SELECT director, ROUND(AVG(popularity), 2) AS avg_popularity
FROM netflix_content
WHERE director IS NOT NULL AND director <> ''
GROUP BY director
ORDER BY avg_popularity DESC
LIMIT 10;

-- 30. Top directors by average revenue generated
SELECT director, ROUND(AVG(revenue), 2) AS avg_revenue
FROM netflix_content
WHERE director IS NOT NULL AND director <> ''
GROUP BY director
ORDER BY avg_revenue DESC
LIMIT 10;

-- =====================================================================
-- 7. RATING / POPULARITY / VOTE ANALYSIS
-- =====================================================================

-- 31. Top 10 highest rated movies
SELECT title, rating, release_year, country
FROM netflix_content
ORDER BY rating DESC
LIMIT 10;

-- 32. Top 10 most popular movies
SELECT title, popularity, release_year, country
FROM netflix_content
ORDER BY popularity DESC
LIMIT 10;

-- 33. Top 10 movies by vote count
SELECT title, vote_count, vote_average, release_year
FROM netflix_content
ORDER BY vote_count DESC
LIMIT 10;

-- 34. Average popularity by release year
SELECT release_year, ROUND(AVG(popularity), 2) AS avg_popularity
FROM netflix_content
GROUP BY release_year
ORDER BY release_year;

-- 35. Average vote_average by release year
SELECT release_year, ROUND(AVG(vote_average), 2) AS avg_vote_average
FROM netflix_content
GROUP BY release_year
ORDER BY release_year;

-- 36. Top 10 movies with the highest vote_average and a minimum vote_count threshold
SELECT title, vote_average, vote_count, release_year
FROM netflix_content
WHERE vote_count >= 100
ORDER BY vote_average DESC
LIMIT 10;

-- =====================================================================
-- 8. BUDGET / REVENUE PERFORMANCE ANALYSIS
-- =====================================================================

-- 37. Top 10 movies by revenue
SELECT title, revenue, release_year, country
FROM netflix_content
ORDER BY revenue DESC
LIMIT 10;

-- 38. Top 10 movies by budget
SELECT title, budget, release_year, country
FROM netflix_content
ORDER BY budget DESC
LIMIT 10;

-- 39. Average budget by release year
SELECT release_year, ROUND(AVG(budget), 2) AS avg_budget
FROM netflix_content
GROUP BY release_year
ORDER BY release_year;

-- 40. Average revenue by release year
SELECT release_year, ROUND(AVG(revenue), 2) AS avg_revenue
FROM netflix_content
GROUP BY release_year
ORDER BY release_year;

-- 41. Movies with high budget but low rating (potential underperformers)
SELECT title, budget, rating, release_year
FROM netflix_content
WHERE budget > (SELECT AVG(budget) FROM netflix_content)
  AND rating < (SELECT AVG(rating) FROM netflix_content)
ORDER BY budget DESC
LIMIT 10;

-- 42. Movies with high revenue and high popularity (strong overall performers)
SELECT title, revenue, popularity, release_year
FROM netflix_content
WHERE revenue > (SELECT AVG(revenue) FROM netflix_content)
  AND popularity > (SELECT AVG(popularity) FROM netflix_content)
ORDER BY revenue DESC
LIMIT 10;

-- =====================================================================
-- 9. ADVANCED BUSINESS INSIGHT QUERIES
-- =====================================================================

-- 43. Movies with above-average popularity
SELECT title, popularity, release_year
FROM netflix_content
WHERE popularity > (SELECT AVG(popularity) FROM netflix_content)
ORDER BY popularity DESC;

-- 44. Movies with below-average rating but high vote count (polarizing content)
SELECT title, rating, vote_count, release_year
FROM netflix_content
WHERE rating < (SELECT AVG(rating) FROM netflix_content)
  AND vote_count > (SELECT AVG(vote_count) FROM netflix_content)
ORDER BY vote_count DESC
LIMIT 10;

-- 45. Top countries producing high-revenue movies (above-average revenue titles)
SELECT country, COUNT(*) AS high_revenue_movie_count
FROM netflix_content
WHERE revenue > (SELECT AVG(revenue) FROM netflix_content)
GROUP BY country
ORDER BY high_revenue_movie_count DESC
LIMIT 10;

-- 46. Top years for high-performing content (above-average rating and popularity)
SELECT release_year, COUNT(*) AS high_performing_count
FROM netflix_content
WHERE rating > (SELECT AVG(rating) FROM netflix_content)
  AND popularity > (SELECT AVG(popularity) FROM netflix_content)
GROUP BY release_year
ORDER BY high_performing_count DESC
LIMIT 10;

-- 47. Most profitable-looking content based on revenue-to-budget ratio
SELECT title, budget, revenue,
       ROUND(revenue / NULLIF(budget, 0), 2) AS revenue_to_budget_ratio
FROM netflix_content
WHERE budget > 0
ORDER BY revenue_to_budget_ratio DESC
LIMIT 10;

-- 48. Content with high vote_average and high revenue (critically and commercially strong)
SELECT title, vote_average, revenue, release_year
FROM netflix_content
WHERE vote_average > (SELECT AVG(vote_average) FROM netflix_content)
  AND revenue > (SELECT AVG(revenue) FROM netflix_content)
ORDER BY vote_average DESC, revenue DESC
LIMIT 10;

-- 49. Content with low popularity but high rating (hidden gems)
SELECT title, popularity, rating, release_year
FROM netflix_content
WHERE popularity < (SELECT AVG(popularity) FROM netflix_content)
  AND rating > (SELECT AVG(rating) FROM netflix_content)
ORDER BY rating DESC
LIMIT 10;

-- 50. Overall content performance summary by rating category
SELECT
    CASE
        WHEN rating >= 8 THEN 'Excellent (8-10)'
        WHEN rating >= 6 THEN 'Good (6-7.9)'
        WHEN rating >= 4 THEN 'Average (4-5.9)'
        ELSE 'Below Average (<4)'
    END AS rating_category,
    COUNT(*)                       AS movie_count,
    ROUND(AVG(popularity), 2)      AS avg_popularity,
    ROUND(AVG(revenue), 2)         AS avg_revenue
FROM netflix_content
GROUP BY rating_category
ORDER BY movie_count DESC;

-- =====================================================================
-- End of SQL Analysis Script
-- =====================================================================