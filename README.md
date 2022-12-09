# Домашнее задание к занятию 12.4 "Реляционные базы данных: SQL. Часть 2"

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1.

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей и выведите в результат следующую информацию: 
- фамилия и имя сотрудника из этого магазина,
- город нахождения магазина,
- количество пользователей, закрепленных в этом магазине.

###Ответ:
![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-12-09%2018-30-01.png)

SELECT s.store_id, COUNT(customer_id) AS 'winner',  
CONCAT(s2.first_name, ' ', s2.last_name) AS 'win_name',   
c2.city AS 'place'  FROM sakila.store s  
INNER JOIN sakila.customer c on c.store_id = s.store_id   
INNER JOIN staff s2 ON s2.staff_id = s.manager_staff_id   
INNER JOIN address a ON a.address_id = s.address_id  
INNER JOIN city c2 ON c2.city_id = a.city_id  
GROUP BY s.store_id  
HAVING count(customer_id) > 300; 

### Задание 2.

###Ответ:
![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-12-09%2018-32-38.png)

SELECT COUNT(f.film_id) as 'avg_movie_length'  
FROM film f   
WHERE f.length > (SELECT AVG(f2.length) FROM film f2);

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

### Задание 3.

Получите информацию, за какой месяц была получена наибольшая сумма платежей и добавьте информацию по количеству аренд за этот месяц.

###Ответ:
![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-12-09%2018-35-37.png)

SELECT SUM(p.amount) AS 'highest payment',   
DATE_FORMAT(p.payment_date, '%Y-%M') AS 'date',  
COUNT(r.rental_id) AS 'number of leases'  
FROM payment p   
LEFT JOIN rental r ON r.rental_id = p.rental_id   
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%M')  
ORDER BY 1 DESC   
LIMIT 1;
