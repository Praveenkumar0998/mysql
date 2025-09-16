-- Scenario 1: A teacher wants a list of all subjects each student has enrolled in.
select name,group_concat(title) from 
(select s.Name,c.Title from students s,courses c,enrollments e 
where s.StudentId = e.StudentID and c.CourseID = e.CourseID) student group by name;

-- Scenario 2: Cleaning up user input (removing extra spaces).
select trim('  MySql  ') as Message;
 -- or
 select trim(name) from students;

-- Scenario 3: Ranking employees within each department.
select dense_rank() over(partition by department_id order by salary) as Employees_Rank,e.* from employees e;

-- Scenario 4: Create a view for reusable queries (high salary employees).
create or replace view HighSalary as
select * from employees e
where salary = (select max(salary) from employees);

-- Scenario 5: Divide students into 3 groups based on marks.
select ntile(3) over(order by marks),s.* from students s;

-- Scenario 6: Correct misspelled words in a product description.
select replace('Employees Number','Number','ID');

-- Scenario 7: Format employee IDs with leading zeros (LPAD) and right padding with stars (RPAD).
select trim(leading '0' from emp_id) from employees;
select trim(both '*' from emp_id) from employees;

-- Scenario 8: Extract first 3 letters of employee names.
select substr(name,1,3) from employees;
