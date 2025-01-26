-- Удалить поезда, у которых закрылись заводы.
delete from trains 
where produced in (select id
                   from production
                   where end_year is not null);