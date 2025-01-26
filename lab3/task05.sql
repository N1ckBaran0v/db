-- Добавить новый маршрут в routes
create or replace procedure add_new_route(text, text) as
$$
    insert into routes
    values((select max(id) from routes) + 1, $1, $2, (select round(avg(cost)) from routes), false);
$$
language sql;

call add_new_route('A', 'B');
select *
from routes r
where r.id > 1000;