use hr;
-- 1. Find employees who earn more than the average salary.
select * from employees where salary > (select avg(salary) from employees);


-- 2. Find the employee(s) who earn the maximum salary
select * from employees e1 where salary = (select max(salary) from employees );


-- 3. Find employees who work in the same department as 'Alice'
select * from employees e1 where department_id =
(select department_id from employees where name ="Alice");


-- 4. Find employees who work in departments located in location 1700. (Use IN)
select * from employees where department_id in 
(select department_id from departments where location_id = 1700);


-- 5. Find employees whose salary is greater than ANY salary in department 20.
select * from employees where salary >
any(select salary from employees where department_id = 20);


-- 6. Find employees whose salary is greater than ALL salaries in department 20
select * from employees where salary >
all(select salary from employees where department_id = 20);


-- 7. Find employees whose salary matches any salary in department 10
select * from employees where salary =
any(select salary from employees where department_id = 10) ;


-- 8. Find employees whose salary is greater than the average salary of their own department. (Correlated Subquery)
select * from employees e1 where salary>
(select avg(salary) from employees e2 where e1.department_id = e2.department_id);


-- 9. Find employees who do not have any department assigned. (Use NOT EXISTS)
select * from employees e where 
not exists
(select department_id  from departments d where d.department_id = e.department_id);


-- 10. Find departments that have at least one employee earning more than 60,000. (EXISTS)
select * from employees e1 where exists
(select salary from employees e2 where e1.salary > 60000 and e1.department_id = e2.department_id);


-- 11. Add a column to show the department name next to each employee using a subquery in SELECT clause.
select(select department_name  from departments d where d.department_id=e.department_id) department_Name,e.* from employees e
where department_id in (select department_id from departments d where d.department_id = e.department_id);


-- 12. Find the second highest salary using a subquery
select max(salary) Maximum_Salary  from employees where salary not in (select max(salary) from employees);


-- 13. Find employees who work in the department with the highest average salary
select * from employees where department_id = 
(select department_id from employees group by department_id order by avg(salary) desc limit 1);


-- 14. Increase the salary by 10% for employees who work in the Sales department using a subquery in UPDATE.
update employees  set salary = salary+salary*0.10 where department_id =
(select department_id from departments where department_name = "Sales");


-- 15. Delete all employees who belong to departments located in location 1800 using a subquery in DELETE.
delete from employees where department_id 
in(select department_id from departments where location_id = 1800);


-- 16. Insert all HR department employees into a backup_employees table using a subquery in INSERT.
create table backup_employees as(select * from employees where department_id = 
(select department_id from departments where department_name = "HR"));