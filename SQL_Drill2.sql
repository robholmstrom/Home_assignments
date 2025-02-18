SELECT *
FROM ksprojects
--1
SELECT DISTINCT country
FROM ksprojects

--2
SELECT COUNT(DISTINCT country)
FROM ksprojects

--3
SELECT DISTINCT main_category, category
FROM ksprojects
ORDER BY main_category ASC

--4
SELECT main_category, COUNT (DISTINCT category)
FROM ksprojects

--5
SELECT main_category, ROUND(AVG(backers),0) AS avg
FROM ksprojects
GROUP BY main_category
ORDER BY avg DESC

--6
SELECT category, COUNT(*), ROUND(AVG(pledged-goal)::numeric, 2) AS diff_pledge_vs_goal
FROM ksprojects
WHERE state = 'successful'
GROUP BY category
ORDER BY 3

--7
SELECT  main_category, COUNT(*) AS num_projects_zero_backers, MAX(goal) AS max_goal
FROM ksprojects
WHERE backers = 0
GROUP BY  main_category

--8
SELECT category, ROUND(AVG(NULLIF(backers, 0)),2) AS backer_avg
FROM ksprojects
GROUP BY category
HAVING ROUND(AVG(NULLIF(backers, 0)),2) < 50
ORDER BY backer_avg DESC

--9
SELECT main_category, COUNT(*)
FROM ksprojects
WHERE state = 'successful' AND backers < 10 AND backers > 5
GROUP BY main_category

--10
SELECT currency, SUM(pledged) AS pledged
FROM ksprojects
WHERE state = 'successful'
GROUP BY  currency

--11
SELECT main_category, SUM(backers)
FROM ksprojects
WHERE state = 'successful' 
	AND main_category != 'Games' 
	AND main_category != 'Technology'
GROUP BY main_category
HAVING SUM(backers)>100000
ORDER BY main_category
