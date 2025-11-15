SELECT DISTINCT
    T2.maker
FROM
    PC AS T1
INNER JOIN
    Product AS T2 ON T1.model = T2.model
WHERE
    T1.speed >= 600;