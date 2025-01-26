-- Усреднить цены для поездов, которые имеют конечную в городе B.
UPDATE routes
SET cost = (SELECT round(avg(cost))
            from routes
            WHERE city1 = 'B' OR city2 = 'B')
WHERE city1 = 'B' OR city2 = 'B';