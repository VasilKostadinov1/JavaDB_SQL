# 5 5.	Employees

SELECT 
    e.first_name, e.last_name, e.age, e.salary, e.happiness_level
FROM
    employees AS e
    ORDER BY e.salary ASC, e.id;
    
# 6. Addresses of the teams ------------------------------------------------

SELECT 
    t.`name`, a.`name`, LENGTH(a.`name`)
FROM
    teams AS t
        JOIN
    offices AS o ON t.office_id = o.id
        JOIN
    addresses AS a ON o.address_id = a.id
WHERE
    o.website IS NOT NULL
ORDER BY t.name , a.name;

#7    . Categories Info ----------------------------------------------------------
# 7  ------------------------------------
SELECT 
    c.name,
    COUNT(c.id) AS games_count,
    ROUND(AVG(g.budget), 2) AS avg_budget,
    MAX(g.rating) AS max_rating
FROM
    games AS g
        JOIN
    games_categories AS gc ON g.id = gc.game_id
        JOIN
    categories AS c ON c.id = gc.category_id
GROUP BY c.id
HAVING max_rating >= 9.5
ORDER BY games_count DESC , c.name;

#8 8.	Games of 2022--------------------------------------------------------

SELECT 
    g.`name`,
	g.release_date ,
    concat(left( g.description, 10) , '...') AS 'summary',
    CASE
			WHEN month(g.release_date) BETWEEN 1 AND 3 THEN 'Q1'
			WHEN month(g.release_date) BETWEEN 4 AND 6 THEN 'Q2'
			WHEN month(g.release_date) BETWEEN 7 AND 9 THEN 'Q3'
            ELSE 'Q4'
	END AS 'quarter',
    t.name
FROM
    games AS g
        JOIN
    teams AS t ON t.id = g.team_id
    WHERE  (SELECT g.name LIKE '%2')
			AND year(g.release_date) = '2022'
            AND month(g.release_date)%2 =0
    -- WHERE right(g.`name`,1) ='2'
    -- (SELECT g.name LIKE '%2') 
    ORDER BY `quarter`;
    
    # 9 9.	Full info for games ------------------------------------------------------------
    
SELECT 
    g.`name`,
    IF(budget < 50000,
        'Normal budget',
        'Insufficient budget') AS 'budget_level',
    t.`name`,
    a.`name`
FROM
    games AS g
        LEFT JOIN
    games_categories AS gc ON g.id = gc.game_id
        JOIN
    teams AS t ON t.id = g.team_id
        JOIN
    offices AS o ON o.id = t.office_id
        JOIN
    addresses AS a ON a.id = o.address_id
WHERE
    g.release_date IS NULL
        AND gc.category_id IS NULL
ORDER BY g.`name`;

