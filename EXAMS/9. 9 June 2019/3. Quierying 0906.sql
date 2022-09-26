USE exam090619;
SET SQL_SAFE_UPDATES =0;

# 5. 05.	Clients

SELECT 
    c.id, c.full_name
FROM
    clients AS c
    ORDER BY c.id ASC;
    
# 6 06.	Newbies ----------------------------------------------------------

SELECT 
    e.id, concat_ws(' ', e.first_name, e.last_name) AS full_name,
    concat('$', e.salary) AS salary,
    e.started_on
FROM
    employees AS e
    WHERE e.salary >=100000 AND year(e.started_on) >=2018
    ORDER BY e.salary DESC, e.id ASC;
    
# 7 07.	Cards against Humanity --------------------------------------------

SELECT 
    c.id,
    concat( c.card_number, ' : ', cl.full_name) AS card_token
FROM
    cards AS c
    LEFT JOIN bank_accounts AS ba ON ba.id = c.bank_account_id
    LEFT JOIN clients AS cl ON cl.id = ba.client_id
    ORDER BY c.id DESC;
    
# 8 08.	Top 5 Employees -------------------------------------------------
-- the top 5 employees, in terms of clients assigned to them.
SELECT 
    concat_ws(' ', e.first_name, e.last_name) AS `name`,
    e.started_on,
    count(cl.id) AS count_of_clients
FROM
    employees AS e
    LEFT JOIN employees_clients AS ec ON ec.employee_id = e.id
    LEFT JOIN clients AS cl ON cl.id =ec.client_id
    GROUP BY e.id
    ORDER BY count_of_clients DESC, e.id ASC
    LIMIT 5;
    
# 9 09.	Branch cards ----------------------------------------------------
-- Extract from the database, all branches with the count of their issued cards
SELECT 
    b.`name`,
    COUNT(ca.id) AS count_of_cards
FROM
    branches AS b
    LEFT JOIN employees AS e ON e.branch_id = b.id
    LEFT JOIN employees_clients AS ec ON ec.employee_id = e.id
    LEFT JOIN clients AS cl ON cl.id = ec.client_id
    LEFT JOIN bank_accounts AS ba ON ba.client_id =cl.id
    LEFT JOIN cards AS ca ON ca.bank_account_id = ba.id
    GROUP BY b.id
    ORDER BY count_of_cards DESC , b.`name` ASC;