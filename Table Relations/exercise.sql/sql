CREATE DATABASE relationsEx1;
USE relationsEx1;

# 1.	One-To-One Relationship
DROP TABLE people;
CREATE TABLE `passports` (
	`passport_id` INT PRIMARY KEY AUTO_INCREMENT,
    `passport_number` VARCHAR(50) UNIQUE
);
ALTER TABLE `passports` AUTO_INCREMENT = 101;

INSERT INTO `passports` (`passport_number`)
VALUES
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2');

CREATE TABLE `people` (
	`person_id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50),
    `salary` DECIMAL(10,2),
    `passport_id` INT UNIQUE,
	CONSTRAINT fk_people_passports
    FOREIGN KEY (`passport_id`)
    REFERENCES `passports`(`passport_id`)
);

INSERT INTO `people` (`first_name`, `salary`, `passport_id`)
VALUES
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101);

# 2 2.	One-To-Many Relationship -----------------------------------------------------------------------------
CREATE TABLE `manufacturers` (
`manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30),
`established_on` DATE
);

INSERT INTO `manufacturers` (`name`, `established_on`)
VALUES
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');


CREATE TABLE `models`(
`model_id`  INT PRIMARY KEY AUTO_INCREMENT,
`name`VARCHAR(30) ,
`manufacturer_id` INT ,
	CONSTRAINT fk_manufacturer_manufacturer_id
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `manufacturers`(`manufacturer_id`)
);
ALTER TABLE `models` AUTO_INCREMENT = 101;

INSERT INTO `models`( `name`, `manufacturer_id`)
VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);

#3 3.	Many-To-Many Relationship ---------------------------------------------------------------------------------
DROP TABLE `students`;
CREATE TABLE `students`(
`student_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30)
);
# ALTER TABLE `models` AUTO_INCREMENT = 1;

INSERT INTO `students`(`name`)
VALUES
('Mila'),
('Toni'),
('Ron');

CREATE TABLE `exams`(
`exam_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (30)
);
ALTER TABLE `exams` AUTO_INCREMENT = 101;

INSERT INTO `exams` (`name`)
VALUES
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

drop TABLE students_exams;
CREATE TABLE `students_exams` (
	`student_id` INT,
    `exam_id` INT,
    PRIMARY KEY (`student_id`, `exam_id`),
    CONSTRAINT fk_students_exams_students
    FOREIGN KEY (`student_id`)
    REFERENCES `students`(`student_id`),
    CONSTRAINT fk_students_exams_exams
    FOREIGN KEY (`exam_id`)
    REFERENCES `exams`(`exam_id`)
);

INSERT INTO `students_exams`
VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

## 4.Self-Referencing -------------------------------------------------------------------------------------

CREATE TABLE `teachers` (
	`teacher_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30),
    `manager_id` INT
);

ALTER TABLE `teachers` AUTO_INCREMENT = 101;

INSERT INTO `teachers` (`name`, `manager_id`)
VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101);

ALTER TABLE `teachers`
ADD CONSTRAINT fk_teachers_manager_id
FOREIGN KEY (`manager_id`)
REFERENCES `teachers`(`teacher_id`);

#5.	Online Store Database -------------------------------------------------------------------------------------------
CREATE TABLE `cities`(
`city_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50)
);

CREATE TABLE `customers`(
`customer_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (50),
`birthday` DATE,
`city_id` INT,
CONSTRAINT fk_customers_cities
FOREIGN KEY (`city_id`)
REFERENCES `cities`(`city_id`)
);

CREATE TABLE `orders`(
`order_id` INT PRIMARY KEY AUTO_INCREMENT,
`customer_id` INT,
CONSTRAINT fk_customers_orders
FOREIGN KEY (`customer_id`)
REFERENCES `customers` (`customer_id`)
);

CREATE TABLE `item_types`(
`item_type_id` int PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (50)
);

CREATE TABLE `items` (
`item_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50),
`item_type_id` INT,
CONSTRAINT fk_items_item_types
FOREIGN KEY (`item_type_id`)
REFERENCES item_types (`item_type_id`)
);

CREATE TABLE `order_items`(
`order_id` INT  AUTO_INCREMENT,
`item_id` INT,
	CONSTRAINT pk_agenda
	PRIMARY KEY (`order_id`, `item_id`),
    CONSTRAINT fk_items_order_items
    FOREIGN KEY (`item_id`)
    REFERENCES `items`(`item_id`),
    CONSTRAINT fk_items_order_orders
    FOREIGN KEY (`order_id`)
    REFERENCES `orders`(`order_id`)
);

# 6 6.	University Database -----------------------------------------------------------------------

CREATE TABLE `majors`(
`major_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (50)
);



CREATE TABLE `students`(
	`student_id` INT PRIMARY KEY AUTO_INCREMENT,
    `student_number` VARCHAR(12),
    `student_name` VARCHAR(50),
	`major_id` INT,
    CONSTRAINT fk_students_majors
    FOREIGN KEY (`major_id`)
    REFERENCES `majors` (`major_id`)
);

CREATE TABLE `subjects`(
`subject_id` INT PRIMARY KEY AUTO_INCREMENT,
`subject_name` VARCHAR(50)
);

CREATE TABLE `agenda`(
	`student_id` INT,
    `subject_id` INT,
    # CONSTRAINT pk_agenda
    PRIMARY KEY (`student_id`, `subject_id`),
    CONSTRAINT fk_agenda_students
    FOREIGN KEY (`student_id`)
    REFERENCES `students`(`student_id`),
    CONSTRAINT fk_agenda_subjects
    FOREIGN KEY (`subject_id`)
    REFERENCES `subjects`(`subject_id`)
);


CREATE TABLE `payments`(
	`payment_id` INT PRIMARY KEY AUTO_INCREMENT,
    `payment_date` DATE,
    `payment_amount` DECIMAL(8,2),
    `student_id` INT,
    CONSTRAINT fk_payments_students
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`student_id`)
);

#9  ---------------------------------------------------------------------------------------------
USE geography;

SELECT `mountain_range`, `peak_name`, `elevation` AS 'peak_elevation'
FROM `mountains` AS m
JOIN `peaks` AS p
ON p.`mountain_id` = m.`id`
WHERE `mountain_range` = 'Rila'
ORDER BY `peak_elevation` DESC;








