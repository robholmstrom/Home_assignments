--0802
--1
WITH avg_model_hwy AS (
	SELECT DISTINCT make, ROUND(AVG(hwy), 0) AS avg_make_mileage
	FROM vehicles
	GROUP BY make
)
SELECT make, avg_make_mileage
FROM avg_model_hwy
WHERE avg_make_mileage >
	(SELECT ROUND(AVG(hwy), 0)
	FROM vehicles)*2

--Challenge
WITH avghwy AS (
	SELECT ROUND(AVG(hwy),0) AS meanhwy
	FROM vehicles	
)
SELECT SUM(POWER((hwy - (SELECT meanhwy FROM avghwy)),2))/COUNT(*)
FROM vehicles


