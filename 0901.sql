--0901
--1
SELECT c.name, ROUND(AVG(f.length), 2) 
FROM category as c 
INNER JOIN film_category as fc ON c.category_id = fc.category_id 
INNER JOIN film as f ON fc.film_id = f.film_id 
WHERE NOT f.rating = 'G' GROUP BY c.name 
HAVING AVG(f.length) > 120 ORDER BY c.name;
--2
--Return the country name and average rental time for all rentals, --grouped and ordered by customer’s country and only for average rental times under 5 days. 
SELECT co.country, AVG(r.return_date - r.rental_date) AS avg_rental_time 
FROM country as co 
INNER JOIN city as ci ON co.country_id = ci.country_id 
INNER JOIN address as a ON ci.city_id = a.city_id 
INNER JOIN customer as cu ON a.address_id = cu.address_id 
INNER JOIN rental as r ON cu.customer_id = r.customer_id 
GROUP BY co.country 
HAVING AVG(r.return_date-r.rental_date) < '5 day'
ORDER BY co.country;

--3
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE 'D%'
UNION
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE 'D%'
ORDER BY last_name

