-- Day 03/100 

drop table students
-- Create the student_details table
CREATE TABLE students (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender CHAR(1)
);

-- Insert the data into the student_details table
INSERT INTO students (ID, Name, Gender) VALUES
(1, 'Gopal', 'M'),
(2, 'Rohit', 'M'),
(3, 'Amit', 'M'),
(4, 'Suraj', 'M'),
(5, 'Ganesh', 'M'),
(6, 'Neha', 'F'),
(7, 'Isha', 'F'),
(8, 'Geeta', 'F');


/*
Given table student_details, 
write a query which displays names 
alternately by gender and sorted 
by ascending order of column ID.
*/

SELECT * FROM students;

with ranked_table as
(
select *,
		row_number()over(partition by gender order by id) as rn
from students
),
ranked_table2 as
(
select id,name,gender,rn
	from ranked_table
	order by
	rn,case when gender = 'M' then 1 else 2 end
)
select id, name, gender from ranked_table2;


select id,name,gender,rn
	from (select *,
		row_number()over(order by id) as rn
from students)
	order by
	case when gender = 'M' then 1 else 2 end
	
	
	
with ranked_gender
as 
(select *, row_number() over(partition by gender order by id) as rn
from students),

ranked_gender2
as 
(select id, name, gender , rn
from ranked_gender 
order by rn,
case when gender = 'M' then 1
		else 2 end)
select  id, name, gender from ranked_gender2;

select *, case when gender = 'M' then 1 else 2 end as 
from students;


-- Day 07/100 SQL Problems

DROP TABLE IF EXISTS orders;
CREATE TABLE ORDERS (
    order_id VARCHAR(10),
    customer_id INTEGER,
    order_datetime TIMESTAMP,
    item_id VARCHAR(10),
    order_quantity INTEGER,
    PRIMARY KEY (order_id, item_id)
);

-- Inserting sample data

-- Assuming the ORDERS table is already created as mentioned previously

-- Inserting the provided data
INSERT INTO ORDERS (order_id, customer_id, order_datetime, item_id, order_quantity) VALUES
('O-005', 1, '2023-01-12 11:48:00', 'C005', 1),
('O-005', 1, '2023-01-12 00:48:00', 'C008', 1),
('O-006', 4, '2023-01-16 02:52:00', 'C012', 2),
('O-001', 4, '2023-06-15 04:35:00', 'C004', 3),
('O-007', 1, '2024-07-13 09:15:00', 'C007', 2),
('O-010', 3, '2024-07-13 13:45:00', 'C008', 5),
('O-011', 3, '2024-07-13 16:20:00', 'C006', 2),
('O-012', 1, '2024-07-14 10:15:00', 'C005', 3),
('O-008', 1, '2024-07-14 11:00:00', 'C004', 4),
('O-013', 2, '2024-07-14 12:40:00', 'C007', 1),
('O-009', 3, '2024-07-14 14:22:00', 'C006', 3),
('O-014', 2, '2024-07-14 15:30:00', 'C004', 6),
('O-015', 1, '2024-07-15 05:00:00', 'C012', 4);




DROP TABLE IF EXISTS ITEMS;
CREATE TABLE ITEMS (
    item_id VARCHAR(10) PRIMARY KEY,
    item_category VARCHAR(50)
);

-- Inserting sample data
INSERT INTO ITEMS (item_id, item_category) VALUES
('C004', 'Books'),
('C005', 'Books'),
('C006', 'Apparel'),
('C007', 'Electronics'),
('C008', 'Electronics'),
('C012', 'Apparel');

SELECT * FROM ITEMS;
SELECT * FROM orders;

/*
-- Amazon Asked Interview Questions
1. How many units were ordered yesterday?
2. In the last 7 days (including today), how many units were ordered in each category?
3. Write a query to get the earliest order_id for all customers for each date they placed an order.
4. Write a query to find the second earliest order_id for each customer for each date they placed two or more orders.
*/

SELECT COUNT(*) FROM ORDERS
WHERE EXTRACT (DAY FROM ORDER_DATETIME) = '14';

SELECT 
	I.item_category,COUNT(*) FROM ITEMS I
	INNER JOIN ORDERS O
	ON I.item_id = O.ITEM_ID
