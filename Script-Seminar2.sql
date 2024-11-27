/*Задача 1.
Реализуем пример запроса VALUE_COUNTS, который возвращает количество для
каждого элемента. Давайте посмотрим сколько среди наших клиентов мужчин
и женщин. А затем посмотрим как люди разбиты по образованию.
Не забываем, что в таком запросе нам важно получить отсортированный список,
чтобы сверху были самые популярные экземпляры.*/

SELECT sex, COUNT(*) AS cnt FROM Clusters  
GROUP BY sex
ORDER BY cnt DESC;

/*по образованию*/

SELECT education , COUNT(*) AS cnt FROM Clusters  
GROUP BY education 
ORDER BY cnt DESC;

/*Задача 2. Теперь необходимо сравнить распределение по полу
и образованию (отдельно) для клиентов и не клиентов банка.
Продумать, какая сортировка будет оптимальной.*/

SELECT sex, is_client, COUNT(*) AS cnt FROM Clusters  
GROUP BY sex, is_client 
ORDER BY sex, is_client DESC;

/*по образованию*/

SELECT education , is_client, COUNT(*) AS cnt FROM Clusters  
GROUP BY education , is_client 
ORDER BY education , is_client DESC;

/*Задача 3. Давайте посмотрим образование клиентов с разбивкой по
полу и определим, какое образование самое непопулярное
у них (меньше всего ).
То есть отфильтруем по количеству меньше 40 */

SELECT sex, education, COUNT(*) AS cnt FROM Clusters
WHERE is_client = 1
GROUP BY education, sex
HAVING cnt < 40
ORDER BY cnt DESC;

/*Задание 5. Получить среднюю величину запрашиваемого кредита
и дохода клиентов для клиентов банка в разрезе
образования и пола клиентов*/

SELECT sex, education, ROUND(AVG(credit_amount),1) AS 'средняя величину запрашиваемого кредита'
, ROUND(AVG(income),1) AS 'cредний доход клиента' FROM Clusters
WHERE is_client = 1
GROUP BY sex, education
ORDER BY sex, education;

/*Задача 6. Получить максимальную и минимальную сумму
кредита в разрезе пола и Хороших клиентов для
клиентов с высшим/неполным высшим образованием.
В чем особенность плохих и хороших клиентов? */

SELECT sex, bad_client_target, MAX(credit_amount) AS 'максимальная сумма кредита', MIN(credit_amount) AS 'минимальная сумма кредита' FROM Clusters 
WHERE education LIKE '%higher%'
GROUP BY sex, bad_client_target
ORDER BY sex, bad_client_target;

/*Задача 7. Получить распределение (min, max, avg) возрастов
клиентов в зависимости от пола и оператора связи.
Есть ли какие-нибудь здесь инсайды.*/

SELECT phone_operator, sex, MIN(age), MAX(age), AVG(age) FROM Clusters
GROUP BY sex, phone_operator
ORDER BY phone_operator, sex;

/*Задача 8. Давайте поработаем с колонкой cluster. Для начала
посмотрим сколько кластеров у нас есть и сколько
людей попало в каждый кластер */

SELECT cluster, COUNT(*) AS cnt FROM Clusters 
GROUP BY cluster 
ORDER BY cnt DESC;

/*Задача 9.Видим, что есть большие кластеры 0, 4, 3. Остальные маленькие.
Давайте маленькие кластеры объединим в большой и посмотрим
средний возраст, доход, кредит и пол в больших кластерах
(с помощью функции CASE).*/

SELECT (CASE WHEN cluster IN (1,5,6,2) THEN -1 else cluster END) AS 'new_cluster',
COUNT(*) AS cnt,
AVG(age), AVG(income), AVG(credit_amount), sex
FROM Clusters
GROUP BY new_cluster
ORDER BY cnt;

/*Задача 10. Давайте сейчас проверим гипотезу, что доход
клиентов связан с регионом проживания.*/

SELECT region,avg(income) as avg_income FROM Clusters
group by region
order by avg_income;

/*С помощью подзапроса получите заказы товаров
из 4 и 6 категории (подзапрос в подзапросе).
Таблицы OrderDetails, Products */
SELECT * FROM Orders
WHERE orderid in (select orderid from OrderDetails
where productid in (select productid from Products where categoryid in (4,6) ))

/*В какие страны доставляет товары компания Speedy_Express */

SELECT DISTINCT country from Customers
WHERE customerid in
(SELECT customerid from orders
WHERE shipperid in
(SELECT shipperid FROM Shippers
WHERE shippername = 'Speedy_Express'));

/*Получите 3 страны, где больше всего
клиентов (таблица Customers).*/

SELECT Country, COUNT(*) AS cnt FROM Customers 
GROUP BY Country
ORDER BY cnt DESC 
LIMIT 3;

/*Назовите три самых популярных города и название страны среди трех популярных стран (где больше всего клиентов)*/

SELECT city, country, COUNT(*) AS cnt FROM Customers 
WHERE country in (SELECT country FROM Customers 
GROUP BY country
ORDER BY COUNT(*) DESC 
LIMIT 3)
GROUP BY country, city
ORDER BY cnt DESC
LIMIT 3;

