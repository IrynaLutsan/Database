SELECT
    p.maker,
    CASE
        -- Перевіряємо, чи виробник має хоча б одну модель типу 'pc'
        WHEN EXISTS (
            SELECT 1
            FROM Product AS p_pc
            WHERE p_pc.maker = p.maker AND p_pc.type = 'pc'
        ) THEN
            -- Якщо виробляє ('yes'), підраховуємо кількість наявних ПК
            CONCAT(
                'yes(',
                (
                    SELECT COUNT(T2.model)
                    FROM Product AS T1
                    INNER JOIN PC AS T2 ON T1.model = T2.model
                    WHERE T1.maker = p.maker AND T1.type = 'pc'
                ),
                ')'
            )
        ELSE
            -- Якщо не виробляє
            'no'
    END AS pc
FROM
    Product AS p
GROUP BY
    p.maker;