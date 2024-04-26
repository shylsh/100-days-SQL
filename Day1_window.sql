create database sql_practice;
use sql_practice;
-- Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert records for three departments
INSERT INTO employees (name, department, salary) VALUES 
('John Doe', 'Engineering', 63000),
('Jane Smith', 'Engineering', 55000),
('Michael Johnson', 'Engineering', 64000),
('Emily Davis', 'Marketing', 58000),
('Chris Brown', 'Marketing', 56000),
('Emma Wilson', 'Marketing', 59000),
('Alex Lee', 'Sales', 58000),
('Sarah Adams', 'Sales', 58000),
('Ryan Clark', 'Sales', 61000);


/*

Write the SQL query to find the second highest salary

*/

# Method 1
select * from employees
order by salary desc 
limit 1 offset 2;

# Method 2 
select *
from
	(select *,dense_rank() over(order by salary desc) as drn
from employees) as drs
 where drn =2;
 
 
 -- Question: Get the details of the employee with the second-highest salary from each department
 
 select employee_id, `name`, department, salary
 from
 (
select *, dense_rank() over(partition by department order by salary desc) as drn
from employees) as subquery
where drn =2 ;