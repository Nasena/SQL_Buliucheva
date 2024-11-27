/*Задачи из презентации к Семинару 3.
Задача 1. Посчитать средний чек одного заказа*/

SELECT od.OrderID , SUM(od.Quantity*p.Price)/COUNT(od.OrderID ) AS avg_check
FROM OrderDetails AS od
JOIN Products AS p ON p.ProductID = od.ProductID 
GROUP BY od.OrderID 
ORDER BY avg_check

/*Задача 2. Посчитать сколько заказов доставляет в месяц каждая служба доставки.
Определите, сколько заказов доставила United Package в декабре 2023 года */

SELECT sh.ShipperName, sh.ShipperID, COUNT(o.OrderID) AS 'общее число заказов'
FROM Orders AS o
JOIN Shippers AS sh ON sh.ShipperID = o.ShipperID 
GROUP BY sh.ShipperID

SELECT COUNT(o.OrderID) 
FROM Orders AS o
JOIN Shippers AS sh ON sh.ShipperID = o.ShipperID 
WHERE sh.ShipperName = 'United Package' AND o.OrderDate LIKE '2023-12%'

/*Задача 3. Определить средний LTV покупателя (сколько денег покупатели в среднем тратят в магазине за весь период) */
SELECT c.CustomerName, ROUND(SUM(od.Quantity * p.Price) / COUNT(o.OrderID),1) AS 'сколько денег покупатели в среднем тратят в магазине'
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN OrderDetails AS od ON od.OrderID = o.OrderID 
JOIN Products AS p ON p.ProductID = od.ProductID 
GROUP BY c.CustomerID 


/*Задачи прикрепленные к домашнему заданию.
Задание 1: Анализ прибыли по категориям продуктов
Задание: Определите общую прибыль для каждой категории продуктов,
используя таблицы OrderDetails, Orders и Products. Для расчета прибыли
умножьте цену продукта на количество, а затем суммируйте результаты по
категориям.
Подсказка: Используйте JOIN для объединения таблиц OrderDetails,
Orders, Products и Categories. Примените агрегацию с функцией SUM.*/

SELECT cat.CategoryID, cat.CategoryName, SUM(p.Price*od.Quantity) AS 'прибыль'
FROM Orders AS o
JOIN OrderDetails AS od ON od.OrderID = o.OrderID 
JOIN Products AS p ON p.ProductID = od.ProductID 
JOIN Categories AS cat ON cat.CategoryID = p.CategoryID 
GROUP BY cat.CategoryID

/*Задание 2: Количество заказов по регионам
Задание:Определите количество заказов, размещенных клиентами из различных стран, за каждый месяц.*/
 
SELECT c.Country, strftime('%m', o.OrderDate) AS "Month", strftime('%Y', o.OrderDate) AS "Year" , COUNT(o.OrderID) AS OrderCount
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID 
GROUP BY c.Country,strftime('%m', o.OrderDate), strftime('%Y', o.OrderDate)
ORDER BY YEAR, MONTH 

/*Задание 3: Средняя продолжительность кредитного срока для
клиентов
Задание: Рассчитайте среднюю продолжительность кредитного срока для
клиентов по категориям образования.
Подсказка: Используйте таблицу Clusters и функцию AVG для вычисления
средней продолжительности кредитного срока.*/

SELECT education, ROUND(AVG(credit_term),1) AS 'средняя продолжительность кредитного срока'
FROM Clusters AS c 
GROUP BY education


