/*Q1.
Write a query to display employee full name (first_name + last_name), department_id, and total income.
Total income = salary + commission.
If commission is NULL, treat it as 0.
Sort the result by total income in descending order.*/

SELECT FIRST_NAME ||' '|| LAST_NAME AS FULL_NAME, DEPARTMENT_ID, SALARY+NVL(COMMISSION_PCT,0) AS TOTAL_INCOME FROM HR.EMPLOYEES
ORDER BY SALARY+NVL(COMMISSION_PCT,0) DESC;

/*Q2.
Write a query to display employees who were hired in the last 24 months.*/

SELECT * FROM HR.EMPLOYEES
WHERE HIRE_DATE>=ADD_MONTHS(SYSDATE,-24);

/*Q3.
Write a query to display employees whose first name starts with 'A' and has at least 5 characters.*/

SELECT * FROM HR.EMPLOYEES
WHERE FIRST_NAME LIKE'A____%';

/*Q4.
Write a query to display employee details in the following format:
"Steven King works in department 90"*/

SELECT FIRST_NAME ||' '|| LAST_NAME ||' works in department '||department_id as display from hr.employees
WHERE employee_id=100;

/*Q5.
Write a query to display employees who do not receive any commission.*/

SELECT * FROM HR.EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

/*Q6.
Write a query to display employee full name and number of years they have worked in the company (rounded to 2 decimal places).*/



/*Q7.
Write a query to display employees whose first name contains 'sh' anywhere, ignoring case sensitivity.*/

SELECT * FROM HR.EMPLOYEES 
WHERE FIRST_NAME LIKE'%sh%' OR FIRST_NAME LIKE 'Sh%';

/*Q8.
Write a query to display employees who earn more than the average salary of all employees.*/



/*Q9.
Write a query to display the top 3 highest paid employees.*/

SELECT * FROM 
       ( 
         SELECT * FROM HR.EMPLOYEES 
         ORDER BY SALARY DESC
        )
WHERE ROWNUM<=3;        

/*Q10.
Write a query to display the second highest salary from HR.EMPLOYEES.*/

SELECT * FROM 
       ( 
         SELECT * FROM HR.EMPLOYEES 
         ORDER BY SALARY DESC
        )
WHERE ROWNUM=2;  
SELECT * FROM HR.EMPLOYEES
SELECT * FROM HR.DEPARTMENTS

/*Q11.
Write a query to display employee full name, department name, and location_id.
If location_id is NULL, display 'Not Assigned'.*/
  
SELECT FIRST_NAME ||' '|| LAST_NAME AS FULL_NAME FROM HR.EMPLOYEES 
AND
SELECT DEPARTMENT_NAME, NVL(LOCATION_ID,0)AS LOCATION_ID FROM HR.DEPARTMENTS;
  
/*Q12.
Write a query to display the first 5 employees sorted by salary in descending order.*/

SELECT * FROM
(
SELECT * FROM HR.EMPLOYEES
ORDER BY SALARY DESC
)
WHERE ROWNUM<=5;

/*Q13.
Write a query to increase salary by 10 percent for employees earning less than 5000.

 alter table hr.employees
 set salary=salary*1.1 where salary <5000;

Q14.
Write a query to delete employees who were hired before 01-JAN-2005.

  delete from hr.employees 
  where hire_date <= to_date('01/jan/2005','dd/mon/yyyy');

Q15.
Write a query to update the salary of only one specific row using ROWID.

Q16.
Write a query to display top 5 employees with the following details:
employee full name, department name, years of experience, total income

Conditions:

hired after 01-JAN-2010

total income = salary + commission (NULL commission treated as 0)

sorted by total income in descending order

Q17.
Explain why the following query gives incorrect output and write the correct query:

SELECT first_name, salary
FROM hr.employees
WHERE ROWNUM <= 3
ORDER BY salary DESC;

Q18.
Explain the difference between ROWNUM and ROWID with a real-life example.

Q19.
Write a query to display employees who were hired in the same year as their manager.

Q20.
Write a query to display employees whose salary is between 5000 and 10000
and department_id is either 50 or 80.
