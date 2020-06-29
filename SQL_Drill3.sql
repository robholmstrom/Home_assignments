--SQL Drill 3

--2
SELECT p.namelast, p.namefirst, hf.inducted
FROM people AS p LEFT OUTER JOIN hof_inducted AS hf
ON p.playerid = hf.playerid
ORDER BY inducted NULLS LAST, namelast ASC

--3
SELECT p.namelast, p.namefirst, p.birthyear, p.deathyear, p.birthcountry
FROM people AS p LEFT OUTER JOIN hof_inducted as hf
ON p.playerid = hf.playerid 
WHERE votedby = 'Negro League'

--4
SELECT s.yearid, s.playerid, s.teamid, s.salary, hf.category
FROM salaries AS s INNER JOIN hof_inducted AS hf
ON s.playerid = hf.playerid

--5
SELECT s.playerid, s.yearid, s.teamid, s.lgid, s.salary, hf.inducted
FROM salaries AS s FULL OUTER JOIN hof_inducted AS hf
ON s.playerid = hf.playerid

--6.1
SELECT *
FROM hof_inducted
UNION
SELECT *
FROM hof_not_inducted

--6.2

SELECT DISTINCT playerid
FROM hof_inducted
UNION
SELECT DISTINCT playerid
FROM hof_not_inducted
WHERE inducted = 'Y'

--7
SELECT p.namelast, p.namefirst, SUM(salary) AS total_salary
FROM people as p LEFT OUTER JOIN salaries as s
ON p.playerid = s.playerid
GROUP BY p.namelast, p.namefirst

--8
SELECT hf.playerid, hf.yearid, p.namefirst, p.namelast
FROM hof_inducted AS hf LEFT OUTER JOIN people AS p
ON p.playerid = hf.playerid
UNION
SELECT nhf.playerid, nhf.yearid, p.namefirst, p.namelast
FROM hof_not_inducted AS nhf LEFT OUTER JOIN people AS p
ON p.playerid = nhf.playerid

--9
SELECT hf.yearid, hf.inducted, CONCAT(p.namefirst, ', ',p.namelast) AS fullname
FROM hof_inducted AS hf LEFT OUTER JOIN people AS p
ON p.playerid = hf.playerid
UNION
SELECT nhf.yearid, nhf.inducted, CONCAT(p.namefirst, ', ',p.namelast) AS fullname
FROM hof_not_inducted AS nhf LEFT OUTER JOIN people AS p
ON p.playerid = nhf.playerid
WHERE yearid >= 1980 
ORDER BY yearid, inducted DESC, fullname

--10
WITH max AS
(SELECT MAX(salary) as max_salary, teamid, yearid
FROM salaries
GROUP BY teamid, yearid)
SELECT salaries.yearid, salaries.teamid, playerid, max.max_salary
FROM max LEFT OUTER JOIN salaries
ON salaries.teamid = max.teamid AND salaries.yearid = max.yearid AND salaries.salary = max.max_salary
ORDER BY max.max_salary DESC;

--11
SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear > ALL (SELECT birthyear
	FROM people
	WHERE playerid = 'ruthba01')

--12
SELECT namefirst, namelast,
	CASE
		WHEN birthcountry = 'USA' THEN 'USA'
		ELSE 'non-USA'
	END	as usaborn
FROM people
ORDER BY usaborn

--13
WITH LT AS (
SELECT height as L, playerid
FROM people 
WHERE throws = 'L' AND height IS NOT NULL
),
RT AS (
SELECT height as R, playerid
FROM people 
WHERE throws = 'R' AND height IS NOT NULL
)
SELECT ROUND(AVG(RT.R),0) AS avg_R, ROUND(AVG(LT.L),0) AS avg_L
FROM RT FULL OUTER JOIN LT
ON RT.playerid = LT.playerid

--14
WITH max AS (
	SELECT teamid, yearid, MAX(salary) AS maxsal
	FROM salaries
	GROUP BY teamid, yearid)
SELECT ROUND(AVG(max.maxsal),0), teamid
FROM max 
WHERE yearid > 2010
GROUP BY teamid