drop table if exists tmp_models;

create table tmp_models (
	id int,
    name text,
    version int,
    places int,
    speed int
);

ALTER TABLE tmp_models
    ADD CONSTRAINT pk_tmp_models        PRIMARY KEY(id),
    add CONSTRAINT nn_name          CHECK(name IS NOT NULL),
    add CONSTRAINT nn_version       CHECK(version IS NOT NULL),
    add CONSTRAINT check_version    CHECK(version >= 0),
    add CONSTRAINT nn_places        CHECK(places IS NOT NULL),
    add CONSTRAINT check_places     CHECK(places > 0),
    add CONSTRAINT nn_speed         CHECK(speed IS NOT NULL),
    add CONSTRAINT check_speed      CHECK(speed > 0);
   
drop table if exists tmp_import_models;
    
create table tmp_import_models (
	tmp json
);

copy tmp_import_models from '/usr/local/postgres/models.json';

insert into tmp_models
select (tmp->>'id')::int,
       (tmp->>'name')::text,
       (tmp->>'version')::int,
       (tmp->>'places')::int,
       (tmp->>'speed')::int
from tmp_import_models;

select * from tmp_models;