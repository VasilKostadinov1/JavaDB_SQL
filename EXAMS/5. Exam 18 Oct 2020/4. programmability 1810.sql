USE exam181020;

# 10  10.	Find full name of top paid employee by store name ---------------------------
DELIMITER $$
CREATE FUNCTION udf_top_paid_employee_by_store(store_name VARCHAR(50)) 
    RETURNS TEXT
    DETERMINISTIC
BEGIN
	DECLARE full_info VARCHAR (255);
	DECLARE full_name  VARCHAR (40);
	DECLARE years INT;
	DECLARE employee_id INT;
    
	SET employee_id := (
		SELECT e.id
		FROM employees AS e
		JOIN stores AS s
		ON e.store_id = s.id
		WHERE s.`name` = store_name
		ORDER BY e.salary DESC
		LIMIT 1);
        
	SET full_name := (
		SELECT concat_ws(' ', first_name, concat(middle_name, '.'), last_name)
		FROM employees AS e
    		WHERE e.id = employee_id);
	
  	SET years := (
		SELECT floor(DATEDIFF("2020-10-18", hire_date)/365)
		FROM employees AS e
		WHERE e.id = employee_id);
    
  	SET full_info := concat_ws(' ', full_name, 'works in store for', years, 'years');
  	RETURN full_info;
END $$
DELIMITER ;

# 11 11.	Update product price by address ----------------------------------------------

DELIMITER $$
CREATE PROCEDURE `udp_update_product_price` (address_name VARCHAR (50))
BEGIN
    UPDATE products AS p
        JOIN products_stores AS ps ON p.id = ps.product_id
        JOIN stores AS s ON s.id = ps.store_id
        JOIN addresses AS a ON a.id = s.address_id
    SET p.price = IF (left(address_name, 1) = '0', p.price + 100, p.price + 200)
    WHERE m.title = address_name;
END $$
DELIMITER ;