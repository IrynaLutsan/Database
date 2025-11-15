SELECT
    o.` name` AS object_name, 
    COUNT(s.id) AS sensor_count
FROM
    objects o
JOIN
    zones z ON o.id = z.object_id
JOIN
    rooms r ON z.id = r.zone_id
LEFT JOIN
    sensors s ON r.id = s.room_id
GROUP BY
    o.id, o.` name`
ORDER BY
    sensor_count DESC
LIMIT 1;