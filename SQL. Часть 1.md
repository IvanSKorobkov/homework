# Домашнее задание к занятию 12.3 "Реляционные базы данных: SQL. Часть 1"

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1.

Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a”, и не содержат пробелов.

### Ответ:
![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-12-08%2016-47-15.png)

SELECT DISTINCT district   
FROM sakila.address  
WHERE district LIKE 'K%a'  
AND district NOT LIKE '% %';

### Задание 2.

Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года **включительно**, 
и стоимость которых превышает 10.00.

### Ответ:
![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-12-06%2022-23-45.png)

SELECT * FROM sakila.payment  
WHERE CAST(payment_date AS DATE) BETWEEN CAST('2005-06-15' AS DATE) AND CAST('2005-06-18' AS DATE)  
AND amount>10.00;

### Задание 3.

Получите последние 5 аренд фильмов.

### Ответ:
![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-12-06%2022-53-38.png)

SELECT rental_id, rental_date AS last_5_rental  
FROM sakila.rental  
ORDER BY rental_id DESC LIMIT 5;

### Задание 4.

Одним запросом получите активных покупателей, имена которых Kelly или Willie. 

Сформируйте вывод в результат таким образом:
- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
- замените буквы 'll' в именах на 'pp'

### Ответ:
![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-12-07%2019-06-21.png)

SELECT LOWER(last_name) AS lastname, LOWER(REPLACE(first_name, 'LL', 'pp')) AS firstname  
FROM sakila.customer WHERE first_name='KELLY' OR first_name='WILLIE';
