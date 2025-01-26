-- Получить имена всех таблиц схемы
create or replace procedure get_table_names(text)
as $$
declare 
    curs cursor for select tablename
                    from pg_tables
                    where schemaname = $1;
    command text;
begin
	drop table if exists table_names;
    create table table_names(name text);
    for i in curs loop
	    command = 'insert into table_names values(''' || i.tablename || ''');';
	    execute command;
    end loop;
end $$
language plpgsql;

call get_table_names('public');

select *
from table_names;