WHERE ORDER_DATETIME:: DATE BETWEEN '2024-07-9' AND '2024-07-15'
GROUP BY I.ITEM_CATEGORY;

SELECT * FROM ORDERS

SELECT ORDER_ID
FROM
(
	SELECT *, 
		ROW_NUMBER() OVER(PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATETIME) AS RN
	FROM ORDERS
	
)AS X
WHERE RN = 1;


-- 4. Write a query to find the second earliest order_id for each customer for each date they placed two or more orders.

SELECT ORDER_ID
FROM
(
	SELECT *, 
		ROW_NUMBER() OVER(PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATETIME) AS RN
	FROM ORDERS
)AS X
WHERE RN =2;

-- Day 08/100 Days Challenge



DROP TABLE IF EXISTS trips;

CREATE TABLE trips (
    id INT PRIMARY KEY,
    driver_id INT,
    city VARCHAR(50),
    trip_distance FLOAT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    rating INT
);


INSERT INTO trips (id, driver_id, city, trip_distance, start_time, end_time, rating) VALUES
(1, 101, 'Mumbai', 5.2, '2024-07-01 08:00:00', '2024-07-01 08:20:00', 4),
(2, 101, 'Mumbai', 3.0, '2024-07-01 09:00:00', '2024-07-01 09:15:00', 5),
(3, 102, 'Delhi', 7.1, '2024-07-01 10:00:00', '2024-07-01 10:30:00', 4),
(4, 102, 'Delhi', 2.5, '2024-07-01 11:00:00', '2024-07-01 11:12:00', 2), -- Rating is 3 or below, should be ignored
(5, 103, 'Bangalore', 4.8, '2024-07-01 12:00:00', '2024-07-01 12:25:00', 4),
(6, 103, 'Bangalore', 6.2, '2024-07-01 13:00:00', '2024-07-01 13:40:00', 5),
(7, 101, 'Mumbai', 8.0, '2024-07-02 14:00:00', '2024-07-02 14:30:00', 5),
(8, 102, 'Delhi', 5.5, '2024-07-02 15:00:00', '2024-07-02 15:25:00', 4),
(9, 103, 'Bangalore', 3.6, '2024-07-02 16:00:00', '2024-07-02 16:18:00', 3),
(10, 104, 'Chennai', 6.5, '2024-07-02 09:30:00', '2024-07-02 10:00:00', 4),
(11, 103, 'Hyderabad', 3.2, '2024-07-02 11:00:00', '2024-07-02 11:20:00', 5),
(12, 104, 'Chennai', 4.9, '2024-07-03 13:00:00', '2024-07-03 13:35:00', 4),
(13, 104, 'Kolkata', 7.8, '2024-07-03 15:30:00', '2024-07-03 16:10:00', 5),
(14, 103, 'Hyderabad', 2.7, '2024-07-03 17:00:00', '2024-07-03 17:18:00', 3),
(15, 104, 'Kolkata', 5.4, '2024-07-04 08:45:00', '2024-07-04 09:15:00', 4),
(16, 104, 'Chennai', 3.3, '2024-07-04 10:30:00', '2024-07-04 10:50:00', 5);


SELECT * FROM trips;

/*
You are given a table trips that contains information about taxi trips. The table schema is as follows:

trips
---------
id INT PRIMARY KEY
driver_id INT
city VARCHAR(50)
trip_distance FLOAT
start_time TIMESTAMP
end_time TIMESTAMP
rating INT


Write an SQL query to find the average trip duration for each driver in each city excluding trips where the rating is below 3. The result should include driver_id, city, and average_trip_duration rounded to two decimal places. 

Note:
The average_trip_duration is calculated as the average of the differences between end_time and start_time for each trip.

-- Expected Output Schema:
driver_id INT
city VARCHAR(50)
average_trip_duration FLOAT

*/

SELECT DRIVER_ID,CITY,ROUND(AVG(EXTRACT(EPOCH FROM(END_TIME - START_TIME)/60) )::NUMERIC,2) AS AVERAGE_TRIP_DURATION
FROM TRIPS
WHERE RATING >=3
GROUP BY 1,2



