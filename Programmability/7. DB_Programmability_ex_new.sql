DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000 ()
BEGIN
    SELECT 
    e.first_name, e.last_name  -- returns all employees' first and last names
FROM
    employees AS e
    WHERE e.salary > 35000
    ORDER BY e.first_name, e.last_name, e.employee_id;
    
END $$
DELIMITER ;

# 2 2.	Employees with Salary Above Number -----------------------------------
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(salary_limit DOUBLE (19,4))
BEGIN
    SELECT 
    e.first_name, e.last_name
FROM
    employees AS e
    WHERE e.salary >= salary_limit
    ORDER BY e.first_name, e.last_name, e.employee_id;
    
END $$
DELIMITER ;

# 3 3.	Town Names Starting With -------------------------------------

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(start_with TEXT)
BEGIN
    SELECT 
     t.name  -- returns all town names starting with that string. 
FROM
    towns AS t
    WHERE t.name LIKE concat(start_with, '%')
    ORDER BY t.`name` ASC;
END $$
DELIMITER ;

# 4 4.	Employees from Town ------------------------------------------------

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name TEXT)
BEGIN
    SELECT 
     e.first_name, e.last_name  -- return the employees' first and last name
FROM
    employees as e
    JOIN addresses AS a ON a.address_id = e.address_id
    JOIN towns AS t ON t.town_id = a.town_id
    WHERE t.name = town_name
    ORDER BY e.first_name, e.last_name, e.employee_id;
    
END $$
DELIMITER ;

# 5 5.	Salary Level Function -------------------------------------------

DELIMITER $$                    -- receives salary of an employee 
CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL(19,4))
    RETURNS VARCHAR(50)       -- and returns the level of the salary
    DETERMINISTIC
BEGIN
    DECLARE salary_Level VARCHAR(10);
    SET salary_Level := (
		SELECT 
			CASE
				WHEN `employee_salary` < 30000 THEN 'Low'
				WHEN `employee_salary` <= 50000 THEN 'Average'
                ELSE 'High'
            END
        );
    RETURN salary_Level;
END $$
DELIMITER ;

# 6. 6.	Employees by Salary Level --------------------------------------

DELIMITER $$
CREATE PROCEDURE `usp_get_employees_by_salary_level` (salary_level VARCHAR(20))
BEGIN
SELECT e.`first_name`, e.`last_name` 
FROM `employees` AS e
WHERE (SELECT ufn_get_salary_level(e.`salary`) = salary_level)
ORDER BY e.`first_name` DESC, e.`last_name` DESC;
END $$
DELIMITER ;

# 7. 7.	Define Function ----------------------------------------------------
DELIMITER $$                   
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50)) 
    RETURNS INT      -- returns 1 or 0    
    DETERMINISTIC
BEGIN
   RETURN word REGEXP (concat('^[',set_of_letters,']*$'));
END $$
DELIMITER ;

# 8. 8.	Find Full Name ---------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `usp_get_holders_full_name` ()
BEGIN
SELECT concat_ws(' ', `first_name`, `last_name`) AS 'full_name'
FROM `account_holders`
ORDER BY `full_name` ASC, `id` ASC;
END $$
DELIMITER ;

# 9 9.	People with Balance Higher Than ---------------------------------------
-- returns all people who have more money in total of all their accounts than the supplied number.
DELIMITER $$
CREATE PROCEDURE `usp_get_holders_with_balance_higher_than` (given_money DECIMAL(19,4))
BEGIN
SELECT ac.first_name, ac.last_name
FROM `account_holders` AS ac
JOIN accounts AS a ON ac.id = a.account_holder_id
GROUP BY ac.id
HAVING SUM(a.balance)> given_money; -- more money in total of all their accounts
END $$
DELIMITER ;

#10 10.	Future Value Function -----------------------------------------------

DELIMITER ##
CREATE FUNCTION ufn_calculate_future_value (sum DECIMAL(19,4), interest DECIMAL(19,4), num_years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	RETURN sum * (pow((1 + interest), num_years));
END
##

# 11 11.	Calculating Interest --------------------------------------------------

DELIMITER ##
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_interest DECIMAL(19, 4), yers INT)
RETURNS DECIMAL(19, 4)
DETERMINISTIC
BEGIN
	DECLARE future_sum DECIMAL(19, 4);
    SET future_sum := sum * pow(1 + yearly_interest, yers);
    RETURN future_sum;
END;

CREATE PROCEDURE usp_calculate_future_value_for_account(id INT, interest DECIMAL(19, 4)) 
BEGIN
	SELECT a.id, first_name, last_name, a.balance AS current_balance, 
    ufn_calculate_future_value(a.balance, interest, 5) AS balance_in_5_years
	FROM account_holders AS h
    LEFT JOIN accounts AS a
    ON h.id = a.account_holder_id
    WHERE a.id = id;
END;
##

# 12 12.	Deposit Money -------------------------------------------

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
		IF (money_amount <= 0) THEN
    ROLLBACK;
		ELSE
			UPDATE accounts
            SET balance = balance + money_amount
            WHERE id = account_id;
			COMMIT;
        END IF;	
END

# 13 13.	Withdraw Money ----------------------------------------

DELIMITER ###
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
		IF (money_amount <= 0 OR (SELECT balance FROM accounts WHERE id = account_id) < money_amount) THEN
    ROLLBACK;
		ELSE
			UPDATE accounts
            SET balance = balance - money_amount
            WHERE id = account_id;
        END IF;	
END
###

# 14 14.	Money Transfer ----------------------------------------------------

DELIMITER ###
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF (
		(SELECT count(a.id) FROM accounts as a WHERE a.id = from_account_id) != 1 OR
        (SELECT count(a.id) FROM accounts as a WHERE a.id = to_account_id) != 1 OR
        amount < 0 OR from_account_id = to_account_id OR
        (SELECT balance FROM accounts WHERE id = from_account_id) < amount
	)	THEN ROLLBACK;
		ELSE
			UPDATE accounts SET balance = balance - amount WHERE id = from_account_id;
			UPDATE accounts SET balance = balance + amount WHERE id = to_account_id;
            COMMIT;
	END IF;
END
###

# 15 15.	Log Accounts Trigger ----------------------------------------------------------
#15.	Log Accounts Trigger
CREATE TABLE logs (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    old_sum DECIMAL(19,4) NOT NULL,
    new_sum DECIMAL(19,4) NOT NULL
);

DELIMITER ###
CREATE TRIGGER tr_transaction_log
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO logs SET account_id = old.id, old_sum = old.balance,
		new_sum = (SELECT balance FROM accounts WHERE id = old.id);
END
###

#16.Emails Trigger

SELECT date_format(current_timestamp(), '%b %e %Y at %l:%i:%s %p');

CREATE TABLE notification_emails (
	id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT NOT NULL,
    subject VARCHAR(100),
    body TEXT
);

DELIMITER ###
CREATE TRIGGER tr_notification_emails
BEFORE INSERT
ON logs
FOR EACH ROW
BEGIN
	INSERT INTO notification_emails SET
			recipient = new.account_id,
            subject = concat('Balance change for account: ', new.account_id),
            body = concat('On ', date_format(current_timestamp(), '%b %e %Y at %l:%i:%s %p'),
					'AM your balance was changed from ', new.old_sum,
                    ' to ', new.new_sum, '.');

END
###
