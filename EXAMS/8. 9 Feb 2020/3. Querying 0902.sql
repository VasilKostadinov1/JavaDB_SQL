USE exam090220;

# 5 5.	Players 
SELECT 
    p.first_name, p.age, p.salary
FROM
    players AS p
    ORDER BY p.salary DESC;
    
# 6. 6.	Young offense players without contract ------------------------------------------------

SELECT 
    p.id,
    concat_ws(' ', p.first_name, p.last_name) AS full_name,
    p.age,
    p.position,
    p.hire_date
FROM
    players AS p
    JOIN skills_data AS sd ON sd.id = p.skills_data_id
    WHERE p.age < 23 AND p.position = 'A' AND p.hire_date IS NULL AND sd.strength >50
    ORDER BY p.salary ASC, p.age ASC;
    
# 7. 7.	Detail info for all teams --------------------------------------------------------------
-- Extract from the database ALL (=> left join by teams) of the teams and 
-- the count of the players that they have.
SELECT 
    t.`name` AS `team_name`, t.established, t.fan_base,
    COUNT(p.id) AS players_count
FROM
    teams AS t
    LEFT JOIN players AS p ON p.team_id = t.id
    GROUP BY t.id
    ORDER BY players_count DESC, fan_base DESC;
    
# 8 8.	The fastest player by towns ----------------------------------------------------------
SELECT 
    MAX( sd.speed) AS max_speed,
    tow.`name` AS town_name
FROM
    players AS p
    RIGHT JOIN skills_data AS sd ON sd.id = p.skills_data_id
    RIGHT JOIN teams AS t ON t.id = p.team_id
    RIGHT JOIN stadiums AS s ON t.stadium_id = s.id
    RIGHT JOIN towns AS tow ON s.town_id = tow.id
    WHERE t.`name`  != 'Devify'
    GROUP BY town_name
    ORDER BY max_speed DESC, tow.name ASC;
    
# 9. 9.	Total salaries and players by country ------------------------------------------------
SELECT 
    c.`name`,
    COUNT(p.id) AS total_count_of_players,
    SUM(p.salary) AS total_sum_of_salaries
FROM
    countries AS c
    -- If there are no players in a country, display NULL => LEFT join !!!!
    LEFT JOIN towns AS t ON t.country_id= c.id
    LEFT JOIN stadiums AS st ON st.town_id =t.id
    LEFT JOIN teams AS te ON te.stadium_id = st.id
    LEFT JOIN players AS p ON p.team_id =te.id
    GROUP BY c.id
    ORDER BY total_count_of_players DESC, c.name ASC;