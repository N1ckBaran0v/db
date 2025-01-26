-- 1

select id, info->'characteristics' as chars
from tmp_json_models;

-- 2

select id, info->'name' as name, info->'version' as version,
           info->'characteristics'->'places' as places,
           info->'characteristics'->'speed' as speed
from tmp_json_models;

-- 3

select id, info->'name' as name, info->'version' as version
from tmp_json_models 
where info::jsonb ? 'version';

-- 4

update tmp_json_models 
set info = jsonb_set(info::jsonb, '{version}'::text[], '0'::jsonb)::json
where id = 4;

select *
from tmp_json_models 
where id = 4;

-- 5

insert into tmp_json_models values
    (6, '[{"name" : "810-77"}, {"name" : "811-77"}]');
   
select json_array_elements(info)
from tmp_json_models
where id = 6;    
    
    
    