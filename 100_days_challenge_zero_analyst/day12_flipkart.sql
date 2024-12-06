-- day 12/100 

/*
Advanced Flipkart Sales Analysis Question
Question:
Flipkart wants to identify seasonal sales trends and understand customer purchasing behavior during different times of the year. You have the following tables: Sales, Products, and Customers.
*/
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Smartphone', 'Electronics', 799.99),
(3, 'Headphones', 'Electronics', 199.99),
(4, 'Refrigerator', 'Appliances', 1499.99),
(5, 'Microwave', 'Appliances', 299.99),
(6, 'T-shirt', 'Clothing', 19.99),
(7, 'Jeans', 'Clothing', 49.99),
(8, 'Blender', 'Appliances', 99.99),
(9, 'Coffee Maker', 'Appliances', 79.99),
(10, 'Shoes', 'Clothing', 89.99);




CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    sale_date DATE,
    quantity INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Sales (sale_id, product_id, customer_id, sale_date, quantity, amount) VALUES
(1, 1, 101, '2023-01-15', 1, 999.99),
(2, 2, 102, '2023-02-16', 2, 1599.98),
(3, 3, 103, '2023-03-17', 3, 599.97),
(4, 4, 104, '2023-04-18', 1, 1499.99),
(5, 5, 105, '2023-05-19', 2, 599.98),
(6, 6, 101, '2023-06-20', 5, 99.95),
(7, 7, 102, '2023-07-21', 3, 149.97),
(8, 8, 103, '2023-08-22', 1, 99.99),
(9, 9, 104, '2023-09-23', 2, 159.98),
(10, 10, 105, '2023-10-24', 1, 89.99),
(11, 1, 101, '2023-11-24', 1, 999.99),
(12, 2, 102, '2023-11-25', 2, 1599.98),
(13, 3, 103, '2023-11-26', 3, 599.97),
(14, 4, 104, '2023-11-27', 1, 1499.99),
(15, 5, 105, '2023-11-28', 2, 599.98);





CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100)
);

INSERT INTO Customers (customer_id, customer_name, customer_city, customer_state) VALUES
(101, 'Alice', 'New York', 'NY'),
(102, 'Bob', 'Los Angeles', 'CA'),
(103, 'Charlie', 'Chicago', 'IL'),
(104, 'David', 'Houston', 'TX'),
(105, 'Eve', 'Phoenix', 'AZ');



/*
Interview Question
Tasks:
1 Write a query to calculate the average monthly sales for each category!
return category that has highest average sale in each month!


2. Write a query to identify the customers who spent the most 
money during the Big Billion Days Sale (November 24-27) in 2023.

return customer name, id and total spent
*/

SELECT * FROM customers;
SELECT * FROM sales;
SELECT * FROM products;

with ranks as
(
select extract(month from s.sale_date)as months,
p.category, avg(s.amount) as average_sales, 
	dense_rank() over(partition by extract(month from s.sale_date) order by avg(s.amount) desc) as rnks
from products p
left join sales s
on p.product_id = s.product_id
group by 1,2
order by 1,2
	)
select months, category, average_sales
from ranks 
where rnks =1;

-- . Write a query to identify the customers who spent the most 
-- money during the Big Billion Days Sale (November 24-27) in 2023.

-- cutomer_id, cx name cx table
-- sum(amount) group by cx id and cx name
-- filter for 24, 25, 26 and 27 nov 23
-- having to select one cx who has highest spent 

select * from sales;
select * from customers;

select c.customer_id, c.customer_name, sum(s.amount) as total_expenditure
from customers c
join sales s
on s.customer_id = c.customer_id
where extract(day from s.sale_date) in(24,25,26,27,28)
group by 1,2
order by 3 desc
limit 1

select c.customer_id, c.customer_name, sum(s.amount) as total_expenditure
from customers c
join sales s
on s.customer_id = c.customer_id
where s.sale_date between '24-11-2023' and '27-11-2023'
group by 1,2
order by 3 desc
limit 1






