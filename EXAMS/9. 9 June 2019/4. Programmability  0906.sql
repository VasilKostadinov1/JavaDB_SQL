USE exam090619;

# 10 10.	Extract client cards count
-- that receives a client's full name and returns the number of cards he has.

DELIMITER $$
CREATE FUNCTION udf_client_cards_count (`name` VARCHAR (30))
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE cards_count INT;
    SET cards_count := (
        SELECT COUNT(c.id)            -- returns the number of cards 
			FROM clients AS cl 
            JOIN bank_accounts AS ba ON ba.client_id = cl.id
            JOIN cards AS c ON c.bank_account_id = ba.id
            WHERE cl.full_name = `name`
            );
    RETURN cards_count;
END $$
DELIMITER ;

# 11 11.	Extract Client Info ----------------------------------------------------

DELIMITER $$
CREATE PROCEDURE `udp_clientinfo`(`full_name` VARCHAR(100))
BEGIN
    SELECT 
    cl.full_name,
    cl.age,
    ba.account_number,
    concat('$', ba.balance)
FROM
	clients AS cl
    JOIN bank_accounts AS ba ON ba.client_id = cl.id
    WHERE cl.full_name = `full_name`;
    
END $$
DELIMITER ;