CREATE DATABASE  IF NOT EXISTS `Security_system`;
USE `Security_system`;

DROP TABLE IF EXISTS `notification_settings`;
DROP TABLE IF EXISTS `system_notifications`;
DROP TABLE IF EXISTS `user_object_access`;
DROP TABLE IF EXISTS `sensor_settings`;
DROP TABLE IF EXISTS `sensor_notifications`;
DROP TABLE IF EXISTS `sensors`;
DROP TABLE IF EXISTS `rooms`;
DROP TABLE IF EXISTS `zones`;
DROP TABLE IF EXISTS `objects`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `sensor_types`;

CREATE TABLE `sensor_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(150) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(45) NOT NULL UNIQUE,
    `email` VARCHAR(87) NOT NULL UNIQUE,
    `password_hash` VARCHAR(45) NOT NULL,
    `full_name` VARCHAR(160) NOT NULL,
    `phone` VARCHAR(30) NOT NULL,
    `role` VARCHAR(60) DEFAULT 'user',
    `is_active` TINYINT DEFAULT 1,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `objects` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `address` VARCHAR(45) NOT NULL,
    `description` VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `zones` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `object_id` INT NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `description` VARCHAR(100) DEFAULT NULL,
    `access_level` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `object_id_idx` (`object_id`),
    CONSTRAINT `fk_4` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `rooms` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `zone_id` INT NOT NULL,
    `name` VARCHAR(70) NOT NULL,
    `room_type` VARCHAR(45) DEFAULT NULL,
    `floor_number` INT NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `zone_id_idx` (`zone_id`),
    CONSTRAINT `fk_5` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sensors` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `sensor_type_id` INT NOT NULL,
    `room_id` INT NOT NULL,
    `name` VARCHAR(30) NOT NULL,
    `last_maintenance` DATE DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `sensor_type_id_idx` (`sensor_type_id`),
    KEY `room_id_idx` (`room_id`),
    CONSTRAINT `fk_0` FOREIGN KEY (`sensor_type_id`) REFERENCES `sensor_types` (`id`),
    CONSTRAINT `fk_9` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sensor_settings` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `sensor_id` INT NOT NULL,
    `parameter_name` VARCHAR(45) NOT NULL,
    `parameter_value` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `sensor_id_idx` (`sensor_id`),
    CONSTRAINT `fk_12` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sensor_notifications` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `sensor_id` INT NOT NULL,
    `notification_type` VARCHAR(45) NOT NULL,
    `severity` INT NOT NULL,
    `message` VARCHAR(100) NOT NULL,
    `created` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `sensor_id_idx` (`sensor_id`),
    KEY `created_1` (`created`),
    CONSTRAINT `fk_2` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user_object_access` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `object_id` INT NOT NULL,
    `access_level` INT DEFAULT 1,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_user_object` (`user_id`, `object_id`), -- Додано унікальний ключ
    KEY `object_id_idx` (`object_id`),
    CONSTRAINT `fk_7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `fk_8` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notification_settings` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `object_id` INT NOT NULL,
    `notification_type` VARCHAR(50) NOT NULL,
    `delivery_method` VARCHAR(45) NOT NULL,
    `is_enabled` TINYINT NOT NULL,
    `min_severity` INT NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_user_object_type` (`user_id`, `object_id`, `notification_type`), -- Додано унікальний ключ
    KEY `object_id_idx` (`object_id`),
    CONSTRAINT `fk_10` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    CONSTRAINT `fk_11` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `system_notifications` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `object_id` INT NOT NULL,
    `title` VARCHAR(45) NOT NULL,
    `message` VARCHAR(45) NOT NULL,
    `notification_type` VARCHAR(45) NOT NULL,
    `severity` INT NOT NULL,
    `delivery_method` VARCHAR(45) DEFAULT NULL,
    `delivery_status` VARCHAR(45) DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `created` (`created_at`),
    KEY `user_id_idx` (`user_id`),
    KEY `object_id_idx` (`object_id`),
    CONSTRAINT `fk_13` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    CONSTRAINT `fk_14` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET SQL_SAFE_UPDATES = 0;	-- Дозволити масові операції (наприклад, TRUNCATE)

SET FOREIGN_KEY_CHECKS = 0;	-- Дозволити видалення/очищення таблиць, незалежно від зовнішніх ключів

-- Clean up all tables in the correct dependency order
TRUNCATE TABLE sensor_settings;
TRUNCATE TABLE sensor_notifications;
TRUNCATE TABLE notification_settings;
TRUNCATE TABLE system_notifications;
TRUNCATE TABLE user_object_access;
TRUNCATE TABLE sensors;
TRUNCATE TABLE rooms;
TRUNCATE TABLE zones;
TRUNCATE TABLE objects;
TRUNCATE TABLE users;
TRUNCATE TABLE sensor_types;

SET FOREIGN_KEY_CHECKS = 1;	-- Ввімкнути перевірку ключів назад!


-- ***************************************************************
-- Insertion of UNIQUE Data
-- ***************************************************************

-- --------------------------
-- users 
-- --------------------------
INSERT INTO users (username, email, password_hash, full_name, phone, role, is_active)
VALUES
('admin01', 'admin01@mail.com', 'hash123', 'John Smith', '+380501112233', 'admin', 1),
('operator01', 'op01@mail.com', 'hash124', 'Alice Johnson', '+380502223344', 'operator', 1),
('user01', 'user01@mail.com', 'hash125', 'Bob Brown', '+380503334455', 'user', 1),
('user02', 'user02@mail.com', 'hash126', 'Charlie Davis', '+380504445566', 'user', 0),
('user03', 'user03@mail.com', 'hash127', 'Eva Green', '+380505556677', 'user', 1),
('operator02', 'op02@mail.com', 'hash128', 'Michael White', '+380506667788', 'operator', 1),
('admin02', 'admin02@mail.com', 'hash129', 'Sarah Parker', '+380507778899', 'admin', 1),
('user04', 'user04@mail.com', 'hash130', 'David Lee', '+380501010101', 'user', 1),
('operator03', 'op03@mail.com', 'hash131', 'Sophia Martinez', '+380502020202', 'operator', 1),
('user05', 'user05@mail.com', 'hash132', 'Chris Clark', '+380503030303', 'user', 1),
('user06', 'user06@mail.com', 'hash133', 'Olivia Hall', '+380504040404', 'user', 1),
('admin03', 'admin03@mail.com', 'hash134', 'James Wilson', '+380505050505', 'admin', 0),
('user07', 'user07@mail.com', 'hash135', 'Emma Scott', '+380506060606', 'user', 1),
('operator04', 'op04@mail.com', 'hash136', 'Noah King', '+380507070707', 'operator', 1),
('user08', 'user08@mail.com', 'hash137', 'Ava Rodriguez', '+380508080808', 'user', 1)
AS new_data
ON DUPLICATE KEY UPDATE full_name = new_data.full_name;

-- --------------------------
-- objects (Parental table)
-- --------------------------
INSERT INTO objects (`name`, address, description) VALUES
('Office A', 'Kyiv, Shevchenko 10', 'Head office'), -- ID 1
('Warehouse B', 'Lviv, Franka 22', 'Storage facility'), -- ID 2
('Factory C', 'Dnipro, Haharina 101', 'Production plant'), -- ID 3
('Data Center D', 'Kharkiv, Sumska 55', 'Critical IT infrastructure'), -- ID 4
('Store E', 'Odesa, Deribasivska 12', 'Retail store'), -- ID 5
('Office F', 'Rivne, Peremohy 5', 'Branch office'), -- ID 6
('Warehouse G', 'Zhytomyr, Kyivska 150', 'Distribution center'), -- ID 7
('Factory H', 'Poltava, Soborna 20', 'Processing plant'), -- ID 8
('Store I', 'Cherkasy, Khreshchatyk 5', 'Flagship retail'), -- ID 9
('Office J', 'Vinnytsia, Kozmonavtiv 40', 'Regional management') -- ID 10
AS new_data
ON DUPLICATE KEY UPDATE address = new_data.address;

-- --------------------------
-- sensor_types (Parental table)
-- --------------------------
INSERT INTO sensor_types (name, description) VALUES
('Motion Sensor', 'Detects movements'), -- ID 1
('Smoke Detector', 'Detects smoke and fire'), -- ID 2
('Temperature Sensor', 'Monitors temperature'), -- ID 3
('Access Card Reader', 'Controls access with cards'), -- ID 4
('CCTV Camera', 'Video surveillance'), -- ID 5
('Gas Sensor', 'Detects hazardous gases'), -- ID 6
('Glass Break Sensor', 'Detects window breakage'), -- ID 7
('Humidity Sensor', 'Measures air humidity'), -- ID 8
('Door Contact', 'Detects door opening/closing'), -- ID 9
('Vibration Sensor', 'Detects physical impacts') -- ID 10
AS new_data
ON DUPLICATE KEY UPDATE description = new_data.description;


-- --------------------------
-- Setting the data insertion sequence (Intermediate tables)
-- --------------------------

-- --------------------------
-- zones (Depends on the object)
-- --------------------------
INSERT INTO zones (object_id, name, description, access_level) VALUES
(1, 'Reception', 'Main entrance zone', 1), 
(1, 'Server Room', 'Critical servers', 5), 
(1, 'Office Floor 2', 'General working area', 2), 
(2, 'Loading Dock', 'Cargo zone', 2), 
(2, 'Storage Hall', 'Warehouse main area', 3), 
(3, 'Production Line 1', 'Assembly area', 2),
(3, 'Production Line 2', 'Packaging area', 2), 
(4, 'Control Room', 'Network monitoring', 5), 
(4, 'Server Farm A', 'Primary server racks', 5), 
(5, 'Sales Floor', 'Open area for customers', 1), 
(6, 'Meeting Rooms', 'Conference facilities', 2), 
(7, 'Exterior Perimeter', 'Outdoor security', 4), 
(8, 'Boiler Room', 'Utility area', 4), 
(9, 'Changing Rooms', 'Staff facilities', 1), 
(10, 'IT Closet', 'Network equipment', 5) 
AS new_data
ON DUPLICATE KEY UPDATE description = new_data.description;

-- --------------------------
-- rooms (Depends on the zone)
-- --------------------------
INSERT INTO rooms (zone_id, name, room_type, floor_number) VALUES
(1, 'Reception Desk', 'Office', 1), -- Z1 (O1)
(1, 'Waiting Area', 'Lobby', 1), -- Z1 (O1)
(2, 'Server Rack A', 'Server', -1), -- Z2 (O1)
(3, 'Meeting Room 201', 'Conference', 2), -- Z3 (O1)
(4, 'Dock 1', 'Cargo', 0), -- Z4 (O2)
(5, 'Storage A1', 'Warehouse', 1), -- Z5 (O2)
(6, 'Assembly Hall A', 'Industrial', 2), -- Z6 (O3)
(7, 'Packaging Hall B', 'Industrial', 2), -- Z7 (O3)
(8, 'Network Desk', 'Office', 1), -- Z8 (O4)
(9, 'Server Rack 101', 'Server', 1), -- Z9 (O4)
(10, 'Cashier Area', 'Retail', 1), -- Z10 (O5)
(11, 'Board Room', 'Conference', 3), -- Z11 (O6)
(12, 'Loading Gate 3', 'Outdoor', 0), -- Z12 (O7)
(13, 'Boiler Unit 1', 'Utility', -1), -- Z13 (O8)
(15, 'Rack 1', 'Server', 1); -- Z15 (O10)


-- --------------------------
-- sensors (Depends on the sensor_types, rooms)
-- --------------------------
INSERT INTO sensors (sensor_type_id, room_id, name, last_maintenance) VALUES
(1, 1, 'M-REC-01', '2025-01-10'), -- Motion (Room 1)
(4, 1, 'R-REC-01', '2025-01-20'), -- Reader (Room 1)
(2, 3, 'S-SRV-01', '2025-02-15'), -- Smoke (Room 3)
(3, 4, 'T-SRV-02', '2025-03-01'), -- Temp (Room 4)
(5, 2, 'CCTV-LOBBY', '2025-04-01'), -- CCTV (Room 2)
(3, 5, 'T-DOCK-01', '2025-03-01'), -- Temp (Room 5)
(6, 6, 'G-STORAGE-01', '2025-02-25'), -- Gas (Room 6)
(1, 7, 'M-STORAGE-02', '2025-03-05'), -- Motion (Room 7)
(2, 8, 'S-NET-01', '2025-02-10'), -- Smoke (Room 8)
(3, 9, 'T-SRVRACK-01', '2025-03-22'), -- Temp (Room 9)
(7, 10, 'GBS-CASH-01', '2025-03-18'), -- Glass Break (Room 10)
(8, 11, 'H-BOARD-01', '2025-04-10'), -- Humidity (Room 11)
(9, 12, 'DC-GATE-03', '2025-04-15'), -- Door Contact (Room 12)
(10, 13, 'V-BOILER-01', '2025-04-20'), -- Vibration (Room 13)
(3, 15, 'T-IT-01', '2025-03-01'), -- Temp (Room 15)
(5, 15, 'CCTV-IT-01', '2025-04-01'); -- CCTV (Room 15)


-- --------------------------
-- Setting the data insertion sequence (End/Child tables)
-- --------------------------

-- --------------------------
-- user_object_access (Depends on the users, objects)
-- --------------------------
INSERT INTO user_object_access (user_id, object_id, access_level) VALUES
(1, 1, 5), (1, 2, 5), (1, 3, 5), (1, 4, 5), (1, 5, 5), -- admin01 (5 об'єктів)
(2, 1, 3), (2, 4, 3), (2, 6, 3), (2, 7, 3), -- operator01 (4 об'єкти)
(6, 3, 3), (6, 8, 3), -- operator02 (2 об'єкти)
(3, 9, 1) -- user01 (1 об'єкт)
AS new_data
ON DUPLICATE KEY UPDATE access_level = new_data.access_level;

-- --------------------------
-- sensor_settings (Depends on the sensors)
-- --------------------------
INSERT INTO sensor_settings (sensor_id, parameter_name, parameter_value) VALUES
(3, 'Max_Temp', '30.0C'), -- S-SRV-01 (Smoke)
(3, 'Min_Temp', '15.0C'),
(5, 'Recording_FPS', '30'), -- CCTV-LOBBY (CCTV)
(6, 'Gas_Type', 'Methane'), -- G-STORAGE-01 (Gas)
(9, 'Smoke_Threshold', '40ppm'), -- S-NET-01 (Smoke)
(1, 'Sensitivity', 'High'), -- M-REC-01 (Motion)
(10, 'Polling_Rate', '10s'), -- T-SRVRACK-01 (Temp)
(12, 'Duration_Sec', '5'), -- DC-GATE-03 (Door Contact)
(13, 'Frequency_Hz', '20'), -- V-BOILER-01 (Vibration)
(15, 'Offset_C', '2.5') -- T-IT-01 (Temp)
AS new_data
ON DUPLICATE KEY UPDATE parameter_value = new_data.parameter_value;

-- --------------------------
-- sensor_notifications (Depends on the sensors)
-- --------------------------
INSERT INTO sensor_notifications (sensor_id, notification_type, `severity`, message) VALUES
(1, 'Movement', 2, 'Motion detected at reception'),
(2, 'Smoke alarm', 5, 'Smoke detected near servers'),
(3, 'Temperature', 3, 'High temp at Dock 1'),
(4, 'Access denied', 2, 'Invalid card swipe'),
(5, 'Camera alert', 1, 'CCTV offline temporarily'),
(6, 'Gas Leak', 5, 'Critical Gas Leak in Storage'),
(7, 'Movement', 3, 'Intruder in Warehouse Hall'),
(8, 'Smoke alarm', 4, 'Smoke detected in Control Room'),
(9, 'High Temp', 5, 'Server Rack Overheating!'),
(10, 'Glass Break', 4, 'Window shattered at Cashier Area'),
(11, 'Humidity High', 2, 'High humidity in Board Room'),
(12, 'Door forced', 5, 'Loading Gate 3 Forced Open'),
(13, 'Vibration', 3, 'Suspicious vibration in Boiler Room'),
(9, 'High Temp', 5, 'Server Rack Overheating!'), 
(10, 'Glass Break', 4, 'Window shattered at Cashier Area')
AS new_data
ON DUPLICATE KEY UPDATE message = new_data.message;


-- --------------------------
-- system_notifications (Depends on the users, objects)
-- --------------------------
INSERT INTO system_notifications (user_id, object_id, `title`, message, notification_type, severity) VALUES
(1, 4, 'Power Loss', 'Main power failure', 'Alarm', 5),
(2, 4, 'Network Down', 'Core switch offline', 'Alarm', 5),
(6, 4, 'UPS Warning', 'Battery level low', 'Warning', 3),
(1, 1, 'Server Critical', 'Database connection lost', 'Alarm', 5),
(6, 1, 'Config Change', 'Access levels modified', 'Info', 1),
(7, 5, 'Door Jammed', 'Store E entrance blocked', 'Alarm', 4),
(1, 7, 'System Update', 'Software updated successfully', 'Info', 1),
(8, 8, 'Maintenance', 'Scheduled maintenance started', 'Info', 2),
(9, 9, 'Log Overflow', 'Security logs exceeded capacity', 'Warning', 3),
(10, 10, 'User Added', 'New user account created', 'Info', 1)
AS new_data
ON DUPLICATE KEY UPDATE message = new_data.message;

-- --------------------------
-- notification_settings (Depends on the users, objects)
-- --------------------------
INSERT INTO notification_settings (user_id, object_id, notification_type, delivery_method, is_enabled, min_severity) VALUES
(1, 1, 'Alarm', 'Email', 1, 5),
(1, 4, 'Warning', 'SMS', 1, 3),
(2, 2, 'All', 'Push', 1, 1),
(3, 3, 'Alarm', 'Email', 0, 4),
(6, 4, 'System', 'Push', 1, 2),
(7, 5, 'Info', 'Email', 1, 1),
(4, 1, 'Movement', 'SMS', 1, 2),
(5, 7, 'Smoke', 'Email', 1, 3),
(8, 8, 'Gas Leak', 'Push', 1, 5),
(9, 9, 'Access', 'SMS', 0, 1)
AS new_data
ON DUPLICATE KEY UPDATE is_enabled = new_data.is_enabled;
