# 5 Cars

SELECT 
    c.make, c.model, c.condition
FROM
    cars AS c
    ORDER BY c.id;
    
# 6. 6.	Drivers and Cars ---------------------------------------------------------------
SELECT 
    d.first_name, d.last_name, c.make, c.model, c.mileage
FROM
    drivers AS d
    JOIN cars_drivers AS cd ON d.id = cd.driver_id
	JOIN cars AS c ON c.id = cd.car_id
    WHERE c.mileage IS NOT NULL
    ORDER BY c.mileage DESC, d.first_name;
    
# 7. 7.	Number of courses for each car ------------------------------------------------
    SELECT 
    c.id, c.make, c.mileage, COUNT(cc.id) AS count_courses , round(avg(cc.bill),2) AS avg_bill
    FROM cars AS c
    LEFT JOIN courses AS cc ON c.id = cc.car_id
    GROUP BY c.id
    HAVING count_courses !=2
    ORDER BY COUNT(cc.id) DESC, c.id;
    
# 8 8.	Regular clients ----------------------------------------------------------------

SELECT 
	c.full_name, 
	count(co.car_id) AS count_of_cars,
	SUM(co.bill) AS total_sum
FROM clients AS c
JOIN courses AS co ON c.id = co.client_id
WHERE full_name LIKE '_a%'           -- second letter of the customer's full name must be 'a'.
GROUP BY c.id
HAVING count_of_cars > 1
-- HAVING count_of_cars > 1 AND SUBSTR(c.full_name, 2, 1) LIKE 'a'
ORDER BY full_name;

# 9. 9.	Full information of courses -------------------------------------------------

SELECT 
a.name,
IF( hour( co.start ) BETWEEN 6 AND 20, 'Day', 'Night') AS day_time,
co.bill,
cl.full_name,
c.make,
c.model,
cat.name
FROM cars AS c
JOIN courses AS co ON c.id =co.car_id
JOIN addresses AS a ON a.id = co.from_address_id
JOIN clients AS cl ON cl.id = co.client_id
JOIN categories AS cat ON cat.id = c.category_id
ORDER BY co.id



