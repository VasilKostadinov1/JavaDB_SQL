USE exam181020;
SET SQL_SAFE_UPDATES =0;

#2 2.	Insert --------------------------------- !!!!!!
-- You will have to insert records of data into the products_stores table, based on the products table. 
-- Find all products that are not offered in any stores (don’t have a relation with stores

INSERT INTO products_stores 
SELECT p.id, 1  -- product_id – id of product; store_id – set it to be 1 for all products.
FROM products AS p
LEFT JOIN products_stores AS ps ON ps.product_id = p.id
WHERE ps.store_id IS NULL;

# 3 3.	Update ----------------------------------------------------------------------
-- Update all employees that hire after 2003(exclusive) year and not work in store Cardguard and Veribet. 
-- Set their manager to be Carolyn Q Dyett (with id 3) and decrease salary with 500.

UPDATE employees AS e
SET salary = salary -500 , manager_id = 3  -- !!!! use , NOT 'AND'
WHERE year(hire_date) > 2003 AND store_id NOT IN (5, 14);
-- WHERE year(hire_date) >2003 AND (store_id != 5 AND store_id != 14);

# 4 Delete --------------------------------------------------------------------------
-- Be careful not to delete managers they are also employees.
-- Delete only those employees that have managers and a salary is more than 6000(inclusive)

DELETE e
FROM employees AS e
WHERE salary >=6000 AND manager_id IS NOT NULL;