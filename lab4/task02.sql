-- Найти максимальную цену среди маршрутов
create or replace function max_cost_py()
returns int as
$$
    query = "select max(cost) as mxcost \
             from routes;"
    res = plpy.execute(query)
    ans = -1
    if res:
    	ans = res[0]["mxcost"]
    return ans
$$
language plpython3u;

explain analyse
select max_cost_py() as max_cost;