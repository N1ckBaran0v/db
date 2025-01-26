-- После добавления маршрута удваивать цены для маршрутов, следующих между данными городами
create or replace function after_insert()
returns trigger
as $$
begin
	update routes
	set cost = cost * 2 + 1
    where (city1 = new.city1 and city2 = new.city2) or 
          (city1 = new.city2 and city2 = new.city1);
    return new;
end $$
language plpgsql;

create or replace trigger upd_aft
    after insert on routes
    for each row 
    execute procedure after_insert();
   
delete from routes
where id > 1000;
   
insert into routes values(1001, 'A', 'B', 999, true);

select *
from routes
where (city1 = 'A' and city2 = 'B') or 
      (city1 = 'B' and city2 = 'A');