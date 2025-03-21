use mysqlproject_2;

CREATE TABLE IF NOT EXISTS mysqlproject_2.Transport_Types (
  transport_id INT(11) NOT NULL AUTO_INCREMENT,
  transport_name VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (transport_id)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS mysqlproject_2.Zones (
  zone_id INT(11) NOT NULL AUTO_INCREMENT,
  zone_name VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (zone_id)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS mysqlproject_2.Couriers (
  courier_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NULL DEFAULT NULL,
  phone VARCHAR(45) NULL DEFAULT NULL,
  transport_type INT(11) NULL DEFAULT NULL,
  zone INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (courier_id),
  INDEX fk_transport_idx (transport_type ASC),
  INDEX fk_Zones_idx (zone ASC),
  CONSTRAINT fk_transport FOREIGN KEY (transport_type)
    REFERENCES mysqlproject_2.Transport_Types (transport_id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Zones FOREIGN KEY (zone)
    REFERENCES mysqlproject_2.Zones (zone_id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS mysqlproject_2.Customers (
  customer_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NULL DEFAULT NULL,
  address VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (customer_id)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS mysqlproject_2.Services (
  service_id INT(11) NOT NULL AUTO_INCREMENT,
  service_name VARCHAR(45) NULL DEFAULT NULL,
  price DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (service_id)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS mysqlproject_2.Orders (
  order_id INT(11) NOT NULL AUTO_INCREMENT,
  customer_id INT(11) NULL DEFAULT NULL,
  service_id INT(11) NULL DEFAULT NULL,
  courier_id INT(11) NULL DEFAULT NULL,
  order_date DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  delivery_starts DATETIME NULL DEFAULT NULL,
  delivery_ends DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (order_id),
  INDEX fk_customer_idx (customer_id ASC),
  INDEX fk_service_idx (service_id ASC),
  INDEX fk_courier_idx (courier_id ASC),
  CONSTRAINT fk_customer FOREIGN KEY (customer_id)
    REFERENCES mysqlproject_2.Customers (customer_id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_service FOREIGN KEY (service_id)
    REFERENCES mysqlproject_2.Services (service_id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_courier FOREIGN KEY (courier_id)
    REFERENCES mysqlproject_2.Couriers (courier_id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS mysqlproject_2.Courier_Schedule (
  courier_id INT(11) NULL DEFAULT NULL,
  start_time TIME NULL DEFAULT NULL,
  end_time TIME NULL DEFAULT NULL,
  INDEX fk_courier_sched_idx (courier_id ASC),
  CONSTRAINT fk_courier_sched FOREIGN KEY (courier_id)
    REFERENCES mysqlproject_2.Couriers (courier_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

use mysqlproject_2;
SET FOREIGN_KEY_CHECKS = 0; 
truncate Transport_Types;
truncate Zones;
truncate Couriers;
truncate Services;
truncate Orders;
truncate Courier_Schedule;
truncate Customers;
SET FOREIGN_KEY_CHECKS = 1; 


INSERT INTO mysqlproject_2.Transport_Types (transport_name) VALUES
('Автомобиль'),
('Велосипед'),
('Мотоцикл'),
('СИМ'),
('Скутер'),
('Электрический велосипед');

INSERT INTO mysqlproject_2.Zones (zone_name) VALUES
('ЦАО'),
('ЮВАО'),
('ЗАО'),
('САО'),
('Химки');


INSERT INTO mysqlproject_2.Couriers (name, phone, transport_type, zone) VALUES
('Алексей', '79990001111', 1, 1),
('Дмитрий', '79990002222', 2, 2),
('АНтон', '79990003333', 3, 3),
('Мария', '79990004444', 2, 1),
('Иван', '79990005555', 1, 2),
('Алексей', '79990001111', 1, 1),
('Дмитрий', '79990002222', 2, 2),
('АНтон', '79990003333', 3, 3),
('Мария', '79990004444', 2, 1),
('Иван', '79990005555', 1, 2),
('Светлана', '79990006666', 4, 4),
('Николай', '79990007777', 4, 4),
('Роман', '79990008888', 4, 3),
('Анна', '79990009999', 3, 2),
('Георгий', '79990010000', 4, 1);


INSERT INTO mysqlproject_2.Services (service_name, price) VALUES
('Доставка еды', 500.00),
('Курьерская доставка', 700.00),
('Экспресс-доставка', 1200.00);


INSERT INTO mysqlproject_2.Customers (name, address) VALUES
('Павел', 'ул. Ленина, 5'),
('Ольга', 'ул. Гагарина, 10'),
('Сергей', 'ул. Пушкина, 15'),
('Анна', 'ул. Мира, 20'),
('Дмитрий', 'ул. Садовая, 25'),
('Екатерина', 'ул. Лесная, 30'),
('Александр', 'ул. Центральная, 35'),
('Наталья', 'ул. Молодежная, 40'),
('Игорь', 'ул. Школьная, 45'),
('Татьяна', 'ул. Заречная, 50'),
('Виктор', 'ул. Солнечная, 55'),
('Елена', 'ул. Зеленая, 60'),
('Михаил', 'ул. Речная, 65'),
('Людмила', 'ул. Горная, 70'),
('Андрей', 'ул. Парковая, 75'),
('Светлана', 'ул. Луговая, 80'),
('Николай', 'ул. Вокзальная, 85'),
('Юлия', 'ул. Новая, 90'),
('Владимир', 'ул. Старая, 95'),
('Алексей', 'ул. Северная, 100'),
('Анна', 'пр. Победы, 20'),
('Игорь', 'пер. Чехова, 25'),
('Мария', 'ул. Красная, 30'),
('Светлана', 'пр. Мира, 40'),
('Андрей', 'пер. Чистопрудный, 5'),
('Николай', 'ул. Тверская, 50'),
('Валентина', 'пер. Таганский, 10'),
('Юлия', 'пр. Арбат, 15'),
('Александр', 'ул. Бауманская, 25'),
('Ксения', 'ул. Курская, 30'),
('Ирина', 'пр. Революции, 20'),
('Дмитрий', 'пер. Горького, 18'),
('Марина', 'ул. Жукова, 14'),
('Екатерина', 'ул. Маяковского, 22'),
('Петр', 'пр. Победы, 28'),
('Елена', 'пер. Синопская, 33'),
('Евгений', 'ул. Таганская, 8'),
('Лариса', 'ул. Октябрьская, 6'),
('Федор', 'пер. Лесной, 45'),
('Виктор', 'ул. Светланова, 39'),
('Артем', 'пр. Кузнецкий, 10'),
('Станислав', 'ул. Героев, 16'),
('Олег', 'пер. Полярный, 5'),
('Татьяна', 'ул. Гоголя, 3'),
('Михаил', 'пр. Тульский, 7'),
('Лидия', 'ул. Звездная, 19'),
('Константин', 'пер. 3-й, 25'),
('Александра', 'пр. Свободы, 11'),
('Геннадий', 'пер. Тростниковый, 8'),
('София', 'ул. Михайлова, 4'),
('Яна', 'ул. Брестская, 15'),
('Евгения', 'ул. Вишневая, 30'),
('Анастасия', 'пер. Набережный, 12'),
('Роман', 'ул. Воскресенская, 8'),
('Кирилл', 'пр. Маяк, 13'),
('Денис', 'ул. Петровка, 24'),
('Лилия', 'пр. Тихая, 50'),
('Дмитрий', 'пер. Березовый, 17'),
('Тимур', 'ул. Красный, 25'),
('Наталья', 'пер. Смоленская, 33');


INSERT INTO mysqlproject_2.Orders (customer_id, service_id, courier_id, order_date) VALUES
(1, 1, 1, '2025-03-17 10:00:00'),
(2, 2, 2, '2025-03-17 11:00:00'),
(3, 3, 3, '2025-03-17 12:00:00'),
(4, 1, 4, '2025-03-17 13:00:00'),
(5, 2, 5, '2025-03-17 14:00:00'),
(1, 3, 2, '2025-03-17 15:00:00'),
(2, 1, 3, '2025-03-17 16:00:00'),
(3, 2, 4, '2025-03-17 17:00:00'),
(4, 3, 5, '2025-03-17 18:00:00'),
(5, 1, 1, '2025-03-17 19:00:00'),
(1, 1, 3, '2025-03-17 08:15:00'),
(2, 2, 5, '2025-03-17 09:20:00'),
(3, 3, 7, '2025-03-17 10:30:00'),
(4, 1, 4, '2025-03-17 11:45:00'),
(5, 2, 6, '2025-03-17 13:00:00'),
(6, 3, 2, '2025-03-17 14:15:00'),
(7, 1, 8, '2025-03-17 15:30:00'),
(8, 2, 1, '2025-03-17 16:45:00'),
(9, 3, 9, '2025-03-17 18:00:00'),
(10, 1, 10, '2025-03-17 19:15:00'),
(11, 2, 3, '2025-03-17 20:30:00'),
(12, 3, 5, '2025-03-17 21:45:00'),
(13, 1, 6, '2025-03-18 09:00:00'),
(14, 2, 7, '2025-03-18 10:15:00'),
(15, 3, 4, '2025-03-18 11:30:00'),
(16, 1, 2, '2025-03-18 12:45:00'),
(17, 2, 8, '2025-03-18 14:00:00'),
(18, 3, 1, '2025-03-18 15:15:00'),
(19, 1, 10, '2025-03-18 16:30:00'),
(20, 2, 3, '2025-03-18 17:45:00'),
(21, 3, 5, '2025-03-18 19:00:00'),
(22, 1, 6, '2025-03-18 20:15:00'),
(23, 2, 7, '2025-03-18 21:30:00'),
(24, 3, 4, '2025-03-18 22:45:00'),
(25, 1, 8, '2025-03-19 08:30:00'),
(26, 2, 9, '2025-03-19 09:45:00'),
(27, 3, 1, '2025-03-19 11:00:00'),
(28, 1, 2, '2025-03-19 12:15:00'),
(29, 2, 6, '2025-03-19 13:30:00'),
(30, 3, 7, '2025-03-19 14:45:00'),
(31, 1, 5, '2025-03-19 16:00:00'),
(32, 2, 10, '2025-03-19 17:15:00'),
(33, 3, 3, '2025-03-19 18:30:00'),
(34, 1, 4, '2025-03-19 19:45:00'),
(35, 2, 8, '2025-03-19 21:00:00'),
(36, 3, 9, '2025-03-19 22:15:00'),
(37, 1, 7, '2025-03-20 08:00:00'),
(38, 2, 5, '2025-03-20 09:15:00'),
(39, 3, 4, '2025-03-20 10:30:00'),
(40, 1, 3, '2025-03-20 11:45:00'),
(41, 2, 6, '2025-03-20 13:00:00'),
(42, 3, 1, '2025-03-20 14:15:00'),
(43, 1, 8, '2025-03-20 15:30:00'),
(44, 2, 7, '2025-03-20 16:45:00'),
(45, 3, 9, '2025-03-20 18:00:00'),
(46, 1, 10, '2025-03-20 19:15:00'),
(47, 2, 2, '2025-03-20 20:30:00'),
(48, 3, 3, '2025-03-20 21:45:00'),
(49, 1, 5, '2025-03-21 09:00:00'),
(50, 2, 4, '2025-03-21 10:15:00'),
(1, 3, 8, '2025-03-21 11:30:00'),
(2, 1, 6, '2025-03-21 12:45:00'),
(3, 2, 7, '2025-03-21 14:00:00'),
(4, 3, 5, '2025-03-21 15:15:00'),
(5, 1, 9, '2025-03-21 16:30:00'),
(6, 2, 1, '2025-03-21 17:45:00'),
(7, 3, 10, '2025-03-21 19:00:00'),
(8, 1, 4, '2025-03-21 20:15:00'),
(9, 2, 6, '2025-03-21 21:30:00'),
(10, 3, 3, '2025-03-21 22:45:00'),
(11, 1, 10, '2025-03-22 08:30:00'),
(12, 2, 9, '2025-03-22 09:45:00'),
(13, 3, 5, '2025-03-22 11:00:00'),
(14, 1, 6, '2025-03-22 12:15:00'),
(15, 2, 7, '2025-03-22 13:30:00'),
(16, 3, 8, '2025-03-22 14:45:00'),
(17, 1, 2, '2025-03-22 16:00:00'),
(18, 2, 3, '2025-03-22 17:15:00'),
(19, 3, 10, '2025-03-22 18:30:00'),
(20, 1, 4, '2025-03-22 19:45:00'),
(21, 2, 5, '2025-03-22 21:00:00'),
(22, 3, 9, '2025-03-22 22:15:00'),
(23, 1, 6, '2025-03-23 08:00:00'),
(24, 2, 7, '2025-03-23 09:15:00'),
(25, 3, 1, '2025-03-23 10:30:00'),
(26, 1, 3, '2025-03-23 11:45:00'),
(27, 2, 8, '2025-03-23 13:00:00'),
(28, 3, 4, '2025-03-23 14:15:00'),
(29, 1, 5, '2025-03-23 15:30:00'),
(30, 2, 9, '2025-03-23 16:45:00'),
(31, 3, 6, '2025-03-23 18:00:00'),
(32, 1, 10, '2025-03-23 19:15:00'),
(33, 2, 4, '2025-03-23 20:30:00'),
(34, 3, 7, '2025-03-23 21:45:00'),
(35, 1, 8, '2025-03-23 23:00:00'),
(36, 2, 1, '2025-03-24 08:15:00'),
(37, 3, 5, '2025-03-24 09:30:00'),
(38, 1, 2, '2025-03-24 10:45:00'),
(39, 2, 9, '2025-03-24 12:00:00'),
(40, 3, 4, '2025-03-24 13:15:00'),
(41, 1, 10, '2025-03-24 14:30:00'),
(42, 2, 7, '2025-03-24 15:45:00'),
(1, 1, 1, '2025-03-17 10:00:00'),
(2, 2, 2, '2025-03-17 11:00:00'),
(3, 3, 3, '2025-03-17 12:00:00'),
(4, 1, 4, '2025-03-17 13:00:00'),
(5, 2, 5, '2025-03-17 14:00:00'),
(6, 3, 6, '2025-03-17 15:00:00'),
(7, 1, 7, '2025-03-17 16:00:00'),
(8, 2, 8, '2025-03-17 17:00:00'),
(9, 3, 9, '2025-03-17 18:00:00'),
(10, 1, 10, '2025-03-17 19:00:00'),
(11, 2, 1, '2025-03-17 20:00:00'),
(12, 3, 2, '2025-03-17 21:00:00'),
(13, 1, 3, '2025-03-17 22:00:00'),
(14, 2, 4, '2025-03-17 23:00:00'),
(15, 3, 5, '2025-03-18 00:00:00'),
(16, 1, 6, '2025-03-18 01:00:00'),
(17, 2, 7, '2025-03-18 02:00:00'),
(18, 3, 8, '2025-03-18 03:00:00'),
(19, 1, 9, '2025-03-18 04:00:00'),
(20, 2, 10, '2025-03-18 05:00:00'),
(21, 3, 1, '2025-03-18 06:00:00'),
(22, 1, 2, '2025-03-18 07:00:00'),
(23, 2, 3, '2025-03-18 08:00:00'),
(24, 3, 4, '2025-03-18 09:00:00'),
(25, 1, 5, '2025-03-18 10:00:00'),
(26, 2, 6, '2025-03-18 11:00:00'),
(27, 3, 7, '2025-03-18 12:00:00'),
(28, 1, 8, '2025-03-18 13:00:00'),
(29, 2, 9, '2025-03-18 14:00:00'),
(30, 3, 10, '2025-03-18 15:00:00'),
(31, 1, 1, '2025-03-18 16:00:00'),
(32, 2, 2, '2025-03-18 17:00:00'),
(33, 3, 3, '2025-03-18 18:00:00'),
(34, 1, 4, '2025-03-18 19:00:00'),
(35, 2, 5, '2025-03-18 20:00:00'),
(36, 3, 6, '2025-03-18 21:00:00'),
(37, 1, 7, '2025-03-18 22:00:00'),
(38, 2, 8, '2025-03-18 23:00:00'),
(39, 3, 9, '2025-03-19 00:00:00'),
(40, 1, 10, '2025-03-19 01:00:00'),
(41, 2, 1, '2025-03-19 02:00:00'),
(42, 3, 2, '2025-03-19 03:00:00'),
(43, 1, 3, '2025-03-19 04:00:00'),
(44, 2, 4, '2025-03-19 05:00:00'),
(45, 3, 5, '2025-03-19 06:00:00'),
(46, 1, 6, '2025-03-19 07:00:00'),
(47, 2, 7, '2025-03-19 08:00:00'),
(48, 3, 8, '2025-03-19 09:00:00'),
(49, 1, 9, '2025-03-19 10:00:00'),
(50, 2, 10, '2025-03-19 11:00:00');

UPDATE mysqlproject_2.Orders
SET delivery_starts = DATE_ADD(order_date, INTERVAL 10 MINUTE),
    delivery_ends = DATE_ADD(order_date, INTERVAL FLOOR(RAND() * 60 + 30) MINUTE);


INSERT INTO mysqlproject_2.Courier_Schedule (courier_id, start_time, end_time) VALUES
(1, '08:00:00', '18:00:00'),  -- Курьер 1
(2, '09:00:00', '19:00:00'),  -- Курьер 2
(3, '10:00:00', '20:00:00'),  -- Курьер 3
(4, '07:00:00', '17:00:00'),  -- Курьер 4
(5, '12:00:00', '22:00:00'),  -- Курьер 5
(6, '08:30:00', '18:30:00'),  -- Курьер 6
(7, '09:30:00', '19:30:00'),  -- Курьер 7
(8, '10:30:00', '20:30:00'),  -- Курьер 8
(9, '07:30:00', '17:30:00'),  -- Курьер 9
(10, '11:00:00', '21:00:00'), -- Курьер 10
(11, '08:00:00', '16:00:00'), -- Курьер 11
(12, '09:00:00', '17:00:00'), -- Курьер 12
(13, '10:00:00', '18:00:00'), -- Курьер 13
(14, '07:00:00', '15:00:00'), -- Курьер 14
(15, '12:00:00', '20:00:00'); -- Курьер 15


DELIMITER //
CREATE TRIGGER before_order_insert
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    IF NEW.order_date < NOW() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Дата заказа не может быть в прошлом';
    END IF;
END;
//
DELIMITER ;


-- procedure 

DELIMITER //
CREATE PROCEDURE full_info(IN courier_id INT)
BEGIN
    Select o.courier_id,o.order_id, o.order_date, o.delivery_starts, o.delivery_ends, c.name, address, service_name, price, co.name, co.phone, transport_name, z.zone_name
	from Orders o
	inner join Customers c on c.customer_id = o.customer_id
	inner join Services s on s.service_id = o.service_id
	inner join Couriers co on co.courier_id = o.courier_id
	inner join Transport_Types tt on tt.transport_id = co.transport_type
	inner join Zones z on z.zone_id = co.zone
    WHERE courier_id IS NULL OR o.courier_id = courier_id;
END;
//
DELIMITER ;
CALL full_info(null);

select * from Orders;

DROP PROCEDURE IF EXISTS update_order;
DELIMITER //

CREATE PROCEDURE update_order(
    IN p_order_id INT,
    IN p_customer_id int,
    in p_service_id int,
    in p_courier_id int,
    IN p_order_date DATETIME,
    IN p_delivery_starts DATETIME,
    IN p_delivery_ends DATETIME
    
)
BEGIN

    IF (SELECT COUNT(*) FROM Orders WHERE order_id = p_order_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ошибка: заказ с таким ID не найден';
    END IF;

    -- Обновление данных
    UPDATE Orders
    SET 
        order_date = p_order_date,
        delivery_starts = p_delivery_starts,
        delivery_ends = p_delivery_ends,
        customer_id = p_customer_id,
        service_id = p_service_id,
        courier_id = p_courier_id
    WHERE order_id = p_order_id;
END;
//
DELIMITER ;


CALL update_order(1, 3, 2, 4, '2025-03-19 15:00:00', '2025-03-19 15:30:00', '2025-03-19 16:00:00');

DROP PROCEDURE IF EXISTS create_order;
DELIMITER //

CREATE PROCEDURE create_order(
    IN p_customer_id INT,
    IN p_service_id INT,
    IN p_courier_id INT,
    IN p_order_date DATETIME,
    IN p_delivery_starts DATETIME,
    IN p_delivery_ends DATETIME
)
BEGIN

    IF (SELECT COUNT(*) FROM Customers WHERE customer_id = p_customer_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'client error';
    END IF;

    IF (SELECT COUNT(*) FROM Couriers WHERE courier_id = p_courier_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'courier error';
    END IF;

    IF (SELECT COUNT(*) FROM Services WHERE service_id = p_service_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'service error';
    END IF;

    -- Вставка нового заказа в таблицу Orders
    INSERT INTO Orders (
        customer_id,
        service_id,
        courier_id,
        order_date,
        delivery_starts,
        delivery_ends
    )
    VALUES (
        p_customer_id,
        p_service_id,
        p_courier_id,
        p_order_date,
        p_delivery_starts,
        p_delivery_ends
    );
    
    SELECT LAST_INSERT_ID() AS new_order_id;
END;
//
DELIMITER ;



CREATE INDEX idx_order_date ON mysqlproject_2.Orders (order_date);
SHOW INDEX FROM Orders;

SET character_set_client = 'latin1';
SET character_set_connection = 'latin1';
SET character_set_results = 'latin1';
SET character_set_database = 'utf8mb4';
SET character_set_server = 'utf8mb4';
