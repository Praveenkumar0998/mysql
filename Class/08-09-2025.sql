use hr;
select * from employees;

select * from departments;

select * from employees where department_id in(select department_id from departments where employees.department_id = departments.department_id);

select employees.*,departments.department_name from 
(select * from employees e1 where salary > 
(select avg(salary) from employees e2 where e1.department_id = e2.department_id)) employees,
departments where employees.department_id = departments.department_id;



select * from employees e1 where (department_id,salary) IN
(select department_id,salary from employees e2 where salary>=60000);



select (select department_name from departments where e1.department_id = departments.department_id) department_name,
e1.* from employees e1 where salary > (select avg(salary) from employees e2 where
e1.department_id = e2.department_id);

select * from employees e1 where salary >
all(select salary from employees e2 where department_id =20);




select * from employees where salary > any(40000,60000);


select * from employees where salary >all
(select avg(salary) from employees group by department_id);

select department_id from departments where location_id = 1700;

select * from employees where department_id in
(select department_id from departments where location_id = 1700);

select * from employees e1 where exists
(select department_id from departments d 
where d.department_id = e1.department_id);





