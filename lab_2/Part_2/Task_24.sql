SELECT
    o.` name` AS object_name,    
    z.name AS zone_name,         
    r.name AS room_name,         
    s.name AS sensor_name,       
    st.name AS sensor_type,      
    ss.parameter_name,           
    ss.parameter_value           
FROM
    sensors s
JOIN
    sensor_types st ON s.sensor_type_id = st.id
JOIN
    rooms r ON s.room_id = r.id
JOIN
    zones z ON r.zone_id = z.id
JOIN
    objects o ON z.object_id = o.id
LEFT JOIN
    sensor_settings ss ON s.id = ss.sensor_id 
ORDER BY
    o.` name`, z.name, r.name, s.name;