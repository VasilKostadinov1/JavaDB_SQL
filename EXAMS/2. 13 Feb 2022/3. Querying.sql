# 5 05.	Categories

SELECT * FROM categories AS c
ORDER BY c.name DESC;

# 6 06.	Quantity -------------------------------------------------------------------------
SELECT 
    p.id, p.brand_id, p.name, p.quantity_in_stock
FROM
    products AS p
    WHERE p.price >1000 AND p.quantity_in_stock <30
    ORDER BY p.quantity_in_stock ASC, p.id;
    
# 7. 07.	Review --------------------------------------------------------------------
-- Write a query that returns: content, picture_url, published_at, rating
-- for all reviews which content starts with ‘My’ and the characters of the content are more than 61 symbols.
-- Sort by rating in ascending order.

SELECT 
    id, content,rating,	picture_url, published_at 
FROM
    reviews AS r
    WHERE left(content, 2) = 'My' AND length(content) >61
    -- ---WHERE (SELECT r.content LIKE 'My%') AND LENGTH(r.content) > 61
    ORDER BY r.rating DESC;
    
# 8 08.	First customers -------------------------------------------------------------------------
# There are many customers in our shop system, but we need to find only those who are clients from the beginning of the online store creation.
# Extract from the database, the full name of employee, the address, and the date of order. The year must be lower or equal to 2018.

SELECT 
    concat_ws(' ', first_name, last_name) AS full_name,
    c.address , o.order_datetime 
FROM
    customers AS c
        JOIN
    orders AS o ON o.customer_id = c.id
    WHERE year(o.order_datetime)<=2018
    ORDER BY full_name DESC;
    
# 9. 09.	Best categories --------------------------------------------------------------------------

SELECT 
	COUNT(p.category_id) AS 'items_count',
    c.name,
    SUM(p.quantity_in_stock) AS 'total_quantity'
FROM
    categories AS c
        JOIN
    products AS p ON c.id = p.category_id
    GROUP BY c.id
    ORDER BY items_count DESC,  total_quantity ASC
    LIMIT 5;
