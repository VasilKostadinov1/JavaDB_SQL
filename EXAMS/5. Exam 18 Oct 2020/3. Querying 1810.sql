USE exam181020;

# 5 5.	Employees 

SELECT 
    e.first_name,e.middle_name ,e.last_name,e.salary, e.hire_date
FROM
    employees AS e
    ORDER BY e.hire_date DESC;
    
# 6 6.	Products with old pictures ---------------------------------------------------

SELECT 
    p.name, p.price, p.best_before,
    -- only first 10 characters of product description + '...'
    concat( left ( p.description, 10), '...') AS short_description,
    pic.url
FROM
    products AS p
    JOIN pictures AS pic ON pic.id = p.picture_id
    WHERE length(p.description) > 100  -- description more than 100 characters long
			AND year( pic.added_on ) < 2019 
			AND p.price >20
    ORDER BY p.price DESC;
    
# 7. 7.	Counts of products in stores and their average  -----------------------------

SELECT 
    s.`name`,
    COUNT(ps.product_id ) AS product_count,
    round(avg(p.price) ,2) AS `avg`
FROM
    stores AS s
    -- all of the stores (with or without products) => LEFT
    LEFT JOIN products_stores AS ps ON ps.store_id = s.id -- !!! LEFT
    LEFT JOIN products AS p ON p.id = ps.product_id
    GROUP BY s.id                  -- !!!! s.id ; NOT p.id
    ORDER BY product_count DESC, `avg` DESC , s.id;
    
# 8. 8.	Specific employee ----------------------------------------------------------
SELECT 
    concat_ws(' ', e.first_name, e.last_name) AS Full_name,
    s.`name` AS `Store_name`,
    a.`name` AS address,
    e.salary
FROM
    employees AS e
    JOIN stores AS s ON s.id = e.store_id
    JOIN addresses AS a ON a.id = s.address_id
    -- The employee's salary must be lower than 4000, the address of the store must contain '5' somewhere, 
    -- the length of the store name needs to be more than 8 characters 
    -- and the employee’s last name must end with an 'n'.
    WHERE e.salary < 4000 
    -- the address of the store must contain '5' somewhere
			AND locate(5, a.`name`) > 0            -- a.name LIKE '%5%'
			AND length(s.name) >= 8
			AND right( e.last_name,1) = 'n';  -- last name must end with an 'n'.
            
# 9 9.	Find all information of stores ---------------------------------------------

SELECT 
    reverse( s.`name`) AS reversed_name,
    concat( UPPER( t.`name`) , '-', a.`name`) AS full_address,
    COUNT(e.id) AS employees_count
FROM
    stores AS s
	JOIN addresses AS a ON a.id = s.address_id
    JOIN towns AS t ON t.id = a.town_id
    JOIN employees AS e ON s.id = e.store_id
    -- Filter only the stores that have a one or more employees.
    -- WHERE e.id >1   -- ???? 
    GROUP BY s.id
    ORDER BY full_address ASC;
    
