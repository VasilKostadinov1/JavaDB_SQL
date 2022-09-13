   
# 10 10.	Extract client cards count--------------------------
DELIMITER $$
CREATE FUNCTION udf_customer_products_count(name VARCHAR(30))
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE total_products INT;
    SET total_products := (
       SELECT COUNT(c.id) FROM customers AS c
        JOIN orders AS o on c.id = o.customer_id
        JOIN orders_products AS op on o.id = op.order_id
        WHERE c.first_name = name);
    RETURN total_products;
end $$
DELIMITER ;

SELECT c.first_name, c.last_name, udf_customer_products_count('Shirley') as `total_products` FROM customers c
WHERE c.first_name = 'Shirley';

#11 .  11.	Reduce price -----------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `udp_reduce_price`(category_name VARCHAR(50))
BEGIN
    UPDATE products p
        join reviews r on r.id = p.review_id
        JOIN categories c on c.id = p.category_id
    SET p.price = price * 0.70
    WHERE c.name = category_name
      AND r.rating < 4;
END $$
DELIMITER ;

CALL udp_reduce_price('Phones and tablets');