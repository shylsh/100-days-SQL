-- Day 16 of 100 days challenge

--write a query to find users whose transactions has breached their credit limit
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS transactions;

create table users
(
	user_id int,
	user_name varchar(20),
	credit_limit int
);

create table transactions
(
	trans_id int,
	paid_by int,
	paid_to int,
	amount int,
	trans_date date
);

insert into users(user_id,user_name,credit_limit)values
(1,'Peter',100),
(2,'Roger',200),
(3,'Jack',10000),
(4,'John',800);

insert into transactions(trans_id,paid_by,paid_to,amount,trans_date)values
(1,1,3,400,'01-01-2024'),
(2,3,2,500,'02-01-2024'),
(3,2,1,200,'02-01-2024');

select * from users

select * from transactions

select u.user_id, u.credit_limit,t.paid_by, t.paid_to, sum(tr.amount)
from transactions t
join transactions tr
on t.trans_id = tr.trans_id
join users u 
on u.user_id = t.paid_by
group by 1,2,3,4
having sum(tr.amount) < u.credit_limit

with money_spent as
(
select 
	paid_by as user_id,
	sum(amount) as money_paid
from transactions
group by 1
),
money_received as
(
select paid_to as user_id,
		sum(amount) as money_received 
from transactions
group by 1
),
new_limit as
(
select u.user_id,u.user_name,u.credit_limit,
	coalesce(ms.money_paid,0)as money_paid,
	coalesce(mr.money_received,0) as money_received,
	u.credit_limit +(coalesce(mr.money_received,0)) as new_limit
from users u
left join money_spent as ms
on ms.user_id = u.user_id
left join money_received as mr
on mr.user_id = u.user_id
)
select *
from new_limit
where money_paid > new_limit


