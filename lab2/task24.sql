-- Вывести минимальную, среднюю и максимальную стоимости билета для маршрутов.
select r.city1, r.city2,
       min(r.cost) over(partition by r.city1, r.city2) as min_cost,
       avg(r.cost) over(partition by r.city1, r.city2) as avg_cost,
       max(r.cost) over(partition by r.city1, r.city2) as max_cost
from routes r;