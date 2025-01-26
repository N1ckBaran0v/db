-- Увеличить цены для поездов, которые имеют конечную в городе A, на 500.
UPDATE routes
SET cost = cost * 2
WHERE city1 = 'A' OR city2 = 'A';