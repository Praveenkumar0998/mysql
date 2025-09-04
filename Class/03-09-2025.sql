use hr;

select * from employees;

alter table employees add column department varchar(20);

insert into employees values(3,'Prem Kumar','R',8745545523,20000);

update employees set department = 'DEV' where employee_id = 1;


select max(salary) from employees;


select min(salary) from employees;


select avg(salary) from employees;

select sum(salary) from employees;

select count(*) from employees where department = 'Dev';


select * from employees where department = 'Dev' and salary >= 10000;
select * from employees where department = 'Dev' or salary >= 10000;

select * from employees where not department = 'Dev';

select * from employees where salary between 5000 and 20000;

select * from employees limit 1;


delimiter $$
create function discount(price decimal(10,2),discount_perc decimal(10,2))
returns decimal(10,2)
deterministic
begin
declare Discount_price decimal(10,2);
declare discount_amount decimal(10,2);
set discount_price = (price*discount_perc)/100;
set discount_amount = price-discount_price;
return discount_amount;
end;
$$ delimiter ;

select discount(10000.32,10.00) from dual;


drop function discount;

use hr;
select department from employees group by department;

select * from employees order by employee_id desc;


