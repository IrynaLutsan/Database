WITH AllObjectAlerts AS (
    SELECT
        z.object_id AS id
    FROM
        sensor_notifications sn
    JOIN
        sensors s ON sn.sensor_id = s.id
    JOIN
        rooms r ON s.room_id = r.id
    JOIN
        zones z ON r.zone_id = z.id

    UNION ALL 
    
    SELECT
        sn.object_id AS id
    FROM
        system_notifications sn
)
SELECT
    o.` name` AS object_name, 
    COUNT(a.id) AS total_alerts
FROM
    AllObjectAlerts a
JOIN
    objects o ON a.id = o.id
GROUP BY
    o.id, o.` name`
ORDER BY
    total_alerts DESC
LIMIT 1;