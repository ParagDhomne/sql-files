-- SQL PRACTICE QUESTIONS (Oracle)
-- Table: HR.EMPLOYEES

-- Columns:
-- employee_id, first_name, last_name, email, phone_number,
-- hire_date, job_id, salary, commission_pct, manager_id, department_id


-- SECTION A: BASIC SELECT & WHERE

-- Q1: Display all details of employees.
   
   SELECT * FROM HR.EMPLOYEES;

-- Q2: Display first_name, last_name, and salary of employees whose salary is greater than 10000.

   SELECT first_name, Last_name, salary from hr.employees
   WHERE salary>10000;

-- Q3: Display employees working in department 90.
   
   SELECT * FROM HR.EMPLOYEES 
   WHERE DEPARTMENT_ID IN(90);

-- Q4: Display employees whose salary is between 5000 and 12000.
   
   SELECT * FROM HR.EMPLOYEES 
   WHERE SALARY BETWEEN 5000 AND 12000;


-- SECTION B: ORDER BY & ROWNUM

-- Q5: Display employees ordered by salary in descending order.

   SELECT * FROM HR.EMPLOYEES
   ORDER BY SALARY DESC;
   
-- Q6: Display top 5 highest-paid employees.

   select * from
      (
          select * from HR.EMPLOYEES
          order by salary desc
       )
   where rownum <= 5;

-- Q7: Display lowest 3 paid employees.
 
   select * from
      (
          select * from HR.EMPLOYEES
          order by salary
       )
   where rownum <= 3;

-- SECTION C: ARITHMETIC OPERATORS

-- Q8: Display first_name and annual salary of employees.

   SELECT FIRST_NAME ,SALARY*12 AS ANNUAL_SALARY FROM HR.EMPLOYEES;
   
-- Q9: Display first_name and salary after 20% increment.

   SELECT FIRST_NAME, SALARY*1.2 as incremental_salary from hr.employees;

-- Q10: Display first_name and daily salary (assume 30 days).

   select first_name, salary/30 as daily_salary from hr.employees;

-- SECTION D: NVL & NULL HANDLING

-- Q11: Display first_name and commission.If commission is NULL, display 0.

   select first_name, nvl(commission_pct,0) as commission from hr.employees;

-- Q12: Display employees who do not receive commission.

   select * from hr.employees
   where commission_pct is null;

-- SECTION E: CONCATENATION & LIKE

-- Q13: Display output like: "Steven King earns 24000"
   
    select first_name ||' '|| Last_name ||' earns '|| salary as display from hr.employees
    where employee_id=100; 

-- Q14: Display employees whose first name starts with 'S'.

   select * from hr.employees
   where first_name like 'S%';

-- Q15: Display employees whose last name ends with 'n'.

   select * from hr.employees
   where Last_name like '%n';

-- SECTION F: DATE FUNCTIONS

-- Q16: Display employees who were hired in the year 2005.

   select * from hr.employees
   where hire_date between to_date('01/01/2005','dd/mm/yyyy') and to_date('31/12/2005','dd/mm/yyyy');

-- Q17: Display first_name and number of months completed in the company.

   select First_name, months_between(sysdate,hire_date) as months_completed from hr.employees;

-- Q18: Display employees who joined in the last 3 years.

   select * from hr.employees 
   WHERE hire_date >= ADD_MONTHS(SYSDATE, -36);

-- SECTION G: DML (WRITE ONLY - DO NOT EXECUTE)

-- Q19: Write an INSERT statement to add a new employee.

   insert into hr.employees values(207,'Parag','Dhomne','pdhomne','9049067962','Engineer',20000,5,101,10);

-- Q20: Increase salary by 10% for employees in department 50.
   
   update hr.employee
   set salary=salary*1.1
   where department_id =50;

-- Q21: Delete employees whose salary is less than 4000.

   delete from employees 
   where salary<4000;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- CONSTRAINTS PRACTICE QUESTIONS (Oracle)

-- Q1:
-- Create a table STUDENTS with:
-- student_id as PRIMARY KEY
-- student_name NOT NULL
-- age should be greater than or equal to 18

      CREATE TABLE STUDENTS
      (
             Student_id number CONSTRAINT PK_STU_ID PRIMARY KEY,
             Student_name varchar2(50) CONSTRAINT NN_STU_NAME NOT NULL,
             Age NUMBER CONSTRAINT chk_age CHECK(AGE>=18)     
      );

-- Q2:
-- Create a table COURSES with:
-- course_id as PRIMARY KEY
-- course_name UNIQUE

        CREATE TABLE COURSES
        (
               COURSE_ID NUMBER CONSTRAINT PK_COURSE_ID PRIMARY KEY,
               COURSE_NAME VARCHAR2(50) CONSTRAINT U_COURSE_NAME UNIQUE
         );
               
-- Q3:
-- Create a table ENROLLMENTS with:
-- enroll_id as PRIMARY KEY
-- student_id as FOREIGN KEY referencing STUDENTS(student_id)
-- If a student is deleted, all related enrollments should be deleted automatically

        CREATE TABLE ENROLLMENTS
        (
               ENROLL_ID number CONSTRAINT PK_EN_ID PRIMARY KEY,
               STUDENT_ID NUMBER,
               CONSTRAINT FK_STU_ID FOREIGN KEY(STUDENT_ID) REFERENCES STUDENTS(STUDENT_ID)
               ON DELETE CASCADE
        );

-- Q4:
-- Alter STUDENTS table and add a CHECK constraint
-- to ensure age is less than or equal to 60

        ALTER TABLE STUDENTS
        ADD CONSTRAINT CHK_AGE_UL CHECK (AGE<=60);
        
-- Q5:
-- Alter COURSES table and add NOT NULL constraint
-- on course_name

         ALTER TABLE COURSES
         MODIFY COURSE_NAME NOT NULL ;

-- Q6:
-- Drop the CHECK constraint on age from STUDENTS table

        ALTER TABLE students
        DROP CONSTRAINT chk_age_ul;

-- Q7:
-- Insert a record into STUDENTS table that violates
-- the CHECK constraint on age (for practice only)

         INSERT INTO STUDENTS VALUES(101,'PARAG',16)

-- Q8:
-- Explain (in one line):
-- What happens if we try to delete a student record
-- that has enrollments and ON DELETE CASCADE is NOT used?

        

            
