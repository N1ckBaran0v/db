-- Получить все заводы в городе с указанием города и id 
create or replace function all_facts_table(text)
returns table(id int, city text, name text) as
$$
    select p.id, p.city, p.name 
    from production p 
    where p.city = $1;
$$
language sql;

explain analyse
select * 
from all_facts_table('A');