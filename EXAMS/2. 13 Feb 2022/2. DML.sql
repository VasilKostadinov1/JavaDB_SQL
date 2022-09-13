CREATE DATABASE exam130222;
USE exam130222;
SET SQL_SAFE_UPDATES =0;

#2 02.	Insert ---------------------------------------------------------------------------------------------------
-- 		content – set it to the first 15 characters from the description of the product.
-- •	picture_url – set it to the product's name but reversed.
-- •	published_at – set it to 10-10-2010.
-- •	rating – set it to the price of the product divided by 8.

INSERT INTO reviews (content,  picture_url, published_at, rating)
SELECT left(`description`, 15), reverse(`name`), '2010-10-10', price/8
FROM products
WHERE id >=5;

#3 03.	Update ----------------------------------------------------------------------------------------------------
-- Reduce all products quantity by 5 for products with quantity equal to or greater than 60 and less than 70 (inclusive).

UPDATE products AS p
SET quantity_in_stock = quantity_in_stock-5
WHERE quantity_in_stock BETWEEN 60 AND 70;

# 4 04.	Delete - Delete all customers, who didn't order anything ----------------------------------------------------------
DELETE c
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.id
WHERE o.customer_id IS NULL;
