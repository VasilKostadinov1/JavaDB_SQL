DELIMITER $$
CREATE FUNCTION udf_game_info_by_name (game_name VARCHAR (20))
    RETURNS TEXT
    DETERMINISTIC
BEGIN
    DECLARE info VARCHAR (255);
	DECLARE team_name VARCHAR (40);
	DECLARE address_text VARCHAR (50);
	
	SET team_name := (SELECT t.`name`
        	FROM teams AS t 
        	JOIN games AS g 
        	ON g.team_id = t.id 
        	WHERE g.`name` = game_name);
	
  	SET address_text := (SELECT a.`name`
        	FROM addresses AS a
        	JOIN offices AS o
        	ON a.id = o.address_id
        	JOIN teams AS t
        	ON o.id = t.office_id
        	WHERE t.`name` = team_name);
    
  	SET info := concat_ws(' ', 'The', game_name, 'is developed by a', team_name, 'in an office with an address', address_text);
  	RETURN info;
end $$
DELIMITER ;

# 11 11.	Update budget of the games  ----------------------------------------------------------------
-- The procedure must increase the budget by 100,000 and add one year to their release_date to the games that 
-- do not have any categories and their rating is more than (not equal) the given parameter min_game_rating 
-- and release date is NOT NULL.

DELIMITER $$
CREATE PROCEDURE `udp_update_budget`(`min_game_rating` FLOAT)
BEGIN
    UPDATE games AS g
	LEFT JOIN games_categories AS c
    	ON g.id = c.game_id
    	SET g.budget = g.budget + 100000, 
			g.release_date = g.release_date +1
	WHERE c.category_id IS NULL 
		AND g.release_date IS NOT NULL 
		AND g.rating > min_game_rating;
END $$
DELIMITER ;

CALL udp_update_budget (8);