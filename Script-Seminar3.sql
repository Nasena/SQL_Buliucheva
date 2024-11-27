/* Задача 1. Приджойним к данным о заказах данные о покупателях. Данные, которые нас интересуют — 
имя заказчика и страна, из которой совершается покупка.*/

SELECT o.*, CustomerName, Country FROM Customers AS c 
JOIN Orders AS o ON c.CustomerID = o.CustomerID 

/*Задача 2. Давайте проверим, Customer пришедшие из какой страны совершили наибольшее число Orders.
Используем сортировку по убыванию по полю числа заказов.
И выведем сверху в результирующей таблице название лидирующей страны.*/

SELECT count(*) AS cnt, Country 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
GROUP BY Country
ORDER BY cnt DESC
LIMIT 1

/*Задача 3. А теперь напишем запрос, который обеспечит целостное представление деталей заказа,включая информацию как о клиентах,
так и о сотрудниках. Будем использовать JOIN для соединения информации из таблиц Orders, Customers и Employees.*/

SELECT * FROM Customers AS c 
JOIN Orders AS o ON c.CustomerID = o.CustomerID 
JOIN Employees AS e ON e.EmployeeID = o.EmployeeID

/*Задача 4. Наша следующая задача — проанализировать данные заказа, рассчитать ключевые показатели,
связанные с выручкой, и соотнести результаты с ценовой информацией из таблицы Products.
Давайте посмотрим на общую выручку, а также минимальный, максимальный чек в разбивке по странам.*/

SELECT c.Country, SUM(p.Price * od.Quantity) AS TotalRevenue, max(p.Price * od.Quantity) AS MaxReceipt , min(p.Price * od.Quantity) AS MinReceipt
FROM Customers AS c 
JOIN Orders AS o ON c.CustomerID = o.CustomerID 
JOIN OrderDetails od ON od.OrderID  = o.OrderID 
JOIN Products AS p ON p.ProductID = od.ProductID
GROUP BY c.Country
ORDER BY TotalRevenue DESC


/*Задача 5. Выведем имена покупателей, которые совершили как минимум одну покупку 12 декабря */
SELECT DISTINCT c.CustomerName 
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID 
WHERE o.OrderDate = '2023-12-12'


