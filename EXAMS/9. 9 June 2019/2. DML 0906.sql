USE exam090619;
SET SQL_SAFE_UPDATES =0;
#2 02.	Insert

INSERT INTO cards (card_number, card_status , bank_account_id )
SELECT reverse( full_name ), 'Active', id
FROM clients
-- For clients with id between 191 and 200 (inclusive), 
WHERE id BETWEEN 191 AND 200;

# 3 03.	Update -------------------------------------------------------------------
-- Update all clients which have the same id as the employee they are appointed to. 
-- Set their employee_id with the employee with the lowest count of clients.
-- If there are 2 such employees with equal count of clients, take the one with the lowest id.

UPDATE employees_clients
SET employee_id = (SELECT * 
                   FROM (SELECT employee_id 
					FROM employees_clients
                   	GROUP BY employee_id
                   	ORDER BY count(client_id), employee_id
                   	LIMIT 1) 
                   AS s)
WHERE client_id = employee_id; -- clients which have the same id as the employee

# 4 04.	Delete ----------------------------------------------------------------------
-- Delete all employees which do not have any clients. 

DELETE e FROM employees AS e
LEFT JOIN employees_clients AS ec ON ec.employee_id = e.id
WHERE ec.client_id IS NULL;
