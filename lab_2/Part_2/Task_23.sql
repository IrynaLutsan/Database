SELECT
    u.full_name AS user_name,
    COUNT(DISTINCT z.id) AS zones_count
FROM
    users u
JOIN
    user_object_access uoa ON u.id = uoa.user_id
JOIN
    zones z ON uoa.object_id = z.object_id 
GROUP BY
    u.id, u.full_name
HAVING
    COUNT(DISTINCT z.id) > 5
ORDER BY
    zones_count DESC;