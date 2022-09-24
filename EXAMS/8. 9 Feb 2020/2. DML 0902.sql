USE exam090220;
SET SQL_SAFE_UPDATES =0;

# 2 2.	Insert --------------------------------------
INSERT INTO coaches(first_name, last_name, salary, coach_level)
SELECT first_name, last_name, salary*2, length(first_name)
FROM players
WHERE age>= 45;

# 3 3.	Update ---------------------------------------------
-- Update all coaches, who train one or more players and their first_name starts with ‘A’. 
-- Increase their level with 1.
UPDATE coaches AS c
JOIN players_coaches AS pc ON pc.coach_id = c.id
-- JOIN players AS p ON p.id = pc.player_id
SET coach_level = coach_level + 1
WHERE left( c.first_name, 1) = 'A' AND pc.player_id IS NOT NULL;

# 4. 4.	Delete -------------------------------------------------
-- Delete all players from table players, which are already added in table coaches. 

-- in Workbench
DELETE p
FROM players AS p
JOIN coaches AS c
ON c.first_name = p.first_name AND c.last_name = p.last_name;

-- in Judge
DELETE FROM players
WHERE age >= 45;
