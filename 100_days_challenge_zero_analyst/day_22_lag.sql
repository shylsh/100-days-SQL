-- 22/100 Days SQL Challenge

-- Given a user_activity table, write a SQL query to find all users who have logged in on at least 3 consecutive days.

DROP TABLE IF EXISTS user_activity;
CREATE TABLE user_activity (
    user_id INT,
    login_date DATE
);



INSERT INTO user_activity (user_id, login_date) VALUES
(1, '2024-08-01'),
(1, '2024-08-02'),
(1, '2024-08-05'),
(1, '2024-08-07'),
(2, '2024-08-01'),
(2, '2024-08-02'),
(2, '2024-08-03'),
(2, '2024-08-04'),
(2, '2024-08-06'),
(3, '2024-08-01'),
(3, '2024-08-02'),
(3, '2024-08-03'),
(3, '2024-08-07'),
(4, '2024-08-02'),
(4, '2024-08-05'),
(4, '2024-08-07');

-- Given a user_activity table, write a SQL query to find all users who have logged in on at least 3 consecutive days.

select * from user_activity;

with streak1 as
(
select user_id,
		login_date,
		case when
		login_date = lag(login_date) over(partition by user_id order by login_date) + interval '1 day' then 1
		else 0
		end as streak
from user_activity
),
streak2 as
(
select user_id,
	login_date,
	sum(streak) over(partition by user_id order by login_date) as streak
from streak1
)
select distinct user_id
from streak2
where streak >2
