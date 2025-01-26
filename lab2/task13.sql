-- Ищем заводы, выпустившие больше всего поездов для маршрутов с билетами дешевле 750.
select name, city, cnt
from production p join (select t.produced, count(*) as cnt
                        from trains t join (select t2.route, max(t2.id) as mid
                                            from trains t2
                                            where t2.route in (select r.id
                                                               from routes r
                                                               where r.cost < 750)
                                            group by t2.route) as od2 on t.route = od2.route and od2.mid = t.id
                        group by t.produced) as od on p.id = od.produced
order by cnt desc;
