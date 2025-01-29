
--Q1. How many rows are in the data_analyst_jobs table? 
--Answer: 1793 total rows
SELECT *
FROM data_analyst_jobs;

--Q2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
--Answer: ExxonMobil
SELECT *
FROM data_analyst_jobs
LIMIT 10;

--Q3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
--Answer: There are 21 postings in Tennessee. There are 27 postings that are in either Tennessee or Kentucky

SELECT location AS tn_location
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT location AS tn_ky_location
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY')
ORDER BY location;

--Q4. How many postings are in Tennessee have a star rating above 4?
--Answer: 3 postings have a star rating above 4
/* Things to consider: 
Only want to get values that are ABOVE 4
Don't include null values*/

Select 
	location,
	star_rating AS over_four_stars
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating >4;

--Q5. How many postings in the dataset have a review count between 500 and 1000?
--Answer: 70
/* Things to consider
review_count column contains duplicates*/

SELECT DISTINCT review_count AS reviews
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000
ORDER BY reviews;

/* Q6. Show the average star rating for companies in each state. The output should show the state as 'state'
       and the average rating for the state as 'avg_rating'. Which state shows the highest average rating?
       -Things to consider - companies are duplicated; null values in average rating-
Answer: California has the highest average rating*/

--Information with the avg_rating column without the null values
SELECT 
	DISTINCT company,
	location AS state,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE NOT company = '[null]'
GROUP BY company, state
HAVING AVG(star_rating) IS NOT null
ORDER BY avg_rating DESC, state;

/*Information with null values included
SELECT 
	DISTINCT company,
	location AS state,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE NOT company = '[null]'
GROUP BY company, state
ORDER BY avg_rating DESC;*/

/*Information with null values filtered out and filtered on highest scores
SELECT 
	DISTINCT company,
	location AS state,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE NOT company = '[null]'
GROUP BY company, state
HAVING AVG(star_rating) >=5
ORDER BY state;*/



--Q7. Select unique job titles from the data_analyst_jobs table. How many are there?
--Answer: There are 881 unique job titles

SELECT DISTINCT title
FROM data_analyst_jobs;

--Q8. How many unique job titles are there for California companies?
--Answer: There are 336 unique job titles for California companies
SELECT 
	DISTINCT title,
	company,
	location
FROM data_analyst_jobs
WHERE location = 'CA'
ORDER BY title, company;

/*Q9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews
	  across all locations. How many companies are there with more than 5000 reviews across all locations?*/
--Answer: There are 83 companies with more than 5000 reviews 

SELECT 
	DISTINCT company,
	AVG(star_rating) AS avg_rating,
	review_count AS reviews,
	location AS state
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company, review_count, location
ORDER BY reviews DESC, company;

/*Q10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 
  reviews across all locations in the dataset has the highest star rating? What is that rating?*/
--Answer: Kaiser Permanente has the highest star rating.

SELECT 
	DISTINCT company,
	AVG(star_rating) AS avg_rating,
	review_count AS reviews,
	location AS state
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company, review_count, location
ORDER BY avg_rating DESC, review_count DESC, company;

/*Q11. FInd all the job titles that contain either the word 'Analyst' or the word 'Analytics'. What word do these 
       positions have in common?*/
--Answer: The word they have in common is Data

SELECT title 
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%' OR title ILIKE '%Analytics%';

/*Q12. How many different job titles do not contain either the word 'Analyst' or the word 'Analytics'? What word
do these positions have in common?*/
--Answer: Tableau is the word they have in common

SELECT title 
FROM data_analyst_jobs
WHERE 
	title NOT LIKE '%Analyst%' AND
	title NOT LIKE '%analyst%' AND
	title NOT LIKE '%ANALYST%' AND
	title NOT LIKE '%Analytics%' AND
	title NOT LIKE '%analytics%' AND
	title NOT LIKE '%ANALYTICS%'

/* Bonus You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain)
that require SQL and have been posted longer than 3 weeks. 
-Disregard any postings where the domain is NULL
-Order your results so that the domain with the greatest number of 'hard to fill' jobs is at the top
-Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each
 of the top 4?*/
--Answer: Top 3 are: Computers and Electronics, Consulting and Business Services, Consumer Goods and Services
--		  Eight jobs have been open for more than 3 weeks for each of the top 4 industries	
SELECT 
	title AS job_vacancy,
	skill,
	domain AS industry,
	days_since_posting
FROM data_analyst_jobs
WHERE skill = 'SQL' AND days_since_posting >21 AND domain IS NOT null
ORDER BY days_since_posting DESC, domain;

SELECT 
	COUNT(title) AS job_vacancy,
	skill,
	domain AS industry,
	days_since_posting
FROM data_analyst_jobs
WHERE skill = 'SQL' AND days_since_posting >21 AND domain IS NOT null
GROUP BY skill, domain, days_since_posting
ORDER BY days_since_posting DESC;

