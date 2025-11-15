SELECT
    z.object_id,
    COUNT(r_corridor.id) AS corridor_count
FROM
    rooms r_corridor
JOIN
    zones z ON r_corridor.zone_id = z.id
WHERE
    r_corridor.room_type = 'Corridor'
GROUP BY
    z.object_id
HAVING
    COUNT(r_corridor.id) = 1;
    
