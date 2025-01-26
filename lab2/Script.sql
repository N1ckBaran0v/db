-- найти 10 самых новых поездов, которые связаны с определённым городом
select t.id, r.city1, r.city2, t.prod_year 
from trains t join routes r on t.route = r.id
where r.city1 = 'F' or r.city2 = 'F'
order by prod_year desc
limit 10;