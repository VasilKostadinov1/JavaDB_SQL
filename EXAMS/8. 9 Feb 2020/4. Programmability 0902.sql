USE exam090220;

-- !!! same as 13 Feb 2022 !!!

# 10 10.	Find all players that play on stadium ------------------------------------------------------
-- that receives a stadium’s name and returns the number of players that play home matches there
DELIMITER $$
CREATE FUNCTION udf_stadium_players_count (stadium_name VARCHAR(30)) 
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE players_count INT;
    SET players_count := (
        SELECT COUNT(p.id)  -- returns the number of players
        FROM stadiums AS s
                 JOIN teams AS t ON t.stadium_id = s.id
                 JOIN players AS p ON p.team_id = t.id
        WHERE s.name = stadium_name 
        );
    RETURN players_count;
end $$
DELIMITER ;

SELECT udf_stadium_players_count ('Jaxworks') as `count`; 

# 11 11.	Find good playmaker by teams ---------------------------------------------

DELIMITER $$
CREATE PROCEDURE udp_find_playmaker (min_dribble_points INT, team_name VARCHAR (45))
BEGIN
	-- Show all needed info for this player: full_name, age, salary, dribbling, speed, team name.
    SELECT concat_ws(' ', first_name, last_name) AS full_name, age, salary, sd.dribbling, sd.speed,	t.`name`
   	FROM players AS p
    		JOIN skills_data AS sd ON p.skills_data_id = sd.id
			JOIN teams AS t ON p.team_id = t.id
            -- players with the given skill stats (more than min_dribble_points)
			WHERE sd.dribbling > min_dribble_points 
					AND t.`name` = team_name   -- played for given team (team_name)
                    -- and have more than average speed for all players. 
					AND sd.speed > (SELECT avg(speed) FROM skills_data)
			ORDER BY sd.speed DESC
			LIMIT 1;
END $$
DELIMITER ;

CALL udp_find_playmaker (20, ‘Skyble’);