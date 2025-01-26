-- Ищем все заводы, имеющие двузначный номер, последняя цифра которого 3
SELECT *
from production p
WHERE p."name" like '% №_3';