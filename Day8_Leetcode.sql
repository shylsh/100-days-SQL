-- Write a SQL query to get the second highest salary from the Employee table

create table employee 
(
	ID int,
	salary int
);

insert into employee values
(1,100),
(2,200),
(3,300);

select * from employee;

select * 
from employee
order by 2 desc limit 1 offset 1;

-- Write a SQL query to get the nth highest salary from the Employee table

with salary_rank as
(
select *, dense_rank() over(order by salary desc) as dr
from 
employee
	)
select * from salary_rank
where dr =2;

--  Write a SQL query to rank scores. If there is a tie between two scores, both
-- should have the same ranking. Note that after a tie, the next ranking number
-- should be the next consecutive integer value. In other words, there should be no
-- "holes" between ranks

create table scores
(
	ID int,
	Score float
);

insert into scores values
(1,3.50),
(2,3.65),
(3,4.00),
(4,3.85),
(5,4.00),
(6,3.65);

select * from scores;

select score,
dense_rank() over(order by score desc) as rank
from scores;

-- Write a SQL query to find all numbers that appear at least three times
-- consecutively

create table numbers
(
	id int,
	Num int
);

insert into numbers values
(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,2),
(7,2);

select * from numbers;

select distinct num as consecutive_numbers
from numbers

SELECT A.NUM FROM numbers a
INNER JOIN numbers b
ON A.ID=B.ID+1 AND A.NUM=B.NUM
INNER JOIN numbers c
ON A.ID=B.ID+2 AND A.NUM=C.NUM;




