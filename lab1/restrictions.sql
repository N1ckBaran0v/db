ALTER TABLE Models
    ADD CONSTRAINT pk_models        PRIMARY KEY(id),
    add CONSTRAINT nn_name          CHECK(name IS NOT NULL),
    add CONSTRAINT nn_version       CHECK(version IS NOT NULL),
    add CONSTRAINT check_version    CHECK(version >= 0),
    add CONSTRAINT nn_places        CHECK(places IS NOT NULL),
    add CONSTRAINT check_places     CHECK(places > 0),
    add CONSTRAINT nn_speed         CHECK(speed IS NOT NULL),
    add CONSTRAINT check_speed      CHECK(speed > 0);

ALTER TABLE Production
    ADD CONSTRAINT pk_production    PRIMARY KEY(id),
    add CONSTRAINT nn_name          CHECK(name IS NOT NULL),
    add CONSTRAINT nn_city          CHECK(city IS NOT NULL),
    add CONSTRAINT nn_start_year    CHECK(start_year IS NOT NULL),
    add CONSTRAINT check_start_year CHECK(start_year >= 1950 and start_year < 2024),
    add CONSTRAINT check_end_year_1 CHECK(end_year IS NULL OR end_year >= start_year),
    add CONSTRAINT check_end_year_2 CHECK(end_year IS NULL OR end_year < 2024);

ALTER TABLE Routes
    ADD CONSTRAINT pk_routes        PRIMARY KEY(id),
    ADD CONSTRAINT nn_city1         CHECK(city1 IS NOT NULL),
    ADD CONSTRAINT nn_city2         CHECK(city2 IS NOT NULL),
    ADD CONSTRAINT nn_cost          CHECK(cost IS NOT NULL),
    ADD CONSTRAINT check_cost       CHECK(cost >= 0),
    ADD CONSTRAINT nn_is_active     CHECK(is_active IS NOT NULL);

ALTER TABLE Service
    ADD CONSTRAINT pk_SERVICE       PRIMARY KEY(id),
    ADD CONSTRAINT nn_name         CHECK(name IS NOT NULL),
    ADD CONSTRAINT nn_city          CHECK(city IS NOT NULL),
    ADD CONSTRAINT nn_start_year    CHECK(start_year IS NOT NULL),
    ADD CONSTRAINT check_start_year CHECK(start_year >= 1950 and start_year < 2024),
    add CONSTRAINT check_end_year_1 CHECK(end_year IS NULL OR end_year >= start_year),
    add CONSTRAINT check_end_year_2 CHECK(end_year IS NULL OR end_year < 2024);
   
create or replace function get_field_int(tname text, fname text, cid int)
returns int
as $$
declare 
    command text;
    res int;
begin
    command = 'select ' || tname || '.' || fname || 
              ' from ' || tname ||  
              ' where ' || tname || '.id = '|| to_char(cid, '99999') || ';';
    execute command into res;
    return res;
end $$
language plpgsql;

ALTER TABLE Trains
    ADD CONSTRAINT pk_trains        PRIMARY KEY(id),
    add CONSTRAINT check_prd_year_1 CHECK(prod_year >= 1950 and prod_year < 2024),
    ADD CONSTRAINT fk_model         FOREIGN KEY(model)    REFERENCES Models(id)     ON DELETE CASCADE,
    ADD CONSTRAINT fk_produced      FOREIGN KEY(produced) REFERENCES Production(id) ON DELETE cascade,
    ADD CONSTRAINT fk_route         FOREIGN KEY(route)    REFERENCES Routes(id)     ON DELETE CASCADE,
    ADD CONSTRAINT fk_serve         FOREIGN KEY(serve)    REFERENCES Service(id)    ON DELETE CASCADE,
    add CONSTRAINT check_prd_year_2 CHECK(prod_year >= get_field_int('production', 'start_year', produced)),
    add CONSTRAINT check_prd_year_3 CHECK(get_field_int('production', 'end_year', produced) is null or 
                                          prod_year <= get_field_int('production', 'end_year', produced)),
    add CONSTRAINT check_prd_year_4 CHECK(prod_year >= get_field_int('service', 'start_year', serve)),
    add CONSTRAINT check_prd_year_5 CHECK(get_field_int('service', 'end_year', serve) is null or 
                                          prod_year <= get_field_int('service', 'end_year', serve)),
    ADD constraint check_status        CHECK(status in ('Действует', 'В ремонте', 'Снят с эксплуатации'));
