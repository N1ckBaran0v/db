-- Для каждого города , средний год начала работы не закрытых заводов в котором выше среднего в целом, 
-- получить количество не закрытых заводов, средний год их начала работы, год последнего открытого завода
SELECT city, count(*) as cnt, round(avg(start_year)) as avg_start_year, max(start_year) as max_start_year
FROM production p
where p.end_year is null
GROUP BY city
having avg(start_year) > (select avg(start_year) as avgsy
                          from production p2
                          where p2.end_year is null)     
order by city;