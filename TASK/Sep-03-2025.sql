select * from employees where name like 'A%';

select * from employees where city like '%San%';

select * from employees where city like '%a';

select department,count(id) from employees
group by department having count(id) >2 
order by avg(salary) desc;