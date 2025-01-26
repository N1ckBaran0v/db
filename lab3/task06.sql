-- Создать копию таблицы models, в которой будут указаны предыдущие версии
create or replace procedure all_prev_versions() as
$$
    drop table if exists models_ver;
    with recursive versions(id, "name", "version", prev) as (
    	select m.id, m.name, m."version", 0 as prev
    	from models m
    	where m."version" = 0
    	union all 
    	select m.id, m."name", m."version", v.id
    	from models as m inner join versions as v on m."name" = v."name" and m."version" = v."version" + 1
	)
	select * into models_ver
	from versions;
$$
language sql;

call all_prev_versions();

select *
from models_ver
where version > 0;

drop table if exists models_ver;