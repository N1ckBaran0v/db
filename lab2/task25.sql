-- Вставка копий для моделей, у которых количество мест меньше 50, затем удаление копий.
INSERT INTO models
select id + (select max(id) 
             from models), name, version, places, speed
from models 
where places < 50;

delete from models 
where id in (select m.id
             from models m join (select id, 
                                        row_number() 
                                        over(partition by name, version, places, speed order by id) as rn 
                                        from models) as t on m.id = t.id
             where rn > 1);