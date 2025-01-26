-- Добавить новый маршрут в routes
create or replace procedure add_new_route_py(city1 text, city2 text) as
$$
    query = f'''insert into routes
                values((select max(id) from routes) + 1, '{city1}', '{city2}',
                       (select round(avg(cost)) from routes), false);'''
    plpy.execute(query)
$$
language plpython3u;

call add_new_route_py('A', 'B');
select *
from routes r
where r.id > 1000;