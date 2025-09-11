use hr;
-- Salary Update Trigger With Procedure
delimiter $$
create trigger t1 
after update on employees for each row
begin
	call salary_update(old.emp_id,old.salary,new.salary);
end $$
delimiter ;

delimiter $$
create procedure salary_update(In empid int,In Old_salary int, In Current_Salary int)
begin
	if current_salary > old_salary then
		insert into update_salary_table values
        (empid,old_salary,current_salary,current_timestamp(),'Updated Sucessfully');
	else 
		insert into update_salary_table values
        (empid,old_salary,current_salary,current_timestamp(),'Current salary is lesser than old salary');
	end if;
end $$
delimiter ;
create table update_salary_table(
emp_id int,
Old_salary int,
Current_salary int,
Updated_on datetime,
Status varchar(100)
);
update employees set salary = 60000 where emp_id = 101;