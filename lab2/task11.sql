-- Ищем списанные поезда и заменяем им год выпуска на текстовое описание
drop table if exists tmp_table;

select t.id, (select m."name"
              from models m
              where m.id = t.model) as model,
              t.prod_year,
              case 
                   when t.prod_year = 2023 then 'В этом году'
                   when t.prod_year = 2022 then 'В прошлом году'
                   when t.prod_year > 2020 then 'В этом десятилетии'
                   when t.prod_year > 2010 then 'В прошлом десятилетии'
                   when t.prod_year > 2000 then 'В этом веке'
                   else 'В прошлом веке'
              end as prod_year_text
INTO tmp_table
from trains t
where t.status = 'Снят с эксплуатации';

select * 
from tmp_table;
