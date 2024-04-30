create table mountain_huts 
(
	id 			integer not null unique,
	`name` 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;
create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;
select * from trails;

/* A ski resort company is planning to construct a new ski slope using a pre-existing network of 
mountain huts and trails between them. A new slope has to begin at one of the mountain huts, 
have a middle station at another hut connected with the first one by a direct trail, and end at 
the third mountain hut which is also connected by a direct trail to the second hut. The altitude 
of the three huts chosen for constructing the ski slope has to be strictly decreasing. */

-- Each entry in the table trails represents a direct connection between huts with IDs hut1 and 
-- hut2. Note that all trails are bidirectional.
-- Create a query that finds all triplets(startpt,middlept,endpt) representing the mountain huts 
-- that may be used for construction of a ski slope.
-- Output returned by the query can be ordered in any way

-- Assume that:
--  there is no trail going from a hut back to itself;
--  for every two huts there is at most one direct trail connecting them;
--  each hut from table trails occurs in table mountain_huts

select * from mountain_huts;
select * from trails;

with trail1 as
(
		select h1.id  ,h1.`name` as start_name , h1.altitude as start_altitude,
		t1.hut1 as start_no, t1.hut2 as end_no
		from mountain_huts h1
		join trails t1 
		on h1.id = t1.hut1
),
trail_table as
(
		select start_no,start_name,start_altitude,end_no,h2.`name` as end_name,h2.altitude as end_altitude
		from trail1 t2
		join mountain_huts h2
		on t2.end_no = h2.id
),
flag_table as
(
		select *, case when start_altitude > end_altitude then 1 else 0 end as flag
		from trail_table
),
final_cte as
(
select 
case when flag = 1 then start_no else end_no end as start_station_no,
case when flag = 1 then start_name else end_name end as start_station,
case when flag = 1 then start_altitude else end_altitude end as start_altitude,
case when flag = 1 then end_no else start_no end as end_station_no,
case when flag = 1 then end_name else start_name end as end_station,
case when flag = 1 then end_altitude else start_altitude end as end_altitude
from flag_table
)
-- Now match trails keeping in mind the decreasing altitude
-- 1-3-5
-- 2-3-5
-- 3-5-4
-- 1-5-4
# These are the possible combinations

select
fc.start_station as start_pt, fc.end_station as mid_pt, fc1.end_station as end_pt
from final_cte fc
join final_cte fc1
on fc.end_station_no = fc1.start_station_no
;
        





