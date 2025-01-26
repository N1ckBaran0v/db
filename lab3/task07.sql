-- Получить все ремонтируемые поезда
create or replace procedure get_trains_names()
as $$
declare 
    curs cursor for select t.id, m."name", t.prod_year, t.status
                    from trains t join models m on t.model = m.id 
                    where m."version" = 0 and t.status = 'В ремонте';
    command text; 
begin
	drop table if exists trains_names;
	create table trains_names (
	    id int primary key,
	    name text,
	    prod_year int,
	    status text
	);
    for i in curs loop
	    command = 'insert into trains_names values(' || to_char(i.id, '99999') || ', ''' || i.name || ''', ' || 
	                                                    to_char(i.prod_year, '9999') || ', ''' || i.status || ''');';
	    execute command;
    end loop;
end $$
language plpgsql;

call get_trains_names();

select *
from trains_names;