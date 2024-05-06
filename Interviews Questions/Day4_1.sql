
create table orders1(
  	category varchar(20),
	product varchar(20),
	user_id int , 
  	spend int,
  	transaction_date DATE
);

Insert into orders1 values
('appliance','refrigerator',165,246.00,'2021/12/26'),
('appliance','refrigerator',123,299.99,'2022/03/02'),
('appliance','washingmachine',123,219.80,'2022/03/02'),
('electronics','vacuum',178,152.00,'2022/04/05'),
('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
('electronics','TV',145,189.00,'2022/07/15'),
('Television','TV',165,129.00,'2022/07/15'),
('Television','TV',163,129.00,'2022/07/15'),
('Television','TV',141,129.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','yoyo',165,129.00,'2022/07/15'),
('toys','yoyo',163,129.00,'2022/07/15'),
('toys','yoyo',141,129.00,'2022/07/15'),
('toys','yoyo',145,189.00,'2022/07/15'),
('electronics','vacuum',145,189.00,'2022/07/15');



/*
Find the top 2 products in the top 2 categories based on spend amount?
*/

-- first dense_rank for category and products
-- order by whole table

-- Using CTE

select * from orders1;

with top_2_category as
(
select category,total_spend_category from
(
select category, sum(spend) as total_spend_category,
dense_rank() over(order by sum(spend) desc) as drs
from orders1
group by category
) as subquery
where drs <= 2
)
select * from(
select 
o.category,o.product,sum(o.spend) as total_spend_product,
dense_rank() over(partition by o.category order by sum(o.spend) desc) as pdrs
from orders1 o
join top_2_category as tc
on tc.category = o.category
group by o.category, o.product
) as subquery1
where pdrs <=2
;

-- Find top category and product that has least spend amount 

select * from orders1;

with top_category as 
(
select * from
(
select category, sum(spend) as total_spend_category
, dense_rank() over(order by sum(spend) desc ) as drc
from orders1
group by category
) as subquery
where drc =1
)
select * from (
select o.product, o.category, sum(o.spend) as total_spend_product
, dense_rank() over(partition by o.category order by sum(o.spend)) as pdrn
from orders1 o 
join top_category as tc
on tc.category = o.category
group by o.product,o.category
) as subquery1
where pdrn =1
;










