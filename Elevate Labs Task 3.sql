SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT 
first_name,
last_name,
age,
(age + 10)*2
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT
gender,age
FROM parks_and_recreation.employee_demographics;


# WHERE CLAUSE
 SELECT *
 FROM employee_salary
 WHERE salary >50000;
 
SELECT
occupation,
first_name,
salary
FROM employee_salary
WHERE employee_id BETWEEN 1 AND 5;

SELECT * 
FROM employee_demographics
WHERE gender != 'male';

SELECT *
FROM employee_demographics
WHERE age>30 AND gender='female';

SELECT *
FROM employee_demographics
WHERE (employee_id=4 AND age>30) OR gender='female';

# group by
SELECT gender,avg(age)
from employee_demographics
GROUP BY gender;

SELECT occupation,salary
FROM employee_salary
GROUP BY occupation,salary
;

#order by
SELECT * 
FROM employee_demographics
ORDER BY gender,age DESC;

SELECT * 
FROM employee_demographics
ORDER BY 5,4;

#Subqueries
SELECT *
    FROM employee_demographics 
    where employee_id IN
					(	SELECT employee_id
						FROM employee_salary
						WHERE employee_id = 1); 
                        
	SELECT first_name,salary,
    (SELECT AVG(salary )
    from employee_salary) as sal_avg
    FROM employee_salary;
    
    
#aggregate functions
SELECT gender,max(age)
from employee_demographics
GROUP BY gender;

SELECT first_name,min(age)
from employee_demographics
GROUP BY first_name;

SELECT employee_id,count(age)
from employee_demographics
GROUP BY employee_id;


#views
CREATE VIEW view_employee_info AS
SELECT employee_id, first_name, last_name, age, gender
FROM employee_demographics; 
SELECT * FROM view_employee_info;

CREATE VIEW view_high_earners AS
SELECT first_name, last_name, occupation, salary
FROM employee_salary
WHERE salary > 60000;
SELECT * FROM view_high_earners;

CREATE VIEW view_department_salaries AS
SELECT s.dept_id, p.department_name, COUNT(*) AS total_employees, SUM(s.salary) AS total_salary
FROM employee_salary s
JOIN parks_departments p ON s.dept_id = p.department_id
GROUP BY s.dept_id, p.department_name;
SELECT * FROM view_department_salaries;


#Creating indexes to optimize
CREATE INDEX idx_age ON employee_demographics(age);
EXPLAIN SELECT * FROM employee_demographics WHERE age > 40;

CREATE INDEX idx_occupation ON employee_salary(occupation);
SHOW INDEX FROM employee_salary;

CREATE INDEX idx_first_name ON employee_demographics(first_name);
SHOW INDEX FROM employee_demographics;
