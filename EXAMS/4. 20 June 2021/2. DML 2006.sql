SET SQL_SAFE_UPDATES =0;
# 2 2.	Insert

INSERT INTO clients (full_name, phone_number  )
SELECT concat_ws(' ', first_name, last_name), concat('(088) 9999', id*2)
FROM drivers 
WHERE id BETWEEN 10 AND 20;

# 3 3.	Update ---------------------------------------------------
UPDATE cars AS c
SET `condition` = 'C'                           -- set the condition to be 'C'
WHERE (mileage >= 80000 OR mileage IS NULL)     -- mileage greater than 800000 (inclusive) or NULL 
		AND `year` <=2010 						-- and must be older than 2010(inclusive). ????????
        AND `make` != 'Mercedes-Benz';
        
# 4 Delete ---------------------------------------------
-- do not have any courses and the count of the characters in the full_name is more than 3 characters. 

DELETE c
FROM clients AS c
LEFT JOIN courses AS cc ON c.id = cc.client_id
WHERE cc.id IS NULL AND length(c.full_name) >3;