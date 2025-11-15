SELECT
    T1.ship,
    (   -- Підзапит в якості обчислювального стовпця для отримання країни
        SELECT
            T3.country
        FROM
            Ships T2
        INNER JOIN
            Classes T3 ON T2.class = T3.class
        WHERE
            T2.name = T1.ship
    ) AS country
FROM
    Outcomes T1
WHERE
    T1.result = 'sunk'
    AND (
        SELECT
            T3.country
        FROM
            Ships T2
        INNER JOIN
            Classes T3 ON T2.class = T3.class
        WHERE
            T2.name = T1.ship
    ) IS NOT NULL; -- Перевірка на NULL: хоча 'country' у Classes зазвичай NOT NULL,
                   -- ця перевірка гарантує, що запис про країну знайдено.