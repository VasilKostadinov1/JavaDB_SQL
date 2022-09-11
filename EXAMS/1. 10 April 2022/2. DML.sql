#2 02.	Insert
INSERT INTO actors (first_name,last_name ,birthdate , height ,awards ,country_id )
SELECT reverse(first_name),
	reverse(last_name),
	date_sub(birthdate, interval 2 day),
	height +10,
	country_id,
	(SELECT id FROM countries AS c WHERE `name` LIKE 'Armenia')
    FROM actors
    WHERE id <= 10;

# 3 03.	Update ------------------------------------------------------------------------------------------------
-- Reduce all movies runtime by 10 minutes for movies with movies_additional_info id equal to or greater than 15 
-- and less than 25 (inclusive).
UPDATE movies_additional_info AS mai
SET 
    runtime = (CASE
        WHEN runtime - 10 < 0 THEN 0
        ELSE runtime - 10
    END)
WHERE
    id BETWEEN 15 AND 25;
    
    
#4 04.	Delete -Delete all countries that don’t have movies ---------------------------------------------------
DELETE c FROM countries AS c
LEFT JOIN movies AS m ON c.id = m.country_id
WHERE m.country_id IS NULL;



