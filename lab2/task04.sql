-- Ищем все поезда, которые следуют из города B в город С
SELECT t.id, t.route, t.prod_year
from trains t
WHERE t.route in (select r.id
                  from routes r                 
                  where r.city1 = 'B' and r.city2 = 'C');