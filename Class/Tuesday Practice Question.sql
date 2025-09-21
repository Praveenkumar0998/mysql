use hr;
-- 1. GROUP_CONCAT() 
	-- 1. List all subjects each student has enrolled in as a single row.
		select name,group_concat(title) from
		(select Name,title from enrollments e,students s,courses c where e.studentId = s.studentId
		and e.courseId = c.courseId) final group by name;

	-- 2. Show all department names each employee has worked in (comma separated). 
		SELECT D.DEPARTMENT_NAME,group_concat(NAME) FROM EMPLOYEES E,DEPARTMENTS D WHERE
		E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY E.DEPARTMENT_ID;

	-- 3. Concatenate all phone numbers of each customer separated by ;. 
		SELECT CUST_NAME,group_concat(CUST_PHONE separator ';') FROM CUSTOMERS GROUP BY CUST_NAME;

	-- 4. Display a list of all product names under each category.
		SELECT CATEGORY,group_concat(PRODUCT_NAME) FROM PRODUCT_DETAILS GROUP BY CATEGORY;

	-- 5. Combine all cities where a supplier delivers into a single string. 
		SELECT NAME,group_concat(CITY_NAME) FROM DELIVERY_DETAILS GROUP BY NAME;
		

-- 2. TRIM() 
	-- 6. Remove extra spaces before and after employee names in the employee table.
		SELECT TRIM(NAME) FROM EMPLOYEES;
        
	-- 7. Clean up email addresses where users have mistakenly added spaces. 
		SELECT TRIM(USER_EMAIL) FROM USERS;
        
	-- 8. Show names after trimming only leading spaces. 
		SELECT TRIM(LEADING FROM NAME) FROM EMPLOYEES;
        
	-- 9. Show names after trimming only trailing spaces.
		SELECT TRIM(TRAILING FROM NAME) FROM EMPLOYEES;
        
	-- 10. Remove # characters from both sides of a string. 
		SELECT TRIM(BOTH FROM NAME) FROM EMPLOYEES;
        

-- 3. ROW_NUMBER()
	-- 11. Assign a unique row number to employees ordered by salary.
		SELECT row_number() OVER(ORDER BY SALARY) ENO,E.* FROM EMPLOYEES E;
        
	-- 12. Within each department, number employees based on their hire date. 
		SELECT row_number() OVER(PARTITION BY DEPARTMENT_ID ORDER BY HIRE_DATE) SNO,EMPLOYEES.* FROM EMPLOYEES;
        
	-- 13. List the top 3 earners in each department using row numbers. 
		SELECT ROW_NUMBER() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC) SNO,EMPLOYEES.* FROM EMPLOYEES;
        
	-- 14. Generate sequential numbers for students ordered by marks. 
		SELECT ROW_NUMBER() OVER(ORDER BY STUDENT_MARKS DESC) AS SNO,STUDENTS.* FROM STUDENTS;
        
	-- 15. Rank orders in each region by order amount. 
		SELECT row_number() OVER(PARTITION BY region ORDER BY amount desc) from order_tables;
       

-- 4. VIEW 
	-- 16. Create a view that shows only employees with salary greater than 50,000.
		create or replace view greater_salary as select * from employees where salary > 50000;
	-- 17. Create a view for students who scored more than 80 in exams.
		create or replace view more_marks as select * from students where mark > 80;
	-- 18. Create a view that displays all products out of stock.
		create or replace view outofstock as select * from products where products_available <=0;
	-- 19. Create a view that joins orders and customers for quick access. 
		create or replace view orders_customer_details as select * from orders o,customers c where o.customer_id = c.customer_id;
	-- 20. Create a view to show monthly sales summary.
		create or replace view sales_summary as
		select month(ordered_date) Month, count(product_id) Total_Sales,sum(unit_Price) as TotalRevenue,avg(product_id) Average_sale from order_details group by month(ordered_date);
        
        
-- 5. NTILE(n)
	-- 21. Divide employees into 4 performance groups based on salary.
		select ntile(4) over(order by salary desc) group_,employees.* from employees;
    -- 22. Assign students into 3 grade buckets based on marks. 
		select ntile(3) over(order by Marks desc),students.* from students;
	-- 23. Split salespeople into 5 groups according to sales value. 
		-- Columns : Name, ID, Sales_amount TableName: Sales
        select ID,Name,total_sales,ntile(5) over(order by total_sales desc) from sales;
	-- 24. Divide marathon runners into quartiles based on completion time.
		-- Columns : Name,CompletionTime Table: Marathon Results
		select ntile(4) over(order by completionTime) Group_,Name from employees;
	-- 25. Classify customers into 2 halves: high spenders and low spenders. 
		select ntile(2) over(order by amount) group_,tab1.* from
		(Select customer_id,sum(unit_price) as amount from order_details group by customer_id) tab1;

-- 6. REPLACE()
	-- 26. Replace all occurrences of "colour" with "color" in a product description.
		select replace('Hii this is Colour','Colour','color') Replaced_String from dual;
	-- 27. Replace dashes - with slashes / in date strings. 
		select replace('hii iam Praveen Kumar BE-CSE','-','/') Replaced_String;
	-- 28. Replace old company name with new one in the clients table. 
		select replace('SLA Institiute','SLA','SAL') Replaced_String;
	-- 29. Replace spaces with underscores in usernames
		select replace(name,' ','_') from employees;
	-- 30. Replace "N/A" with NULL in the data column. 
		select replace(null,null,'N/A'); -- Doubt
 

 -- 7. LPAD() / RPAD() 
	-- 31. Pad employee IDs with leading zeros to make them 6 digits.
		select lpad(emp_id,6,0) from employees;
	-- 32. Right-pad customer names with * to make them 15 characters long. 
		select rpad(name,15,'*') from employees;
	-- 33. Display order numbers with leading ORD- prefix using LPAD. 
		select lpad(order_id,5,'ORD-') from order_details;
	-- 34. Format account numbers so they are always 10 digits (with LPAD). 
		select lpad(account_number,10,0) from account_details;
	-- 35. Pad invoice numbers with trailing # until they reach length 12. 
		select Lpad(Invoice_Number,12,'#') from Customer_Invoice;
	
-- 8. SUBSTRING() 
	-- 36. Extract the first 3 letters of each employee name. 
		select substr(name,1,3) from employees;
	-- 37. Show last 4 digits of each phone number. 
		select substr(Phone_number,-4) from customers;
    -- 38. Display the middle 2 characters of product codes.
		select substr(Product_codes,length(Product_codes)/2,2) from product_Details;
	-- 39. Extract year from a date string using substring. 
		select substr('02/07/2004',-4) from dual;
	-- 40. Show initials of each employee (first letter of first name + last name). 
		select concat(substr(first_name,1,1),' ',last_name) from employees;