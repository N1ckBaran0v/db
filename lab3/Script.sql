-- Триггер before - перед добавлением новой записи в таблицу моделей поменять её данные на максимальные.

create or replace function before_insert()
returns trigger
as $$
DECLARE 
    cv int;
    command text;
begin
	
	command = 'select count(version) from models where name = ''' || new.name || ''';'; 
    EXECUTE command into new.version;
    return new;
end $$
language plpgsql;

create or replace trigger upd_bef
    before insert on models
    for each row 
    execute procedure before_insert();
   
delete from models
where id > 1000;
   
insert into models values(1001, '84862', -3, 1, 1);

select *
from models
where name = '84862';