-- После добавления маршрута удваивать цены для маршрутов, следующих между данными городами
create or replace function after_insert_py()
returns trigger
as $$
	new_inf = TD["new"]
	query = f'''update routes
set cost = cost * 2 + 1 
where (city1 = '{new_inf["city1"]}' and city2 = '{new_inf["city2"]}') or 
	  (city1 = '{new_inf["city2"]}' and city2 = '{new_inf["city1"]}');'''
	plpy.execute(query)
	plpy.notice("Мы таки решили поднять цены на все маршруты между " + \
    f'{new_inf["city1"]} и {new_inf["city2"]}.')
$$
language plpython3u;

create or replace trigger upd_aft_py
    after insert on routes
    for each row 
    execute procedure after_insert_py();
   
insert into routes values((select max(id) from routes) + 1, 'A', 'B', 999, true);

select *
from routes
where (city1 = 'A' and city2 = 'B') or 
      (city1 = 'B' and city2 = 'A');