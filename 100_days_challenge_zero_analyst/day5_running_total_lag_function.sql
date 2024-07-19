-- day 05/100 days SQL Interview questions

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    store_name VARCHAR(50),
    sale_date DATE,
    sales_amount DECIMAL(10, 2)
);


INSERT INTO sales (store_name, sale_date, sales_amount) 
VALUES
('A', '2024-01-01', 1000.00),
('A', '2024-02-01', 1500.00),
('A', '2024-03-01', 2000.00),
('A', '2024-04-01', 3000.00),
('A', '2024-05-01', 4500.00),
('A', '2024-06-01', 6000.00),
('B', '2024-01-01', 2000.00),
('B', '2024-02-01', 2200.00),
('B', '2024-03-01', 2400.00),
('B', '2024-04-01', 2600.00),
('B', '2024-05-01', 2800.00),
('B', '2024-06-01', 3000.00),
('C', '2024-01-01', 3000.00),
('C', '2024-02-01', 3100.00),
('C', '2024-03-01', 3200.00),
('C', '2024-04-01', 3300.00),
('C', '2024-05-01', 3400.00),
('C', '2024-06-01', 3500.00);

/* 
-- Walmart SQL question for Data Analyst


Calculate each store running total
Growth ratio compare to previous month
return store name, sales amount, running total, growth ratio
*/

-- ORDER BY store_name, sale_date
-- current_month_sale,
-- running total,
-- last month sale - lag
-- growth ratio = cr sale - last_sale/last m sale * 100

select * from sales;
with cte as
(
select *,
		sum(sales_amount) over(partition by store_name order by sale_date) as running_total, 
		lag(sales_amount,1) over(partition by store_name order by sale_date) as previous_sale
from sales
)
select
	store_name,
	sale_date,
	sales_amount,
	running_total,
	previous_sale,
	ROUND(((sales_amount - previous_sale)/previous_sale)*100::numeric,2) as growth_ratio
from cte;
	

