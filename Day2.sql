USE sql_practice;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);

DROP TABLE IF EXISTS Returns;
CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    OrderID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders (OrderID, OrderDate, TotalAmount) VALUES
(1, '2023-01-15', 150.50),
(2, '2023-02-20', 200.75),
(3, '2023-02-28', 300.25),
(4, '2023-03-10', 180.00),
(5, '2023-04-05', 250.80);

INSERT INTO Returns (ReturnID, OrderID) VALUES
(101, 2),
(102, 4),
(103, 5),
(104, 1),
(105, 3);


/*

Given the Orders table with columns OrderID, 
OrderDate, and TotalAmount, and the 
Returns table with columns ReturnID and OrderID, 

write an SQL query to calculate the total 
numbers of returned orders for each month

*/


SELECT 
    MONTHNAME(o.orderdate) AS `Month`,
    COUNT(r.returnid) AS returned_orders
FROM
    `returns` r
        LEFT JOIN
    orders o ON o.orderid = r.orderid
GROUP BY `Month`;

-- With Year

SELECT 
    concat(MONTHNAME(o.orderdate),'-',year(o.orderdate)) AS `Month`,
    COUNT(r.returnid) AS returned_orders
FROM
    `returns` r
        LEFT JOIN
    orders o ON o.orderid = r.orderid
GROUP BY `Month`;

