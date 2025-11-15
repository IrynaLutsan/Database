SELECT DISTINCT
    T1.maker
FROM
    Product AS T1
LEFT JOIN
    PC AS T2 ON T1.model = T2.model
WHERE
    T2.model IS NULL
    AND T1.type = 'PC'; -- Додано для фільтрації, якщо в таблиці Product є інші типи продуктів (наприклад, 'laptop', 'printer').