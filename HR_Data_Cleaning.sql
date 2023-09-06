-- Create a database
CREATE DATABASE projects;

USE projects;
SELECT * FROM hr;

-- Change column name and type
ALTER TABLE hr
CHANGE COLUMN id emp_id varchar(20) NULL;

-- Check the structure of the table
DESCRIBE hr;

SELECT birthdate FROM hr;

-- Change the format of the birthdate
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;


-- Change the type of birthdate
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Change the format of the hire_date
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;


SELECT hire_date FROM hr;

-- Change the type of hire_date
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- Change the format of the termdate
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate!= '', date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE true;

SELECT termdate FROM hr;

SET sql_mode='ALLOW_INVALID_DATES';

-- Change the type of termdate
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Add a new age column
ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR,birthdate,CURDATE());

SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT COUNT(*) FROM hr WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*) FROM hr WHERE termdate = '0000-00-00';

SELECT location FROM hr;






