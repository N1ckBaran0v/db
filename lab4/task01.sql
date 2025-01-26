-- Найти цену для маршрута по id
create or replace function get_cost_py(rid int)
returns int as
$$
    query = f"select cost from routes where id = {rid};"
    res = plpy.execute(query)
    ans = -1
    if res:
    	ans = res[0]["cost"]
    return ans
$$
language plpython3u;

select 666 as id, get_cost_py(666) as curr_cost;
