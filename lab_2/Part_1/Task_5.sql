SELECT DISTINCT
    T1.maker
FROM
    Product AS T1
WHERE
    T1.type = 'PC' 
    AND
    EXISTS (
        SELECT
            *
        FROM
            PC AS P_Inner
        WHERE
            P_Inner.model = T1.model    
		)
