# Домашнее задание к занятию 12.5 "Реляционные базы данных: Индексы"

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1.

Напишите запрос к учебной базе данных, который вернет процентное отношение общего размера всех индексов к общему размеру всех таблиц.

### Ответ:

![Image alt](https://github.com/IvanSKorobkov/homework/blob/main/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%20%D0%BE%D1%82%202022-12-10%2016-40-29.png)

SELECT ROUND(SUM(INDEX_LENGTH)/SUM(DATA_LENGTH)*100) AS procent   
FROM information_schema.TABLES a  
WHERE a.table_schema='sakila';

### Задание 2.

Выполните explain analyze следующего запроса:
```sql
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
- перечислите узкие места,
- оптимизируйте запрос (внесите корректировки по использованию операторов, при необходимости добавьте индексы).
