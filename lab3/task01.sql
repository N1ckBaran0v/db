-- Вычислить максимальную цену среди всех маршрутов
create or replace function max_cost()
returns integer as
$$
    select max(cost)
    from routes;
$$
language sql;

explain analyse
select max_cost() as max_cost;