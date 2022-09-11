-- 2-----------------------------------
INSERT INTO addresses (address, town, country, user_id)
SELECT username, `password`, ip, age
FROM users 
WHERE gender = 'M';


# 3 -----------------------------------
UPDATE addresses AS a 
SET 
    country = (
    CASE
        WHEN country LIKE 'B%' THEN 'Blocked'
        WHEN country LIKE 'T%' THEN 'Test'
        WHEN country LIKE 'P%' THEN 'In Progress'
        ELSE country
    END);
    
			#WHEN left(country, 1) = 'B' THEN 'Blocked'
        	#WHEN left(country, 1) = 'T' THEN 'Test'
        	#WHEN left(country, 1) = 'P' THEN 'In Progress'
            
# 4  --------------------------------------------------

DELETE FROM addresses AS a
WHERE a.id %3 =0;