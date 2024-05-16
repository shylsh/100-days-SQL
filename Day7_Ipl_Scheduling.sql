create table if not exists iplgroups
(
groupA varchar(10),
groupB varchar(10)
);

insert into iplgroups values
('MI','CSK'),
('KKR','SRH'),
('RR','RCB'),
('DC','PBKS'),
('LSG','GT');

SELECT * FROM iplgroups

with cte_schedule
as
(
select a.groupa as HOME, b.groupa as AWAY
from iplgroups as a
cross join iplgroups as b
where a.groupa <> b.groupa
union
select a.groupb , b.groupb
from iplgroups as a
cross join iplgroups as b
where a.groupb <> b.groupb
union
select groupa, groupb from iplgroups
union
select groupb, groupa from iplgroups
union 
select a.groupa, b.groupb
from iplgroups a
cross join iplgroups b
where a.groupa <> b.groupa
)
select * from cte_schedule
where home = 'CSK' or away = 'CSK'

select * from iplgroups a
cross join iplgroups b


