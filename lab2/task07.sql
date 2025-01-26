-- Ищем минимальную, среднюю и максимальную скорость для поездов версии 0
SELECT min(m.speed) as minspeed, avg(m.speed) as avgspeed, max(m.speed) as maxspeed
from models m 
where m."version" = 0;