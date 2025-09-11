USE HR;

-- Table Setup
-- Students(StudentID, Name, Email, City, JoinDate)
			create table students(
			StudentId Int primary key,
			Name varchar(60),
			Email varchar(90),
			City varchar(100),
			JoinDate date
			);
            
-- Courses(CourseID, Title, Category, Price)
			create table Courses(
			CourseID Int primary key,
			Title varchar(50),
			Category varchar(50),
			Price decimal(10,2)
			);
            
-- Enrollments(EnrollID, StudentID, CourseID, EnrollDate, Status)
		create table Enrollments(
		EnrollID Int primary key,
		StudentID Int references students(Student_id), 
		CourseID Int references courses(CourseId), 
		EnrollDate Date, 
		Status varchar(32)
		);
        
-- Payments(PaymentID, StudentID, Amount, PayDate)
			create table Payments(
			PaymentID Int primary key,
			StudentID Int references Students(StudentId),
			Amount decimal(10,2), 
			PayDate date
			);
            
-- Tables : Students,Courses,Enrollments,Payments
-- 1.Add a new student who joined today.
			INSERT INTO Students (StudentID, Name, Email, City, JoinDate) VALUES
			(1001, 'John Doe', 'john.doe@example.com', 'New York', '2023-01-15'),
			(1002, 'Jane Smith', 'jane.smith@example.com', 'Los Angeles', '2023-03-22'),
			(1003, 'Samuel Lee', 'samuel.lee@example.com', 'Chicago', '2023-05-10'),
			(1004, 'Emily White', 'emily.white@example.com', 'San Francisco', '2023-06-18'),
			(1005, 'Michael Brown', 'michael.brown@example.com', 'Miami', '2023-02-28'),
			(1006, 'Sarah Johnson', 'sarah.johnson@example.com', 'Boston', '2023-04-11');
            
-- 2.Insert 3 new courses into the Courses table
			insert into courses values
			(101,'Java','Programming Language',40000),
			(102,'Python','Programming Language',50000),
			(103,'SQL','Programming Language',10000);
            
-- 3.A student enrolls in 2 courses — insert into Enrollments.
			INSERT INTO Enrollments (enrollid,StudentID, CourseID, EnrollDate, Status)
			VALUES
			(1,1001, 101, CURDATE(), 'Enrolled'),
			(2,1001, 103, CURDATE(), 'Enrolled');
            
-- 4.Record a payment for a student in the Payments table.
			INSERT INTO Payments (paymentID,StudentID, Amount, PayDate)
			VALUES (11,1001, 99.99, CURDATE());
        
-- 5.Insert multiple rows of students in a single query.
			INSERT INTO Students (StudentID, Name, Email, City, JoinDate) VALUES
			(1001, 'John Doe', 'john.doe@example.com', 'Chennai', '2023-01-15'),
			(1002, 'Jane Smith', 'jane.smith@example.com', 'Chennai', '2023-03-22'),
			(1003, 'Samuel Lee', 'samuel.lee@example.com', 'Coimbatore', '2023-05-10'),
			(1004, 'Emily White', 'emily.white@example.com', 'Coimbatore', '2023-06-18'),
			(1005, 'Michael Brown', 'michael.brown@example.com', 'Trichy', '2023-02-28'),
			(1006, 'Sarah Johnson', 'sarah.johnson@example.com', 'Trichy', '2023-04-11');

-- 6.Update a student’s city from Chennai to Bangalore.
			update students set city = 'Bangalore' where city = 'Chennai';
            
-- 7.Increase the price of all Programming courses by 10%.
			update courses set price=price+(price*10)/100;
            
-- 8. Update enrollment status to Completed for a student who finished a course.
			UPDATE ENROLLMENTS SET STATUS = 'COMPLETED' WHERE STUDENTID = 1001;
            
-- 9.Correct a wrongly typed student email.
			UPDATE STUDENTS SET EMAIL ='ABC@GMAIL.COM' WHERE STUDENTID = 1001;
            
-- 10.Delete a student who requested account removal.
			DELETE FROM STUDENTS WHERE STUDENTID = 1002;
            
-- 11.Delete all enrollments for a specific course.
			DELETE FROM ENROLLMENTS WHERE COURSEID = 101;
            
-- 12.Truncate the Payments table before re-importing fresh data.
			TRUNCATE TABLE PAYMENTS;
            
-- 13.Add a new column PhoneNumber to the Students table.
			ALTER TABLE STUDENTS ADD COLUMN PHONENUMBER BIGINT;
            
-- 14.Drop the Payments table (assume migrating to another system)
			DROP TABLE PAYMENTS;
            
-- 15.Find the total number of students enrolled in all courses.
			SELECT COUNT(*) FROM STUDENTS;
            
-- 16.Calculate the average price of courses by category.
			SELECT AVG(PRICE) FROM COURSES GROUP BY CATEGORY;
            
