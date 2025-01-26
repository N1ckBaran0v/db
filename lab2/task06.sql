-- Ищем все заводы, для которых все созданные поезда приписаны к депо, которые созданы либо позже завода, либо в тот же год
SELECT *
from production p 
WHERE p.start_year <= all(select s.start_year
                          from trains t join service s on (t.serve = s.id) 
                          where t.produced = p.id);