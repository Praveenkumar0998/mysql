select * from employee where salary >
(select avg(salary) from employee);

select max(salary) from employee where salary < 
(select max(salary) from employee);

SELECT
(SELECT MAX(SALARY1) FROM 
   (SELECT AVG(SALARY) AS SALARY1 
    FROM EMPLOYEE 
	GROUP BY DEPARTMENT_ID
	HAVING SALARY1 > 50000) NAME) AS AVERAGE_MAX
FROM DUAL;
    
    
DROP TABLE 
EMPLOYEE;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location_id INT
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


INSERT INTO departments (department_id, department_name, location_id) VALUES
(10, 'HR', 1700),
(20, 'Sales', 1700),
(30, 'IT', 1800);

INSERT INTO employees (emp_id, name, salary, department_id) VALUES
(101, 'John', 50000, 10),
(102, 'Alice', 60000, 20),
(103, 'Bob', 45000, 30),
(104, 'Emma', 70000, 20),
(105, 'David', 55000, 10);


SELECT * FROM EMPLOYEES;

SELECT * FROM DEPARTMENTS;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN
(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE LOCATION_ID = 1700);




SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (
SELECT DEPARTMENT_ID FROM DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID);










