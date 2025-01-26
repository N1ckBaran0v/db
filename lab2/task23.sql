-- Вывести все модели ненулевой версии с указанием индекса предыдущей версии.
with recursive versions(id, "name", "version", prev) as (
    select m.id, m.name, m."version", 0 as prev
    from models m
    where m."version" = 0
    union all 
    select m.id, m."name", m."version", v.id
    from models as m inner join versions as v on m."name" = v."name" and m."version" = v."version" + 1
)
select *
from versions
where prev > 0;