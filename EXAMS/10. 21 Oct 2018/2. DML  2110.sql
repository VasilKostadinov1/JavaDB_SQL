SET SQL_SAFE_UPDATES =0;

#2 Insert
-- For colonists with id between 96 and 100(inclusive), insert data in the travel_cards table with the following values: 
-- •	For colonists born after ‘1980-01-01’, the card_number must be combination between the year of birth, day and the first 4 digits from the ucn. For the rest – year of birth, month and the last 4 digits from the ucn.
-- •	For colonists with id that can be divided by 2 without remainder, job must be ‘Pilot’, for colonists with id that can be divided by 3 without remainder – ‘Cook’, and everyone else – ‘Engineer’.
-- •	Journey id is the first digit from the colonist’s ucn.

INSERT INTO travel_cards (card_number, job_during_journey, colonist_id, journey_id)
SELECT IF(birth_date >= '1980-01-01', concat(year(birth_date), day(birth_date), left(ucn, 4)), concat(year(birth_date), month(birth_date), right(ucn, 4))) 
			AS card_number,
	CASE
		WHEN id % 2 = 0 THEN 'Pilot'
		WHEN id % 3 = 0 THEN 'Cook'
        ELSE 'Engineer'        
    END AS job_during_journey,
    id,
    left(ucn, 1) AS journey_id
FROM colonists
WHERE id BETWEEN 96 AND 100; -- colonists with id between 96 and 100(inclusive)

# 3 Update ------------------------------------------------------------------------------------------

UPDATE journeys AS j
SET id = (
	CASE
		WHEN id % 2 = 0 THEN 'Medical'
        WHEN id % 3 = 0 THEN 'Technical'
		WHEN id % 5 = 0 THEN 'Educational'
		WHEN id % 7 = 0 THEN 'Military'
    END
)
WHERE id % 2 = 0 OR id % 3 = 0 OR id % 5 = 0 OR id % 7 = 0;

# 4 Delete -------------------------------------------------------------------------------
-- REMOVE from colonists, those which are not assigned to any journey.

DELETE c 
FROM colonists AS c
LEFT JOIN travel_cards AS tc ON tc.colonist_id = c.id
WHERE tc.colonist_id IS NULL;

