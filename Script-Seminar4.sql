/*Задание 1.
Рассчитайте среднее количество товаров, заказанных каждым покупателем (используя оконную функцию).*/

SELECT 
      AVG(Quantity),
      CustomerID
FROM Orders o 
JOIN OrderDetails od ON o.OrderID = od.OrderID 
GROUP BY o.CustomerID 


SELECT 
      AVG(Quantity) OVER (PARTITION BY o.CustomerID) AS AvgQuantityOrdered,
      CustomerID
FROM Orders o 
JOIN OrderDetails od ON o.OrderID = od.OrderID 


/*Задача 2. 
Определите первую и последнюю даты заказа для каждого клиента*/

SELECT min(OrderDate),
       max(OrderDate),
       CustomerID,
       Count(*)

FROM Orders AS o 
GROUP BY CustomerID 

SELECT min(OrderDate) OVER (PARTITION BY CustomerID ) AS min_date,
       max(OrderDate) OVER (PARTITION BY CustomerID ) AS max_date,
       CustomerID,
       Count(*) OVER (PARTITION BY CustomerID ) as 'количество заказов'
FROM Orders AS o 


/*Задача 3. 
Получите общее количество заказов для каждого клиента, а также имя и город клиента.*/
SELECT c.CustomerID,
       CustomerName,
       city,
       COUNT(*) OVER (PARTITION BY c.CustomerID) 
FROM Orders o 
JOIN Customers c ON o.CustomerID = c.CustomerID 

/*Задача 4.
Ранжируйте сотрудников на основе общего количества обработанных ими заказов*/
SELECT EmployeeID,
       RANK () OVER (ORDER BY COUNT(OrderID))
FROM Orders AS o
GROUP BY EmployeeID 

/* Задача 5.
Определите среднюю цену товаров внутри каждой категории, рассматривая только
категории, в которых более трех товаров.*/

WITH product_price AS (
SELECT DISTINCT 
       CategoryID,
       AVG(Price) OVER (PARTITION By CategoryID),
       COUNT(ProductID) OVER (PARTITION By CategoryID) AS cnt
FROM Products AS p)
SELECT *
FROM product_price
WHERE cnt >9;

/*Задача 6.
 Рассчитайте процент от общего объема (выручки) продаж каждого продукта в своей категории. */

select productname, categoryid, ROUND(sum(price*quantity) /
sum(sum(price*quantity)) over (partition by categoryid) * 100,1) as cash_pwrc
from OrderDetails od
join Products p on od.productid = p.productid
group by productname, categoryid
order by categoryid, sum(price*quantity) / sum(sum(price*quantity)) over
(partition by categoryid) desc

/*Задача 7.
 * Для каждого заказа сделайте новую колонку в которой определите общий объем продаж за каждый месяц, учитывая все годы. */

SELECT 
     STRFTIME('%Y', o.OrderDate) AS YEAR,
     STRFTIME('%m', o.OrderDate) AS MONTH,
     SUM(od.Quantity*p.Price) OVER (PARTITION BY STRFTIME('%m', o.OrderDate), STRFTIME('%Y', o.OrderDate) ORDER BY STRFTIME('%Y', o.OrderDate))  AS TotalSales  
FROM Orders AS o
JOIN OrderDetails AS od ON od.OrderID = o.OrderID
JOIN Products AS p ON p.ProductID = od.OrderID 
ORDER BY STRFTIME('%Y', o.OrderDate), STRFTIME('%m', o.OrderDate)

SELECT
YEAR(o.OrderDate) AS Month,
MONTH(o.OrderDate) AS Year,
SUM(od.Quantity * p.Price) OVER (PARTITION BY MONTH(o.OrderDate),
YEAR(o.OrderDate) ORDER BY YEAR(o.OrderDate)) AS TotalSales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
ORDER BY Year, Month


