-- Получить все версии модели

--create type model_version_info as(
--    version int,
--    places int,
--  speed int
--);

create or replace function all_versions_py(model text)
returns setof model_version_info as
$$
    query = f'''select m."version", m.places, m.speed
                from models m
                where m."name" = '{model}';'''
    res = plpy.execute(query)
    return res
$$
language plpython3u;

select *
from all_versions_py('824-75');