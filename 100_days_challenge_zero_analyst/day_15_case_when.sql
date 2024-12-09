-- day 15/100 days challenge

DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS orders;


CREATE TABLE Restaurants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurants(id),
    order_time TIMESTAMP,
    dispatch_time TIMESTAMP
);

INSERT INTO Restaurants (name, location) VALUES
('Restaurant A', 'Delhi'),
('Restaurant B', 'Delhi'),
('Restaurant C', 'Delhi'),
('Restaurant D', 'Delhi'),
('Restaurant E', 'Delhi');

INSERT INTO Orders (restaurant_id, order_time, dispatch_time) VALUES
(1, '2024-07-23 12:00:00', '2024-07-23 12:14:00'),
(1, '2024-07-23 12:30:00', '2024-07-23 12:48:00'),
(1, '2024-07-23 13:00:00', '2024-07-23 13:16:00'),
(2, '2024-07-23 13:30:00', '2024-07-23 13:50:00'),
(2, '2024-07-23 14:00:00', '2024-07-23 14:14:00'),
(3, '2024-07-23 14:30:00', '2024-07-23 14:49:00'),
(3, '2024-07-23 15:00:00', '2024-07-23 15:16:00'),
(3, '2024-07-23 15:30:00', '2024-07-23 15:40:00'),
(4, '2024-07-23 16:00:00', '2024-07-23 16:10:00'),
(4, '2024-07-23 16:30:00', '2024-07-23 16:50:00'),
(5, '2024-07-23 17:00:00', '2024-07-23 17:25:00'),
(5, '2024-07-23 17:30:00', '2024-07-23 17:55:00'),
(5, '2024-07-23 18:00:00', '2024-07-23 18:19:00'),
(1, '2024-07-23 18:30:00', '2024-07-23 18:44:00'),
(2, '2024-07-23 19:00:00', '2024-07-23 19:13:00');


/*
You are given two tables: Restaurants and Orders. After receiving an order, 
each restaurant has 15 minutes to dispatch it. Dispatch times are categorized as follows:

on_time_dispatch: Dispatched within 15 minutes of order received.
late_dispatch: Dispatched between 15 and 20 minutes after order received.
super_late_dispatch: Dispatched after 20 minutes.
Task: Write an SQL query to count the number of dispatched orders in each category for each restaurant.
*/

SELECT * FROM restaurants;
SELECT * FROM orders;


with d_category as
(
select 
	r.id,r."name",o.order_time,o.dispatch_time,
	o.dispatch_time - o.order_time as time_taken,
	case
	when o.dispatch_time - o.order_time <= interval'15 minutes' then 'on_time_dispatch'
	when o.dispatch_time - o.order_time > interval'15 minutes' and o.dispatch_time - o.order_time <= interval '20 minutes' then 'late_dispatch'
	else 'super_late_dispatch'
	end as dispatch_category
	
from orders o
join restaurants r
on o.restaurant_id = r.id
)
select id, "name",
	count(case when dispatch_category = 'on_time_dispatch' then 1 end) as on_time_cnt,
	count(case when dispatch_category = 'late_dispatch' then 1 end) as late_dispatch_cnt,
	count(case when dispatch_category = 'super_late_dispatch' then 1 end) as super_late_dispatch_cnt
from d_category
group by 1,2
order by 1

	
	


select dispatch_time - order_time as timetaken
from orders
where dispatch_time - order_time between interval '15 minutes' and  interval'20 minutes'
