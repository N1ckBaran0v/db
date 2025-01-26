-- Вставка копий для моделей, у которых количество мест меньше 50
INSERT INTO models 
select id + (select max(id) 
             from models), name, version, places, speed
from models 
where places < 50;