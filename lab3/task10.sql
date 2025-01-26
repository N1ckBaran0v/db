-- Создать view для таблицы trains, в котором вместо удаления выводить поезда из эксплуатации
create or replace view trains_view as select *
                                      from trains;

create or replace function insteadof_delete()
returns trigger
as $$
begin
	UPDATE trains_view
	SET status = 'Снят с эксплуатации'
	where id = old.id;
    return old;
end $$
language plpgsql;

create or replace trigger inof_del
    instead of delete on trains_view
    for each row 
    execute procedure insteadof_delete();
    
delete from trains_view
where prod_year = 2020;

select *
from trains
where prod_year = 2020;