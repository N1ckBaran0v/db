-- Для каждого города получить количество не закрытых заводов, средний год их начала работы, год последнего открытого завода
SELECT city, count(*) as cnt, round(avg(start_year)) as avg_start_year, max(start_year) as max_start_year
FROM production p
where p.end_year is null
GROUP BY city
order by city;