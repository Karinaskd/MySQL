-- Kiek nuomos užsakymų įvykdė darbuotojas Mike Hillyer per 2005 metų liepos mėnesį?
SELECT COUNT(rental.rental_id) AS KIEKIS, staff.first_name AS VARDAS, staff.last_name AS PAVARDE FROM staff
INNER JOIN rental ON staff.staff_id=rental.staff_id
WHERE (staff.first_name = "MIKE" AND staff.last_name = "HILLYER") AND rental.rental_date LIKE "2005-07%";

-- Pateikite klientų, kuriuos aptarnavo darbuotas Jon Stephens, vardus, pavardes ir email.
SELECT customer.first_name AS "KLIENTO VARDAS", customer.last_name AS "KLIENTO PAVARDE", customer.email AS "EL.PASTAS", staff.first_name AS "DARBUOTOJO VARDAS", staff.last_name AS "DARBUOTOJO PAVARDE" FROM staff
INNER JOIN store ON staff.store_id=store.store_id
INNER JOIN customer ON store.store_id=customer.store_id
WHERE staff.first_name = "JON" AND staff.last_name = "STEPHENS";

-- Parašykite SQL užklausą, pateikiančią klientų vardus, pavardes, jų iš viso nuomai išleidžiamą sumą (stulpelyje „Iš viso“),
-- o stulpelyje „Rėžiai“ pateikite suskirstytus klientus tokiu būdu: klientus, kurie iš viso nuomai išleidžia 100 ir daugiau, pažymėkite kaip „Virš 100“,
-- o išleidžiančius iki 100 pažymėkite „Iki 100“.
SELECT customer.first_name AS VARDAS, customer.last_name AS PAVARDE, SUM(payment.amount) AS "IS VISO",
CASE
WHEN SUM(payment.amount) >=100 THEN "VIRS 100"
ELSE "IKI 100"
END AS REZIAI FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY customer.customer_id;

-- Parašykite SQL užklausą, pateikiančią klientų ID, mokėjimo datą ir mažiausią kiekvieno kliento mokėjimą,
-- bet tik tų klientų, kurių mažiausias mokėjimas per dieną yra 6.99. Mokėjimo datą pateikite formatu YYYY-MM-DD stulpelyje “Data”,
-- o mažiausią mokėjimą – stulpelyje “Minimalus mokestis”. 
SELECT customer.customer_id AS "KLIENTO ID", DATE(payment.payment_date) AS DATA, MIN(payment.amount) AS "MINIMALUS MOKESTIS" FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY customer.customer_id, payment.payment_date
HAVING MIN(payment.amount) = 6.99;

-- Surasti filmų pavadinimus, kurie priskiriami  "Sci-Fi" arba "Action" kategorijai. Naudokite lenteles film, film_category, category lenteles. 
SELECT film.title AS FILMAS, category.name AS KATEGORIJA FROM film
INNER JOIN film_category ON film.film_id=film_category.film_id
INNER JOIN category ON film_category.category_id=category.category_id
WHERE category.name = "SCI-FI" OR category.name = "ACTION";

--  Surasti filmus, kuriuose vaidino vaidino Cate Harris. Naudokite lenteles film, film_actor, actor lenteles.
SELECT film.title AS FILMAS, actor.first_name AS VARDAS, actor.last_name AS PAVARDE FROM film
INNER JOIN film_actor ON film.film_id=film_actor.film_id
INNER JOIN actor ON film_actor.actor_id=actor.actor_id
WHERE actor.first_name = "CATE" AND actor.last_name = "HARRIS";

--  Pateikite Graikijoje gyvenančių klientų vardą, pavardę ir miesto pavadinimą. Naudokite customer, address, city, country lenteles.
SELECT customer.first_name AS VARDAS, customer.last_name AS PAVARDE, city.city AS MIESTAS, country.country AS SALIS FROM country
INNER JOIN city ON country.country_id=city.country_id
INNER JOIN address ON city.city_id=address.city_id
INNER JOIN customer ON address.address_id=customer.address_id
WHERE country.country = "GREECE";

-- Suraskite filmų nuomos laikotarpius: paėmimo ir grąžinimo datas kliento, kurio pavardė yra LEE. (rental ir customer lentelės)
SELECT rental.rental_date AS "PAEMIMO DATA", rental.return_date AS "GRAZINIMO DATA", customer.first_name AS VARDAS, customer.last_name AS PAVARDE FROM customer
INNER JOIN rental ON customer.customer_id=rental.customer_id
WHERE customer.last_name = "LEE";

-- Kiek klientė Amy Lopez sumokėjo už filmo Rocky War nuomą? Galima išspręsti tiek su inner join, tiek su subužklausa.  
-- Naudokite customer, payment, rental, inventory, film lenteles.
SELECT payment.amount AS SUMA, film.title AS FILMAS, customer.first_name AS VARDAS, customer.last_name AS PAVARDE FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
INNER JOIN rental ON payment.rental_id=rental.rental_id
INNER JOIN inventory ON rental.inventory_id=inventory.inventory_id
INNER JOIN film ON inventory.film_id=film.film_id
WHERE customer.first_name = "AMY" AND customer.last_name = "LOPEZ" AND film.title = "ROCKY WAR";

-- Kiek iš viso kiekvienoje šalyje yra išleidžiama filmų nuomai? Galima išspręsti tiek su inner join, tiek su subužklausa. 
-- Naudokite payment, customer, address, city, country lenteles.
SELECT SUM(payment.amount) AS SUMA, country.country AS SALIS FROM country
INNER JOIN city ON country.country_id=city.country_id
INNER JOIN address ON city.city_id=address.city_id
INNER JOIN customer ON address.address_id=customer.address_id
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY country.country
ORDER BY SUM(payment.amount) DESC;
