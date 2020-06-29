--SQL SELF SUFFICENCY EXAM

--1
--Write a query that allows you to inspect the 
--schema of the naep table.
SELECT column_name, data_type 
FROM information_schema.columns
WHERE table_name = 'naep';
--2 
--Write a query that returns the first 50 records 
--of the naep table.
SELECT *
FROM naep
LIMIT 50;

--3 
--Write a query that returns summary statistics for
--avg_math_4_score by state. Make sure to sort the 
--results alphabetically by state name.
SELECT 
	state, 
	COUNT(*) AS number_of_scores,
	MIN(avg_math_4_score) AS minimum_score,
	MAX(avg_math_4_score) AS maximum_score,
	ROUND(AVG(avg_math_4_score),2) AS state_avg_for_math_4_score, state
FROM naep
GROUP BY state
ORDER BY state;

--4
--Write a query that alters the previous query so 
--that it returns only the summary statistics for 
--avg_math_4_score by state with differences in max
--and min values that are greater than 30.
SELECT 
	state, 
	COUNT(*) AS number_of_scores,
	MIN(avg_math_4_score) AS minimum_score,
	MAX(avg_math_4_score) AS maximum_score,
	MAX(avg_math_4_score)-MIN(avg_math_4_score) AS largest_difference,
	ROUND(AVG(avg_math_4_score),2) AS state_avg_for_math_4_score
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score)-MIN(avg_math_4_score) > 30
ORDER BY state;

--5
--Write a query that returns a field called bottom_10_states 
--that lists the states in the bottom 10 for avg_math_4_score in 
--the year 2000
SELECT 
	state, 
	ROUND(avg_math_4_score,2) AS bottom_10_states
FROM naep
WHERE year = 2000
ORDER BY bottom_10_states
LIMIT 10;

--6
--Write a query that calculates the average avg_math_4_score 
--rounded to the nearest 2 decimal places over all states in the 
--year 2000
SELECT ROUND(AVG(avg_math_4_score),2) AS avg_math_4_score_for_2000
FROM naep
WHERE year = 2000



--7
--Write a query that returns a field called 
--below_average_states_y2000 that lists all states with an 
--avg_math_4_score less than the average over all states in the 
--year 2000
WITH average_score_2000 AS
	(SELECT ROUND(AVG(avg_math_4_score),2) AS avg_math_4_score_for_2000
	FROM naep
	WHERE year = 2000--limits calculated average for year 2000
)
--returns average score for all states in 2000

SELECT 
	n.state AS below_average_states_y2000,
	n.avg_math_4_score AS avg_y2000_score
FROM naep AS n, average_score_2000 AS a
WHERE year = 2000 --limits query to states for year 2000
	AND n.avg_math_4_score IS NOT NULL --removes states with null scores 
	AND n.avg_math_4_score < a.avg_math_4_score_for_2000 --limits to states above y2000 average
GROUP BY n.state, n.avg_math_4_score
ORDER BY n.avg_math_4_score;
--CTE to list states with y2000 scores below average for y2000
--I know, I could have just written a subquery in WHERE section...

--8
--Write a query that returns a field called scores_missing_y2000 
--that lists any states with missing values in the 
--avg_math_4_score column of the naep data table for the year 
--2000.
SELECT state AS scores_missing_y2000
FROM naep
WHERE avg_math_4_score IS NULL 
	AND year = 2000;
	
--9
--Write a query that returns for the year 2000 the state, 
--avg_math_4_score, and total_expenditure from the naep table 
--left outer joined with the finance table, using id as the key 
--and ordered by total_expenditure greatest to least. Be sure to 
--round avg_math_4_score to the nearest 2 decimal places, and 
--then filter out NULL avg_math_4_scores in order to see any 
--correlation more clearly

SELECT 
	n.state, 
	ROUND(n.avg_math_4_score, 2) AS avg_y2000_score, 
	f.total_expenditure AS total_expenditure_y2000
FROM naep AS n LEFT OUTER JOIN finance AS f 
ON n.id = f.id
WHERE n.avg_math_4_score IS NOT NULL 
	AND n.year = 2000
ORDER BY f.total_expenditure DESC;
--I am not seeing a correlation. However, expense seems
--to correlate with the state population. Therefore, it
--might seem interesting to correlate scores against
--expense per enrolled student


 






