SELECT
    p.maker
FROM
    Product p
LEFT JOIN
    PC ON p.model = PC.model
WHERE
    p.type = 'pc'
GROUP BY
    p.maker
HAVING
    COUNT(p.model) > COUNT(PC.model);