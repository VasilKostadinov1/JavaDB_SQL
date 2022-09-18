use gringotts;
SET SQL_SAFE_UPDATES =0;

# 1 Records' Count ---------------------------------------------------------------------
SELECT 
   COUNT(wd.id) AS rec_count
FROM
    wizzard_deposits AS wd;
    
# 2 Longest Magic Wand ------------------------------------------------------------------
SELECT 
    MAX(wd.magic_wand_size) AS longest_magic_wand
FROM
    wizzard_deposits AS wd;

# 3 Longest Magic Wand Per Deposit Groups ----------------------------------------------
SELECT 
	wd.deposit_group,
    MAX(wd.magic_wand_size) AS longest_magic_wand
FROM
    wizzard_deposits AS wd
    GROUP BY wd.deposit_group  -- Sort result by longest magic wand for each deposit group
    ORDER BY longest_magic_wand ASC, deposit_group;
    
 # 4 Smallest Deposit Group Per Magic Wand Size* ------------------------------------------
 -- Select the deposit group with the lowest average wand size.
 
SELECT `deposit_group` FROM `wizzard_deposits`
GROUP BY `deposit_group`
HAVING MIN(`magic_wand_size`) 
LIMIT 1;

# 5 Deposits Sum ------------------------------------------------------------------------
-- Select all deposit groups and its total deposit sum. Sort result by total_sum in increasing order.

SELECT 
    wd.deposit_group, SUM( wd.deposit_amount ) AS total_sum
FROM
    wizzard_deposits AS wd
    GROUP BY deposit_group
    ORDER BY total_sum;
    
# 6 . Deposits Sum for Ollivander Family ---------------------------------------------------------

SELECT 
    wd.deposit_group, SUM( wd.deposit_amount ) AS total_sum
FROM
    wizzard_deposits AS wd
    WHERE wd.magic_wand_creator = 'Ollivander family'
    GROUP BY deposit_group
    ORDER BY deposit_group ASC ;
    
# 7 Deposits Filter -----------------------------------------------------------------------------
SELECT 
    wd.deposit_group, SUM( wd.deposit_amount ) AS total_sum
FROM
    wizzard_deposits AS wd
    WHERE wd.magic_wand_creator = 'Ollivander family'
    GROUP BY deposit_group
    HAVING total_sum <150000
    ORDER BY total_sum DESC;
    
# 8 Deposit Charge ------------------------------------------------------------------------------
SELECT 
    wd.deposit_group, wd.magic_wand_creator,
    MIN( wd.deposit_charge) AS min_deposit_charge
FROM
    wizzard_deposits AS wd
    GROUP BY wd.deposit_group, wd.magic_wand_creator   -- Group by deposit_group and magic_wand_creator
    ORDER BY wd.magic_wand_creator, wd.deposit_group;  -- ascending order by magic_wand_creator and deposit_group.
    
# 9 Age Groups ---------------------------------------------------------------------------------------
SELECT(
	CASE
		WHEN `age` BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN `age` BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN `age` BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN `age` BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN `age` BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN `age` BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
    END
) AS 'age_group',
 COUNT(*) AS 'wizard_count'
FROM `wizzard_deposits`
GROUP BY `age_group`
ORDER BY `age_group`;

# 10 First Letter ------------------------------------------------------------------------------
SELECT 
     LEFT ( wd.first_name, 1) AS first_letter
FROM
    wizzard_deposits AS wd
    WHERE wd.deposit_group = 'Troll Chest'
    GROUP BY first_letter
    ORDER BY first_letter;
    
# 11 Average Interest  ---------------------------------------------------------------------

SELECT 
    wd.deposit_group, wd.is_deposit_expired,
    AVG( wd.deposit_interest ) AS average_interest
FROM
    wizzard_deposits AS wd
    -- WHERE year(wd.deposit_start_date) >= 1985
    WHERE `deposit_start_date` > '1985-01-01'
    GROUP BY wd.deposit_group, wd.is_deposit_expired  -- !!! group also by is_deposit_expired !!!
    ORDER BY wd.deposit_group DESC, wd.is_deposit_expired ASC;
    
# 12 Employees Minimum Salaries ---------------------------------------------------------------

USE soft_uni;

SELECT `department_id`, 
MIN(`salary`) AS 'minimum_salary' 
FROM employees
WHERE `department_id` IN (2, 5, 7) AND `hire_date` > '2000-01-01' -- who are hired after 01/01/2000. 
GROUP BY `department_id`
ORDER BY `department_id` ASC;

# 13 Employees Average Salaries ------------------------------------------------------------

CREATE TABLE hp AS 
SELECT * FROM employees
WHERE `salary` > 30000 AND `manager_id` != 42;

-- increase the salaries of all high paid employees with department_id = 1 with 5000 in the new table.
UPDATE hp
SET `salary` = `salary` +5000
WHERE `department_id` = 1;

-- Finally, select the average salaries in each department from the new table. 
-- Sort result by department_id in increasing order.
SELECT `department_id`, AVG(`salary`) AS 'avg_salary' FROM `hp`
GROUP BY `department_id`
ORDER BY `department_id`;

# 14 Employees Maximum Salaries -----------------------------------------------------------

SELECT 
    e.department_id,
    MAX( e.salary ) AS 'max_salary'
FROM
    employees AS e
    GROUP BY e.department_id
    HAVING `max_salary` NOT BETWEEN 3000 AND 7000
    ORDER BY e.department_id;

# 15 Employees Count Salaries -------------------------------------------------------------
    
SELECT 
    count(e.salary)  AS count_salary
FROM
    employees AS e
    WHERE e.manager_id IS NULL;
    
# 16 3rd Highest Salary* ------------------------------------------------------------------
-- The OFFSET argument is used to identify the starting point to return rows from a result set. !!! 
-- Basically, it exclude the first set of records
SELECT 
    e.department_id,
    (SELECT DISTINCT e2.salary  -- !!! distinct 
    FROM employees AS e2
    WHERE e2.department_id = e.department_id
    ORDER BY e2.salary DESC
    LIMIT 1
    OFFSET 2    -- !!! offset !!!
    ) AS third_highest_salary
FROM
    employees AS e
    GROUP BY e.department_id
    HAVING third_highest_salary IS NOT NULL
    ORDER BY e.department_id;
    
# 17. Salary Challenge** -----------------------------------------------------------------------
-- have salary higher than the average salary of their respective departments. Select only the first 10 rows
SELECT 
    e.first_name, e.last_name,e.department_id
FROM
    employees AS e
    WHERE salary > (
    SELECT AVG (salary)
    FROM employees em 
    WHERE e.department_id = em.department_id    
    )
    ORDER BY e.department_id, e.employee_id
    LIMIT 10;
    
# 18 Departments Total Salaries -------------------------------------------------------------------------
SELECT 
    e.department_id, 
	SUM( e.salary) AS total_salary
FROM
    employees AS e
    GROUP BY e.department_id
    ORDER BY e.department_id;
    
