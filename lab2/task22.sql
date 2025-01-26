-- Найти среднее количество заводов по городам.
with fcnt(city, cnt) as (
    select city, count(*) as cnt
    from production p 
    group by city
)
select round(avg(cnt)) as "Среднее количество заводов"
from fcnt;