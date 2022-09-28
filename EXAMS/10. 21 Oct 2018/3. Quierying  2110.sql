
# 04.Extract all travel cards 

SELECT 
    tc.card_number,
    tc.job_during_journey
FROM
    travel_cards AS tc
    ORDER BY tc.card_number;
    
# 5. Extract all colonists ---------------------------------------------------

SELECT 
    c.id,
    concat_ws(' ', c.first_name, c.last_name) AS full_name,
    c.ucn
FROM
    colonists AS c
    ORDER BY c.first_name,c.last_name,c.id;
    
# 6. 06.	Extract all military journeys -------------------------------------------

SELECT 
    j.id,
    j.journey_start, j.journey_end
FROM
    journeys AS j
    WHERE j.purpose = 'Military'
    ORDER BY j.journey_start ASC;
    
# 7 07.	Extract all pilots ---------------------------------------------------

SELECT 
    c.id, concat_ws(' ', c.first_name, c.last_name)  AS full_name
FROM
    colonists AS c
    LEFT JOIN travel_cards AS tc ON tc.colonist_id = c.id
    WHERE tc.job_during_journey = 'Pilot'
    ORDER BY c.id ASC;
    
#8 08.	Count all colonists that are on technical journey -------------------------
-- Count all colonists, that are on technical journey. 
SELECT 
    COUNT(c.id)
FROM
    colonists AS c
    LEFT JOIN travel_cards AS tc ON tc.colonist_id = c.id
    LEFT JOIN journeys AS j ON j.id = tc.journey_id
    WHERE j.purpose = 'Technical';
    
# 9 Extract the fastest spaceship ----------------------------------------------------
SELECT 
    ship.name,
    sport.name
FROM
    spaceships AS ship
    JOIN journeys AS j ON j.spaceship_id = ship.id
    JOIN spaceports AS sport ON sport.id = j.destination_spaceport_id
    ORDER BY ship.light_speed_rate DESC
    LIMIT 1;
    
#10 Extract spaceships with pilots younger than 30 years ------------------------------

SELECT 
    ship.name, ship.manufacturer
FROM
    spaceships AS ship
    JOIN journeys AS j ON j.spaceship_id = ship.id
    JOIN travel_cards AS tc ON tc.journey_id = j.id
    JOIN colonists AS c ON c.id = tc.colonist_id
    WHERE 2019 - year(c.birth_date) < 30  AND tc.job_during_journey = 'Pilot'
    GROUP BY ship.id   -- ???????????????????
    ORDER BY ship.name ASC;
    
#11 Extract all educational mission planets and spaceports -----------------------------

SELECT 
    p.name AS planet_name,
    s.name AS spaceport_name
FROM
    planets AS p
    JOIN spaceports AS s ON s.planet_id = p.id
    JOIN journeys AS j ON j.destination_spaceport_id = s.id
    WHERE j.purpose = 'Educational'
    ORDER BY s.name DESC;
    
#12 Extract all planets and their journey count ----------------------------------------

SELECT 
    p.`name` AS planet_name,
    count(j.id) AS journeys_count
FROM
    planets AS p
    JOIN spaceports AS sp ON p.id = sp.planet_id
    JOIN journeys AS j ON j.destination_spaceport_id = sp.id
    GROUP BY p.name
    ORDER BY journeys_count DESC, planet_name ASC;
    
# 13 Extract the shortest journey -----------------------------------------------------
SELECT 
    j.id,
    p.`name`,
    sport.`name`,
    j.purpose
FROM
    journeys AS j
    JOIN travel_cards AS tc ON tc.journey_id = j.id
    JOIN spaceports AS sport ON sport.id = j.destination_spaceport_id
    JOIN planets AS p ON p.id = sport.planet_id
    ORDER BY j.journey_end - j.journey_start
	LIMIT 1;
    
# 14 Extract the less popular job ---------------------------------------------
SELECT tc.job_during_journey
FROM travel_cards AS tc
JOIN journeys AS j
ON tc.journey_id = j.id
GROUP BY j.id, tc.job_during_journey
ORDER BY j.journey_end - j.journey_start DESC, count(tc.id)
LIMIT 1;
