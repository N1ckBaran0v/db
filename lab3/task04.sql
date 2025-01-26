-- Вычислить факториал
create or replace function factorial(int)
returns integer as
$$
    select case when $1 = 1 then 1
                when $1 = 0 then 1
                when $1 > 1 then $1 * factorial($1 - 1)
                else -1
           end;
$$
language sql;

select factorial(5) as factorial;