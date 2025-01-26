-- Получить все заводы в городе
create or replace function all_facts(text)
returns setof text as
$$
    select p.name 
    from production p 
    where p.city = $1;
$$
language sql;

select all_facts('AB') as factories;