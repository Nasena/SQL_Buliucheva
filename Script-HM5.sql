/*Задание 1: Создание таблицы и изменение данных
Задание: Создайте таблицу EmployeeDetails для хранения информации о
сотрудниках. Таблица должна содержать следующие столбцы:
● EmployeeID (INTEGER, PRIMARY KEY)
● EmployeeName (TEXT)
● Position (TEXT)
● HireDate (DATE) - дата приема на работу
● Salary (NUMERIC) - зарплата
После создания таблицы добавьте в неё три записи с произвольными данными о
сотрудниках.*/


CREATE TABLE EmployeeDetails (
Employee_ID INTEGER PRIMARY KEY,
Employee_Name TEXT,
Position TEXT,
Hire_Date DATE,
Salary NUMERIC
);

INSERT INTO EmployeeDetails
(Employee_Name, "Position", Hire_Date, Salary)
VALUES('Ivan Ivanov', 'Manager', '2024-11-27', 100000);

INSERT INTO EmployeeDetails
(Employee_Name, "Position", Hire_Date, Salary)
VALUES('Petr Petrov', 'Driver', '2024-09-01', 50000);

INSERT INTO EmployeeDetails
(Employee_Name, "Position", Hire_Date, Salary)
VALUES('Katya Petrova', 'Manager', '2024-08-15', 150000);

INSERT INTO EmployeeDetails
(Employee_Name, "Position", Hire_Date, Salary)
VALUES('Katya Kozlova', 'Manager', '2024-08-11', 110000);

--дополнительно

 UPDATE EmployeeDetails
 SET  Salary= 30000
 WHERE Employee_ID = 3;


/*Задача 2. 
Создайте представление HighValueOrders для отображения всех заказов,
сумма которых превышает 10000. В представлении должны быть следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● TotalAmount (общая сумма заказа, вычисленная как сумма всех Quantity *
Price).
Используйте таблицы Orders, OrderDetails и Products.*/

CREATE VIEW HighValueOrders AS 
SELECT o.OrderID,
       o.OrderDate,
       (od.Quantity*p.Price) AS TotalAmount
FROM Orders AS o 
JOIN OrderDetails AS od ON od.orderID = o.OrderID 
JOIN Products AS p ON p.ProductID = od.ProductID
WHERE TotalAmount > 10000;

-- доп.работа с представлением
SELECT * 
FROM HighValueOrders AS hvo 
WHERE TotalAmount < 12000;


/*Задание 3.
 Удалите все записи из таблицы EmployeeDetails, где Salary меньше 50000. Затем удалите таблицу EmployeeDetails из базы данных.
Подсказки:
1. Используйте команду DELETE FROM для удаления данных.
2. Используйте команду DROP TABLE для удаления таблицы. */
DELETE FROM EmployeeDetails WHERE Salary < 50000;
DROP TABLE EmployeeDetails;

/*Задание: Создайте хранимую процедуру GetProductSales с одним параметром
ProductID. Эта процедура должна возвращать список всех заказов, в которых
участвует продукт с заданным ProductID, включая следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● CustomerID (идентификатор клиента).*/

CREATE PROCEDURE GetProductSales(IN _ProductID INTEGER)
BEGIN
SELECT
o.OrderID,
o.OrderDate,
o.CustomerID
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE od.ProductID = _ProductID;
END;

