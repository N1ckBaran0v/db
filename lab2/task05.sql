-- Ищем все модели, для которых нет информации об активных поездах
SELECT *
from models m 
WHERE NOT exists (select t.id
                  from trains t                
                  where t.model = m.id and t.status != 'Снят с эксплуатации');