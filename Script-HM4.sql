/*Задача 1.
Задание: Ранжируйте продукты в каждой категории на основе их средней цены
(AvgPrice). Используйте таблицы OrderDetails и Products.
Результат: В результате запроса будут следующие столбцы:
● CategoryID: идентификатор категории продукта,
● ProductID: идентификатор продукта,
● ProductName: название продукта,
● AvgPrice: средняя цена продукта,
● ProductRank: ранг продукта внутри своей категории на основе средней цены в
порядке убывания. */

WITH ProductAvgPrice AS (
SELECT p.CategoryID,
       p.ProductID,
       p.ProductName,
      AVG(p.Price) AS AvgPrice
FROM OrderDetails AS od
JOIN Products AS p ON p.ProductID = od.ProductID
GROUP BY p.CategoryID,  p.ProductID
)
SELECT *,
      RANK() OVER (PARTITION BY CategoryID ORDER BY AvgPrice DESC) AS ProductRank
FROM ProductAvgPrice;

/*Задача 2.
Средняя и максимальная сумма кредита по месяцам
Задание: Рассчитайте среднюю сумму кредита (AvgCreditAmount) для каждого
кластера в каждом месяце и сравните её с максимальной суммой кредита
(MaxCreditAmount) за тот же месяц. Используйте таблицу Clusters */

SELECT DISTINCT 
       cluster,
       "month",
       AVG(credit_amount) OVER (PARTITION BY cluster ORDER BY "month") AS AvgCredit,
       MAX(credit_amount) OVER (PARTITION BY cluster ORDER BY "month") AS MAXCredit
FROM Clusters




WITH AvgCredit AS (
SELECT cluster, 
       "month",
       ROUND(AVG(credit_amount),2) AS AvgCreditAmount
FROM Clusters
GROUP BY cluster, "month"
), MaxCredit AS (
SELECT cluster, 
       "month",
       Max(credit_amount) AS MaxCreditAmount
FROM Clusters
GROUP BY cluster, "month"
)

SELECT a.month,
       a.cluster,
       a.AvgCreditAmount,
       m.MaxCreditAmount
FROM AvgCredit as a
join MaxCredit AS m ON m."month" = a."month";

/* Задача 3.
 * Задание: Создайте таблицу с разницей (Difference) между суммой кредита и
предыдущей суммой кредита по месяцам для каждого кластера. Используйте таблицу
Clusters.*/

-- Рассчитываем сумму кредита и сумму кредита в предыдущем месяце
WITH CreditWithPrevious AS (
SELECT
month,
cluster,
credit_amount,
LAG(credit_amount) OVER (PARTITION BY cluster ORDER BY
month) AS PreviousCreditAmount
FROM Clusters
)
-- Вычисляем разницу между текущей и предыдущей суммой кредита
SELECT
month,
cluster,
credit_amount,
PreviousCreditAmount,
COALESCE(credit_amount - PreviousCreditAmount, 0) AS Difference
FROM CreditWithPrevious;

---


WITH CreditWithPrevious AS (
SELECT month,
       cluster,
       credit_amount,
       LAG(credit_amount) OVER (PARTITION BY cluster ORDER BY month) AS PreviousCreditAmount
FROM Clusters c 
)
SELECT month,
       cluster,
       credit_amount,
       PreviousCreditAmount,
       (credit_amount - PreviousCreditAmount) 
FROM CreditWithPrevious;

