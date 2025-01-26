-- Ищем количество поездов, выпущенных на каждом заводе города A
SELECT p."name", (select count(*)
                  from trains t 
                  where t.produced  = p.id) as cnt
from production p 
where p.city = 'A';