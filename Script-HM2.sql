-- Задания из презентации семинара
/*Задание №1: Вам необходимо проверить влияние семейного
положения (family_status) на средний	доход
клиентов (income) и запрашиваемый кредит
(credit_amount)*/

SELECT family_status, AVG(income), credit_amount FROM Clusters
GROUP BY family_status
ORDER BY AVG(income) DESC;

--У не замужних/не женатых людей средний доход больше. У замужних/женатых больше запрашиваемый кредит



--Задача 2.Сколько товаров в категории Meat/Poultry

SELECT COUNT(ProductID) FROM Products
WHERE CategoryID in (SELECT CategoryID FROM Categories 
                         WHERE CategoryName = 'Meat/Poultry');
                         
-- В категории Meat/Poultry 6 товаров.
                        
 
/*Какой товар (название) заказывали в сумме в самом большом количестве (sum(Quantity) в
таблице OrderDetails)*/   
 

 /*SELECT ProductName FROM Products
 WHERE ProductID in (SELECT ProductID,SUM(Quantity) FROM OrderDetails
 ORDER BY SUM(Quantity) DESC 
 LIMIT 1); 
 

SELECT ProductID, SUM(Quantity) FROM OrderDetails
 GROUP BY ProductID
 ORDER BY SUM(Quantity) DESC 
 LIMIT 1;
*/
                        
                        
 /* Задачи прикрепленные к домашнему заданию. 
 
 
 Задание №1: Анализ влияния категорий продуктов на общий доход
Описание: Вам необходимо проверить, как различные категории продуктов влияют на
общий доход (общую сумму заказов) в таблице OrderDetails. Подсчитайте общее
количество заказов (сумму количества) и общий доход (сумму количества * цену) для
каждой категории продуктов. Выведите результаты, включая:
● CategoryID
● Общее количество заказов (total_quantity)
● Общий доход (total_revenue)
Отсортируйте результаты по убыванию общего дохода (total_revenue). Используйте
таблицы Products, OrderDetails и Categories.
  */
                        
 SELECT p.CategoryID, SUM(od.Quantity) AS total_quantity, SUM(od.Quantity*p.Price) AS total_revenue
 FROM OrderDetails AS od 
 JOIN Products AS p ON p.ProductID = od.ProductID 
 GROUP BY p.CategoryID 
 ORDER BY total_revenue DESC 


/* Задание №2: Анализ частоты заказа продуктов по категориям
Описание: Напишите запрос SQL для подсчета количества заказов продуктов по каждой категории. 
Подсчитайте количество уникальных заказов (OrderID) для каждой
категории продуктов.
Выведите результаты, включая:
● CategoryID
● Количество уникальных заказов (order_count)
Отсортируйте результаты по убыванию количества уникальных заказов
(order_count). Используйте таблицы Products, OrderDetails и Categories.*/
 
 SELECT cat.CategoryID, cat.CategoryName, COUNT(DISTINCT od.OrderID) as 'кол-во уникальных заказов'
 FROM OrderDetails AS od
 JOIN Products AS p ON p.ProductID = od.ProductID 
 JOIN Categories AS cat ON cat.CategoryID = p.CategoryID
 GROUP BY cat.CategoryID
 ORDER BY 'кол-во уникальных заказов' DESC
 
/* Задание №3: Вывод наиболее популярных продуктов по количеству заказов
Описание: Выведите список продуктов (название ProductName), отсортированных по
количеству заказов в порядке убывания. Подсчитайте общее количество заказов
(Quantity) для каждого продукта. Выведите результаты, включая:
● ProductName
● Общее количество заказов (total_quantity)
Отсортируйте результаты по убыванию общего количества заказов (total_quantity).
Используйте таблицы Products и OrderDetails.*/

 SELECT p.ProductName, SUM(od.Quantity) AS total_quantity
 FROM Products AS p
 JOIN OrderDetails AS od ON od.ProductID = p.ProductID
 GROUP BY p.ProductID
 ORDER BY total_quantity DESC
 
 
 
 
 