-- Ищем все поезда, которые были произведены между 2003 и 2008 годом
SELECT *
from trains t 
where t.prod_year between 2003 and 2008;