SELECT
    T1.model,
    T1.speed,
    T1.hd
FROM
    PC AS T1
INNER JOIN
    Product AS T2 ON T1.model = T2.model
WHERE
    T2.maker = 'A'
    AND T1.hd IN (10, 20) 
ORDER BY
    T1.speed ASC;