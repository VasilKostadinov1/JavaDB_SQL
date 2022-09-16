#1 1.	Find Names of All Employees by First Name
SELECT 
    e.first_name, e.last_name
FROM
    employees AS e
    WHERE e.first_name LIKE 'Sa%'
    ORDER BY e.employee_id;
    
#2 2.	Find Names of All Employees by Last Name-----------------------
-- contains "ei" (case insensitively). 
SELECT 
    e.first_name, e.last_name
FROM
    employees AS e
    WHERE e.last_name LIKE '%ei%'
    ORDER BY e.employee_id;
    
#3 3.	Find First Names of All Employees ---------------------------------
-- departments with ID 3 or 10 and whose hire year is between 1995 and 2005 inclusively.

SELECT `first_name` FROM `employees`
WHERE `department_id` IN (3, 10) AND               -- 3 or 10
		YEAR(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

#4 4.	Find All Employees Except Engineers -----------------------------------------
SELECT 
    e.first_name, e.last_name
FROM
    employees AS e
    WHERE e.job_title NOT LIKE '%engineer%'
    ORDER BY `employee_id`;
    
#5 5.	Find Towns with Name Length ----------------------------------------------------
SELECT t.name FROM towns AS t
WHERE length(`name`) IN (5,6)         -- 5 or 6 symbols long 
ORDER BY t.name ASC;

#6 Find Towns Starting With ----------------------------------------------------------
SELECT * FROM towns AS t
WHERE  left(`name`, 1)  IN('m', 'k', 'b', 'e')   -- start with letters M, K, B or E (case insensitively).
ORDER BY `name` ASC;

# 7 Find Towns Not Starting With  ----------------------------------------------------
SELECT * FROM towns AS t
WHERE left(`name`, 1) NOT IN('r', 'b', 'd')   -- do not start with letters R, B or D (case insensitively). 
ORDER BY `name` ASC;

#8. 8.	Create View Employees Hired After 2000 Year ---------------------------------------
CREATE VIEW `v_employees_hired_after_2000` AS
SELECT 
    e.first_name, e.last_name
FROM
    employees AS e
    WHERE year(hire_date) >2000;
SELECT *FROM `v_employees_hired_after_2000`;

#9 9.	Length of Last Name -----------------------------------------------------------
SELECT e.first_name, e.last_name
FROM employees AS e
WHERE length(e.last_name) = 5; 

#10 10.	Countries Holding 'A' 3 or More Times --------------------------------------------
USE geography;
SELECT c.country_name, c.iso_code
FROM countries AS c
WHERE c.country_name LIKE '%A%A%A%' -- at least 3 times (case insensitively)
ORDER BY c.iso_code;

# 11 Mix of Peak and River Names -------------------------------------------------------
-- last letter of each peak name is the same as the first letter of its corresponding river name. 
-- Display the peak name, the river name, and the obtained mix(converted to lower case).
SELECT 
    peak_name, river_name,
    lower( concat(`peak_name`, substring(`river_name`,2))) AS `mix`
FROM
    peaks , rivers
    WHERE left(river_name, 1) = right(peak_name, 1)
    ORDER BY `mix`;
    
#12 --12.	Games from 2011 and 2012 Year --------------------------------------------------------
USE diablo;

SELECT `name`, date_format( `start`, '%Y-%m-%d') AS `start`
FROM games AS g
WHERE year(`start`) in (2011, 2012) -- years 2011 and 2012
ORDER BY `start`, `name`
LIMIT 50;

#13 User Email Providers----------------------------------------------------------------------

SELECT 
    user_name, substring(email, locate('@', `email`) +1) AS `email_provider`
FROM
    users AS u
    ORDER BY `email_provider`, user_name;
    
#14 Get Users with IP Address Like Pattern ----------------------------------------------

SELECT 
    user_name, ip_address
FROM
    users
    WHERE ip_address LIKE '___.1%.%.___'
    ORDER BY user_name;
    
    
    
#15 Show All Games with Duration and Part of the Day -----------------------------------
-- Morning (start time is >= 0 and < 12), Afternoon (start time is >= 12 and < 18), Evening (start time is >= 18 and < 24)
-- Duration should be Extra Short (smaller or equal to 3), Short (between 3 and 6 including), Long (between 6 and 10 including) 

SELECT 
    `name`,
    CASE
		WHEN hour(`start`) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN hour(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN hour(`start`) BETWEEN 18 AND 24 THEN 'Evening'
        END AS 'Part of the Day',

    CASE
		WHEN duration <=3 THEN  'Extra Short'
		WHEN duration <=6 THEN  'Short'
		WHEN duration <=10 THEN  'Long'
        ELSE 'Extra Long'
        END AS `Duration`
        
FROM
    games;
    
# 16 Orders Table ----------------------------------------------------------------------
SELECT 
    product_name,
    order_date,
    adddate(order_date, INTERVAL 3 day ) AS 'pay_due',
    adddate(order_date, INTERVAL 1 month ) AS 'pay_due'
FROM
    orders


