USE sakila;

show tables;

-- 1a.--
SELECT first_name, last_name
FROM actor;

-- 1b. --
SELECT CONCAT_WS(" ", upper(first_name), upper(last_name)) AS "Actor Name" 
FROM actor;

-- 2a. --
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name like "Joe";

-- 2b. --
SELECT last_name
FROM actor
WHERE last_name like "%gen";

-- 2c. --
SELECT  actor_id, last_name, first_name
FROM actor
WHERE last_name like "%li%"
ORDER BY last_name, first_name;

-- 2d. --
SELECT country, country_id
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3a --
ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_name;

-- 3b --
ALTER TABLE actor
DROP COLUMN description;

-- 4a --
SELECT last_name, COUNT(*) 
FROM actor 
GROUP BY last_name;

-- 4b --
SELECT last_name, COUNT(*) as "Total_Count"
FROM actor 
GROUP BY last_name
HAVING Total_Count > 2;

-- 4c --
UPDATE actor 
SET first_name= "HARPO"
WHERE first_name="GROUCHO" AND last_name="WILLIAMS";

-- 4d --
UPDATE actor 
SET first_name= "GROUCHO"
WHERE first_name="HARPO" AND last_name="WILLIAMS";

-- 5a --
SHOW CREATE TABLE address;

-- 6a --
SELECT s.first_name, s.last_name, a.address
FROM staff s  
LEFT JOIN address a ON s.address_id = a.address_id;

-- 6b --
SELECT s.first_name, s.last_name, min(p.payment_date), max(p.payment_date), SUM(p.amount) AS "Total Amount"
FROM staff s 
LEFT JOIN payment p ON s.staff_id = p.staff_id
WHERE DATE(payment_date) BETWEEN "2005-08-01" AND "2005-08-31"
AND TIME(payment_date) BETWEEN "00:00:00" AND "24:00:00"
GROUP BY first_name, last_name;

-- 6c --
SELECT title, count(actor_id) AS "Total Number of Actors"
FROM film f
INNER JOIN film_actor a ON f.film_id = a.film_id
GROUP BY title;

-- 6d --
SELECT title, count(inventory_id) AS "Total Number of Actors"
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";

-- 6e --
SELECT first_name, last_name, SUM(amount) AS "Total Payment Amount"
FROM customer c 
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY p.customer_id
ORDER BY last_name ASC;

-- 7a --
USE Sakila;

SELECT title 
FROM film
WHERE language_id in
	(SELECT language_id 
	FROM language
	WHERE name = "English" )
AND (title LIKE "K%") OR (title LIKE "Q%");

-- 7b --         
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
   SELECT film_id
   FROM film
   WHERE title = "Alone Trip"
  )
);

-- 7c --
SELECT first_name, last_name, email, country 
FROM customer cu
JOIN address a ON (cu.address_id = a.address_id)
JOIN city ci ON (a.city_id=ci.city_id)
JOIN country cn ON (ci.country_id=cn.country_id)
WHERE country = "Canada";

-- 7d --
SELECT f.title, c.name
from film f
JOIN film_category fcat on (f.film_id=fcat.film_id)
JOIN category c on (fcat.category_id=c.category_id)
where name = "Family";
   
-- 7e --
SELECT title, COUNT(f.film_id) AS "Count_of_Rented_Movies"
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC;

-- 7f --
SELECT store.store_id, SUM(amount)
FROM store 
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment p 
ON p.staff_id = staff.staff_id
GROUP BY store.store_id;

-- 7g --
SELECT store_id, city, country
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id;

-- 7h --
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN inventory i ON fc.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name 
ORDER BY Gross DESC LIMIT 5;

-- 8a --
USE sakila;

CREATE VIEW Top_Five_Genres AS

SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN inventory i ON fc.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name 
ORDER BY Gross DESC LIMIT 5;

-- 8b --
SELECT * 
FROM Top_Five_Genres;

-- 8c --
DROP VIEW Top_Five_Genres;









































