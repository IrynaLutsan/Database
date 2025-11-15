SELECT
    p.type,
    t.model,
    MAX(t.price) AS max_price
FROM
    Product p
INNER JOIN
    (
        -- Блок UNION: Об'єднання всіх моделей і їхніх цін з різних таблиць
        SELECT model, price FROM PC
        UNION ALL
        SELECT model, price FROM Laptop
        UNION ALL
        SELECT model, price FROM Printer
    ) AS t ON p.model = t.model
GROUP BY
    p.type, t.model;