-- 17.Get the highest payment made by any student.
			SELECT * FROM STUDENTS WHERE STUDENTID = (SELECT STUDENTID FROM PAYMENTS WHERE AMOUNT = (SELECT MAX(AMOUNT) FROM PAYMENTS));
            
-- 18.Find students who enrolled in more than 2 courses.
			SELECT STUDENTID FROM ENROLLMENTS GROUP BY STUDENTID HAVING COUNT(COURSEID)>2;
            
-- 19.List courses that no one has enrolled in (use NOT IN subquery).
			SELECT TITLE FROM COURSES WHERE COURSEID NOT IN(SELECT COURSEID FROM ENROLLMENTS GROUP BY COURSEID);
            
-- 20.Find the student who paid the maximum amount (nested subquery).
			SELECT * FROM STUDENTS WHERE STUDENTID = (SELECT STUDENTID FROM PAYMENTS WHERE AMOUNT = (SELECT MAX(AMOUNT) FROM PAYMENTS));

-- 21.Write a stored procedure to add a new student (with Name, Email, City).
			DELIMITER $$
			CREATE PROCEDURE ADD_STUDENTS(IN NAME VARCHAR(50),IN EMAIL VARCHAR(50),IN CITY VARCHAR(50))
			BEGIN
				DECLARE STUDENTID1 INT;
				SELECT MAX(STUDENTID) INTO STUDENTID1 FROM STUDENTS;
				SET STUDENTID1 = STUDENTID1+1;
				INSERT INTO STUDENTS VALUES(STUDENTID1,NAME,EMAIL,CITY,current_datE);
			END $$
			DELIMITER ;
			CALL ADD_STUDENTS('PRAVEEN KUMAR','PRAVEEN@GMAIL.COM','PUDUKKOTTAI');
    
-- 22.Write a stored procedure that takes StudentID and returns all courses enrolled by that student.
			DELIMITER $$
			CREATE PROCEDURE COURSE_ENROLLMENT_DETAILS(IN STUDENTID1 INT)
			BEGIN
				SELECT TITLE FROM COURSES WHERE COURSEID IN (SELECT COURSEID FROM ENROLLMENTS WHERE STUDENTID = STUDENTID1);
			END $$
			DELIMITER ;
			DROP procedure COURSE_ENROLLMENT_DETAILS;
			CALL COURSE_ENROLLMENT_DETAILS(1002);
-- 23.Create a trigger on Enrollments that automatically updates Status = 'Active' when a new row is inserted.
			DELIMITER $$
			CREATE TRIGGER ENROLLMENT_STATUS AFTER INSERT ON ENROLLMENTS FOR EACH ROW
			BEGIN
				UPDATE ENROLLMENTS SET STATUS = 'ACTIVE' WHERE STUDENTID = NEW.STUDENTID;
			END $$
			DELIMITER ;
    
-- 24.Create a trigger on Payments that prevents inserting negative amounts.
			DELIMITER $$
			CREATE TRIGGER PAYMENTS_PREVENTS AFTER INSERT ON PAYMENTS FOR EACH ROW
			BEGIN
				IF NEW.AMOUNT<=0 THEN
					DELETE FROM PAYMENTS WHERE PAYMENTID = NEW.STUDENTID;
				END IF;
			END $$
			DELIMITER ;
			DROP TRIGGER PAYMENTS_PREVENTS;
			INSERT INTO PAYMENTS VALUES(14,1004,-300,current_date);


-- 25: Mixed Complex Scenario
-- A student deletes their account →
-- •	Delete them from Students.
-- •	Delete related Enrollments and Payments.
-- •	Log the deleted student into an Archive_Students table using a trigger.
			DELIMITER $$
				CREATE PROCEDURE DELETE_STUDENT_DETAILS(IN STUDENTID1 INT)
				BEGIN
					DELETE FROM ENROLLMENTS WHERE STUDENTID = STUDENTID1;
					DELETE FROM PAYMENTS WHERE STUDENTID = STUDENTID1;
				END $$
				DELIMITER ;

				DELIMITER $$
				CREATE TRIGGER DELETE_BACKUP AFTER DELETE ON STUDENTS FOR EACH ROW
				BEGIN
					CALL DELETE_STUDENT_DETAILS(OLD.STUDENTID);
					INSERT INTO  STUDENT_DELETE_BACKUP VALUES(OLD.STUDENTID,OLD.NAME,OLD.EMAIL,OLD.CITY,current_timestamp);
				END $$
				DELIMITER ;
				
				CREATE TABLE STUDENT_DELETE_BACKUP(
				STUDENTID INT,
				NAME VARCHAR(50),
				EMAIL VARCHAR(60),
				CITY VARCHAR(30),
				DELETED_DATEANDTIME datetime
				);
				DELETE FROM STUDENTS WHERE STUDENTID = 1001;
				SELECT * FROM STUDENT_DELETE_BACKUP;