-- Ищем поезда, выпущенные на заводе с id, равным 0, и заменяем им статус на флаг активности
select t.id, (select m."name"
              from models m
              where m.id = t.model) as model,
              case t.status 
                   when 'Снят с эксплуатации' then false
                   else true 
              end as is_active
from trains t
where t.produced = 1;