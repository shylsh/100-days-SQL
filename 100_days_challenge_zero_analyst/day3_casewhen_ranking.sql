-- Day 03/100 

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

select * from students;

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