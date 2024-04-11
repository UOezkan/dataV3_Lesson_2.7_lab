USE sakila;

-- 1 How many films are there for each of the categories in the category table. 
# Use appropriate join to write this query.
SHOW tables; 

SELECT c.name AS category_name, COUNT(film_id) AS film_count
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;


-- 2 Display the total amount rung up by each staff member in August of 2005.


SELECT staff_id, SUM(amount) AS total_amount
FROM payment
WHERE payment_date >= '2005-08-01' AND payment_date < '2005-09-01'
GROUP BY staff_id;

SELECT
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_amount
FROM
    staff s
JOIN
    payment p ON s.staff_id = p.staff_id
WHERE
    p.payment_date >= '2005-08-01'
    AND p.payment_date < '2005-09-01'
GROUP BY
    s.staff_id;


-- 3 Which actor has appeared in the most films?
SELECT actor_id, COUNT(film_id) AS film_count
FROM film_actor
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1;


-- 4 Most active customer (the customer that has rented the most number of films)

SELECT customer_id, COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id
ORDER BY rental_count DESC
LIMIT 1;

SELECT
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS rental_count
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id
ORDER BY
    rental_count DESC
LIMIT 10;


-- 5 Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a ON s.address_id = a.address_id;


-- 6. List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(DISTINCT a.actor_id) AS actor_count
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id, f.title;


-- 7. Using the tables payment and customer and the JOIN command, 
#list the total paid by each customer. List the customers alphabetically by last name.
SELECT c.last_name, c.first_name, SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.last_name, c.first_name
ORDER BY c.last_name ASC;


-- 8. List the titles of films per category.
SELECT c.name AS category_name, GROUP_CONCAT(f.title) AS film_titles
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;


