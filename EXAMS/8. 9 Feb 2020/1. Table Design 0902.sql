CREATE DATABASE exam090220;
USE exam090220;

CREATE TABLE coaches(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(10) NOT NULL,
last_name VARCHAR(20) NOT NULL,
salary DECIMAL (10, 2) DEFAULT 0 NOT NULL,
coach_level INT DEFAULT 0 NOT NULL
);

CREATE TABLE countries(
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL
);

CREATE TABLE skills_data(
id INT PRIMARY KEY AUTO_INCREMENT,
dribbling INT DEFAULT 0,
pace INT DEFAULT 0,
passing INT DEFAULT 0,
shooting INT DEFAULT 0,
speed INT DEFAULT 0,
strength INT DEFAULT 0
);

CREATE TABLE towns(
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
country_id INT NOT NULL,
CONSTRAINT fk_towns_countries
 FOREIGN KEY(`country_id`)
 REFERENCES `countries`(`id`)
);

CREATE TABLE stadiums(
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
capacity INT NOT NULL,
town_id INT NOT NULL,
CONSTRAINT fk_towns_stadiums
 FOREIGN KEY(`town_id`)
 REFERENCES `towns`(`id`)
);

CREATE TABLE teams(
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
established DATE NOT NULL,      -- year and date => DATE !!
fan_base BIGINT NOT NULL DEFAULT 0,
stadium_id INT NOT NULL,
CONSTRAINT fk_teams_stadiums
 FOREIGN KEY(`stadium_id`)
 REFERENCES `stadiums`(`id`)
);

CREATE TABLE players(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(10) NOT NULL,
last_name VARCHAR(20) NOT NULL,
age INT DEFAULT 0,
position CHAR(1) NOT NULL,
salary DECIMAL(10,2) DEFAULT 0 NOT NULL,
hire_date DATETIME,                   -- exact time and date 
skills_data_id INT NOT NULL,
team_id INT,
CONSTRAINT fk_players_skills_data
 FOREIGN KEY(`skills_data_id`)
 REFERENCES `skills_data`(`id`),
 CONSTRAINT fk_players_teams
 FOREIGN KEY(`team_id`)
 REFERENCES `teams`(`id`)
);

CREATE TABLE players_coaches(
player_id INT,
coach_id INT,
CONSTRAINT fk_players_player_coaches
 FOREIGN KEY(`player_id`)
 REFERENCES `players`(`id`),
 CONSTRAINT fk_coaches_player_coaches
 FOREIGN KEY(`coach_id`)
 REFERENCES `coaches`(`id`)
);
