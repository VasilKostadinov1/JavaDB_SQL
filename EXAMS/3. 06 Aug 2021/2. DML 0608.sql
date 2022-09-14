SET SQL_SAFE_UPDATES =0;

#2 -----------------------------------------------------
INSERT INTO games (`name`, rating, budget, team_id)
SELECT  lower( reverse( substr( `name`, 2))), id, leader_id*1000, id
FROM teams
WHERE id BETWEEN 1 AND 9;

# 3 3.	Update ---------------------------------------------
UPDATE employees AS e
JOIN teams AS t ON e.id = t.leader_id
SET salary = salary +1000
WHERE t.leader_id IS NOT NULL AND
		age < 40 AND salary < 5000;
        
# 4 4.	----------------------
-- Delete- Delete all games from table games, which do not have a category and release date. 

DELETE g
FROM games AS g
LEFT JOIN games_categories AS gc ON g.id = gc.game_id
WHERE g.release_date IS NULL AND gc.game_id IS NULL;
