select to_json(t) 
from trains t;

-- copy (SELECT TO_JSON(t) from trains t) to '/usr/local/postgres/trains.json';
-- \copy (SELECT TO_JSON(t) from trains t) to '/usr/local/postgres/trains.json'

select to_json(m)
from models m;

-- copy (SELECT TO_JSON(m) from models m) to '/usr/local/postgres/models.json';
-- \copy (SELECT TO_JSON(m) from models m) to '/usr/local/postgres/models.json'

select to_json(p)
from production p; 

-- copy (SELECT TO_JSON(p) from production p) to '/usr/local/postgres/production.json';
-- \copy (SELECT TO_JSON(p) from production p) to '/usr/local/postgres/production.json'

select to_json(r)
from routes r;

-- copy (SELECT TO_JSON(r) from routes r) to '/usr/local/postgres/routes.json';
-- \copy (SELECT TO_JSON(r) from routes r) to '/usr/local/postgres/routes.json'

select to_json(s)
from service s; 

-- copy (SELECT TO_JSON(rs) from service s) to '/usr/local/postgres/service.json';
-- \copy (SELECT TO_JSON(rs) from service s) to '/usr/local/postgres/service.json'

