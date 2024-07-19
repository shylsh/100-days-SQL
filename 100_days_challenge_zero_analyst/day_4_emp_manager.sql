-- Day 04/100 days challenge


CREATE TABLE employees (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Manager_ID INT
);


INSERT INTO employees (Emp_ID, Emp_Name, Manager_ID) VALUES
(1, 'John', 3),
(2, 'Philip', 3),
(3, 'Keith', 7),
(4, 'Quinton', 6),
(5, 'Steve', 7),
(6, 'Harry', 5),
(7, 'Gill', 8),
(8, 'Rock', NULL);


-- 2.2 Given table employees, write a query to display employee names along with manager names

select * from employees;

select e2.emp_name, e1.emp_name as manager_name
from employees e1
inner join employees e2
on e1.emp_id = e2.manager_id;