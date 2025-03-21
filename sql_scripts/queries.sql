use mysqlproject_2;

Select o.order_id, o.order_date, c.name, address, service_name, price, co.name, co.phone, transport_name, z.zone_name
from Orders o
inner join Customers c on c.customer_id = o.customer_id
inner join Services s on s.service_id = o.service_id
inner join couriers co on co.courier_id = o.courier_id
inner join transport_types tt on tt.transport_id = co.transport_type
inner join zones z on z.zone_id = co.zone;


-- CRUD 
INSERT INTO mysqlproject_2.Couriers (name, phone, transport_type, zone)
VALUES ('Егор', '79990006666', 1, 3);
--
SELECT * FROM mysqlproject_2.Couriers WHERE name = 'Егор';
--
UPDATE mysqlproject_2.Couriers 
SET transport_type = 4 
WHERE name = 'Иван';
--
DELETE FROM mysqlproject_2.Couriers 
WHERE name = 'Егор';

-- WHERE 3 tables
select * 
from orders 
WHERE customer_id IN (SELECT customer_id FROM Customers WHERE address LIKE '%Ленина%')
AND service_id IN (SELECT service_id FROM Services WHERE price > 600)
AND courier_id IN (SELECT courier_id FROM Couriers WHERE transport_type = 2);

-- select 
select * 
from Couriers
where transport_type = (select transport_id from transport_types where transport_name = 'СИМ');
-- нельзя без вложенного
select *
from Orders
where service_id = (select service_id from services where price = (select min(price) from services));
-- or
select * from orders where order_date = (select min(order_date) from orders);

-- with

UPDATE mysqlproject_2.Orders
SET delivery_starts = DATE_ADD(order_date, INTERVAL 10 MINUTE),
    delivery_ends = DATE_ADD(order_date, INTERVAL FLOOR(RAND() * 60 + 30) MINUTE);

--
with cte as (
select order_id, o.courier_id, start_time, end_time, order_date
from orders o
inner join courier_schedule cs on cs.courier_id = o.courier_id
)
select courier_id, count(order_id) as amount
from cte
where '11:30:00' > time(order_date)
group by courier_id;

-- join

Select o.order_id, o.order_date, o.delivery_starts, o.delivery_ends, c.name, address, service_name, price, co.name, co.phone, transport_name, z.zone_name
from Orders o
inner join Customers c on c.customer_id = o.customer_id
inner join Services s on s.service_id = o.service_id
inner join couriers co on co.courier_id = o.courier_id
inner join transport_types tt on tt.transport_id = co.transport_type
inner join zones z on z.zone_id = co.zone;

-- left/right join + group by + having 

SELECT z.zone_name, count(c.name) carrier_num
FROM mysqlproject_2.zones z
LEFT JOIN mysqlproject_2.couriers c ON c.zone = z.zone_id
group by zone_id
having carrier_num<2
;

-- order by 
SELECT * FROM mysqlproject_2.Orders ORDER BY order_date DESC limit 1;

-- 
select count(order_id) total_orders, avg(price)  avg_price 
FROM orders o
inner join services s on s.service_id = o.service_id;

--
select count(order_id) total_orders
FROM orders o
inner join services s on s.service_id = o.service_id
where price>(select avg(price) from orders o inner join services s on s.service_id = o.service_id);

-- trigger 

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

INSERT INTO Orders (customer_id, service_id, courier_id, order_date, delivery_starts, delivery_ends)
VALUES (1, 1, 1, '2024-03-01 12:00:00', '2024-03-01 12:30:00', '2024-03-01 13:00:00');

-- procedure 
drop procedure  full_info;
DELIMITER //
CREATE PROCEDURE full_info(IN courier_id INT)
BEGIN
    Select o.courier_id,o.order_id, o.order_date, o.delivery_starts, o.delivery_ends, c.name, address, service_name, price, co.name, co.phone, transport_name, z.zone_name
	from Orders o
	inner join Customers c on c.customer_id = o.customer_id
	inner join Services s on s.service_id = o.service_id
	inner join couriers co on co.courier_id = o.courier_id
	inner join transport_types tt on tt.transport_id = co.transport_type
	inner join zones z on z.zone_id = co.zone
    WHERE courier_id IS NULL OR o.courier_id = courier_id;
END;
//
DELIMITER ;
CALL full_info(null);

select * from orders;

DROP PROCEDURE IF EXISTS update_order;
DELIMITER //

CREATE PROCEDURE update_order(
    IN p_order_id INT,
    IN p_customer_id int,
    in p_service_id int,
    in courier_id int,
    IN p_order_date DATETIME,
    IN p_delivery_starts DATETIME,
    IN p_delivery_ends DATETIME
    
)
BEGIN
    -- Проверка существования заказа
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

CALL create_order(1, 2, 3, '2025-03-20 10:00:00', '2025-03-20 11:00:00', '2025-03-20 12:00:00');


-- 



-- create index
CREATE INDEX idx_order_date ON mysqlproject_2.Orders (order_date);
SHOW INDEX FROM Orders;





