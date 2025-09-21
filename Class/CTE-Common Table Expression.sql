with x as 
(select department_id,group_concat(name) 
	from employees 
	group by department_id)
select * from x;

 -- It Supports Both DDL,DML
with average_salary as
(select avg(salary) salary from employees)
select * from employees,average_salary 
where employees.salary > average_salary.salary;

select * from employees;


with sumofsalaryeach as
(select department_id,sum(salary) as sumsalary from employees group by department_id)
select * from employees,sumofsalaryeach
where employees.department_id = sumofsalaryeach.department_id and
employees.salary < sumofsalaryeach.sumsalary; 



select * from order_details;

select * from product_details;

select * from customers;

select * from customers where cust_id in(
with a as
	(with customer_order as
		(select c.cust_id,c.cust_name,c.cust_email,o.product_id 
		from customers c,order_details o where
		c.cust_id = o.customer_Id
		)
select c.*,p.product_name from customer_order c,product_details p where c.product_id = p.product_id)
select cust_id from a group by cust_id having count(cust_id) >2) ;


with recursive Num as(
select 1 as n
union all
select n+1 from Num where n<5
)
select * from Num;

