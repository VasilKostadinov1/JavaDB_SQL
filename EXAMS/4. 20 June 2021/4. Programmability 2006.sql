USE exam200621;

# 10 10.	Find all courses by client’s phone number ------------------
-- that receives a client’s phone number and returns the number of courses that clients have in database.

DELIMITER $$
CREATE FUNCTION udf_courses_by_client (phone_num VARCHAR (20))
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE phones_count INT;
    SET phones_count := (
        SELECT COUNT(c.id)            -- returns the number of courses
			FROM clients AS cl 
            JOIN courses AS c ON c.client_id = cl.id
            WHERE cl.phone_number = phone_num
            );
    RETURN phones_count;
END $$
DELIMITER ;

# 11 11.	Full info for address ------------------------------------------------

DELIMITER $$
CREATE PROCEDURE `udp_courses_by_address `(`address_name` VARCHAR(100))
BEGIN
    SELECT 
    a.`name`,
    cl.full_name,
    (CASE
		WHEN c.bill <= 20 THEN 'Low'
		WHEN c.bill <= 30 THEN 'Medium'
        ELSE 'High'
    END) AS level_of_bill,
    car.make,
    car.`condition`,
    cat.`name` AS cat_name
FROM
    addresses AS a 
    JOIN courses AS c ON c.from_address_id = a.id
    JOIN clients AS cl ON cl.id = c.client_id
    JOIN cars AS car ON car.id = c.car_id
    JOIN categories AS cat ON cat.id = car.category_id
    WHERE a.`name` = address_name
    ORDER BY car.make, cl.full_name; -- Order addresses by make, then by client’s full name.
END $$
DELIMITER ;

CALL udp_courses_by_address('700 Monterey Avenue');