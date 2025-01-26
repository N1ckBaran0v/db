-- Получить все заводы в городе с указанием города и id 
create or replace function all_facts_table_py(fcity text)
returns table(id int, city text, name text) as
$$
    query = f'''select p.id, p.city, p.name
                from production p
                where p.city = '{fcity}';'''
    res = plpy.execute(query)
    return res
$$
language plpython3u;

explain analyse
select * 
from all_facts_table_py('A');