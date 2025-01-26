drop table if exists tmp_json_models;

create table tmp_json_models (
	id int primary key,
    info json
);

insert into tmp_json_models values
    (1, '{"name" : "810-69", "version" : 0, "characteristics" : {"places" : 50, "speed" : 60}}'),
    (2, '{"name" : "810-69", "version" : 1, "characteristics" : {"places" : 60, "speed" : 70}}'),
    (3, '{"name" : "810-98", "characteristics" : {"places" : 100, "speed" :80}}'),
    (4, '{"name" : "810-01", "characteristics" : {"places" : 50, "speed" : 100}}'),
    (5, '{"name" : "810-69", "version" : 2, "characteristics" : {"places" : 70, "speed" : 80}}');
    
select * from tmp_json_models;
