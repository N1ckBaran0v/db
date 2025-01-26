-- Ищем самые быстрые версии поездов для каждой из моделей
select od."name", m.version, od.mspeed
from models m inner join (select m2."name", max(speed) as mspeed
                          from models m2
                          group by m2."name") as od on m."name" = od."name" and speed = mspeed;