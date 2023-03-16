--Question 1 List all customers who live in Texas (use JOINs)

SELECT c.first_name,c.last_name,a.district
FROM customer c
INNER JOIN address a 
ON c.address_id = a.address_id
WHERE district = 'Texas';


-- Question 2 List all payments of more than $7.00 with the customer’s first and last name

SELECT c.first_name, c.last_name, p.amount
FROM customer c
INNER JOIN payment p 
ON c.customer_id = p.customer_id
WHERE amount > 7.00;


-- Question 3 Show all customer names who have made over $175 in payments (use subqueries)

SELECT first_name, last_name
FROM customer 
WHERE customer_id IN(
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

-- Question 4 List all customers that live in Argentina (use the city table)

SELECT c.first_name, c.last_name, a.district, ci.city, co.country
FROM customer c
FULL JOIN address a 
ON c.address_id = a.address_id 
FULL JOIN city ci
ON a.city_id = ci.city_id
FULL JOIN country co
ON ci.country_id = co.country_id
WHERE country = 'Argentina';

-- Question 5 Show all the film categories with their count in descending order

SELECT c.category_id, c.name, COUNT(f.film_id) AS num_movies_in_cat
FROM category c
FULL JOIN film_category f 
ON c.category_id = f.category_id
GROUP BY c.category_id
ORDER BY num_movies_in_cat DESC;

-- Question 6 What film had the most actors in it (show film info)?

SELECT f.film_id, f.title, COUNT(fa.actor_id) AS num_actors
FROM film f
FULL JOIN film_actor fa 
ON f.film_id = fa.film_id 
GROUP BY f.film_id 
ORDER BY num_actors DESC
LIMIT 1;


-- Question 7 Which actor has been in the least movies?

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS num_films
FROM actor a
FULL JOIN film_actor fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id  
ORDER BY num_films ASC
LIMIT 1;

-- Question 8 Which country has the most cities?

SELECT c.country_id, c.country, COUNT(*) AS num_cities
FROM country c
FULL JOIN city
ON c.country_id = city.country_id 
GROUP BY c.country_id
ORDER BY num_cities DESC
LIMIT 3;

-- Question 9 List the actors who have been in between 20 and 25 films.

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS count
FROM actor a
FULL JOIN film_actor fa
ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) BETWEEN 20 AND 25;

