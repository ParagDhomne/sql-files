
/* =========================================================
   ORACLE HR SCHEMA – SQL PRACTICE QUESTIONS
   ========================================================= */

/* Q1:
   Write a query to display the full name (first name + last name)
   of employees whose FIRST_NAME starts with the letter 'S'
   from the EMPLOYEES table.
*/

   SELECT EMPLOYEE_ID, SUBSTR(FIRST_NAME,1,1) ||'.'|| LAST_NAME AS FULL_NAME, SALARY, HIRE_DATE
   FROM HR.EMPLOYEES
   WHERE UPPER(FIRST_NAME) LIKE 'S%';
 
/* Q2:
   Find the highest, lowest, total, and average salary of all employees.
   Label the columns as Maximum, Minimum, Sum, and Average respectively.
   Round the values to the nearest whole number.
*/

   SELECT ROUND(MAX(SALARY)) MAXIMUM, ROUND(MIN(SALARY)) MINIMUM, ROUND(SUM(SALARY)) SUM, ROUND(AVG(SALARY)) AVERAGE 
   FROM HR.EMPLOYEES;

/* Q3:
   Display the following output using data from the EMPLOYEES table:

   Employee Details
   --------------------------------------------------------------------------------------
   King earns $24,000.00 monthly but wants $72,000.00.
   Kochhar earns $20,000.00 monthly but wants $60,000.00.
   De Haan earns $17,000.00 monthly but wants $51,000.00.
   Hunold earns $9,000.00 monthly but wants $27,000.00.
   Ernst earns $6,000.00 monthly but wants $18,000.00.
   Austin earns $4,800.00 monthly but wants $14,400.00.

   Hint: "wants" is three times the current salary.
*/

   SELECT LAST_NAME ||' earns $'|| SALARY ||' monthly but wants $'|| SALARY*3 EMPLOYEE_DETAILS
   FROM HR.EMPLOYEES;
    

/* Q4:
   Determine the number of managers in the company without listing them.
   Label the column as Number of Managers.
   Hint: Use the MANAGER_ID column from the EMPLOYEES table.
*/

   SELECT COUNT(MANAGER_ID) AS NUMBER_OF_MANAGERS
   FROM HR.EMPLOYEES;

/* Q5:
   Find the difference between the highest and lowest salaries.
   Label the column as DIFFERENCE.
*/

   SELECT MAX(SALARY)-MIN(SALARY) DIFFERENCE
   FROM HR.EMPLOYEES;
   
/* Q6:
   Display how many employees joined in each month.
   Hint: Use the HIRE_DATE column, group by month,
   and use the TO_CHAR function.
*/

   SELECT TO_CHAR(HIRE_DATE,'MONTH') MONTH, COUNT(*) NO_OF_EMPLOYEES_JOINED
   FROM HR.EMPLOYEES
   GROUP BY TO_CHAR(HIRE_DATE,'MONTH');
   

/* Q7:
   Display EMPLOYEE_ID, full name, and HIRE_DATE of employees
   who have more than 10 years of experience in the company.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME , HIRE_DATE 
   FROM HR.EMPLOYEES
   WHERE MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12 > 10;
   
/* Q8:
   Write a query to multiply salary with commission
   and calculate the average salary of employees.
   Hint: COMMISSION_PCT column contains NULL values.
*/
   
   SELECT EMPLOYEE_ID, 
          FIRST_NAME ||' '|| LAST_NAME FULL_NAME, 
          SALARY+SALARY*NVL(COMMISSION_PCT,0) AVERAGE_SALARY
          FROM HR.EMPLOYEES;

/* Q9:
   Write a query to display DEPARTMENT_ID and number of managers
   working under each department.
   Exclude records where DEPARTMENT_ID is NULL.
   Hint: Group by DEPARTMENT_ID.
*/

   SELECT DEPARTMENT_ID, 
          COUNT(MANAGER_ID) AS NO_OF_MANAGERS
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID IS NOT NULL
   GROUP BY DEPARTMENT_ID;

/* Q10:
   Display JOB_TITLE, number of employees working in each job,
   and number of managers performing that job.
   Hint: Use EMPLOYEES and JOBS tables.
*/
  
   SELECT J.JOB_TITLE, COUNT(E.EMPLOYEE_ID) EMPLOYEES , COUNT(DISTINCT E.MANAGER_ID) MANAGERS 
   FROM HR.EMPLOYEES E
   INNER JOIN HR.JOBS J
   ON E.JOB_ID=J.JOB_ID
   AND MANAGER_ID IS NOT NULL
   GROUP BY J.JOB_TITLE;----------REWIEW
 
/* Q11:
   Display employee full name padded with 10 asterisks (*)
   on both left and right sides.
*/

   SELECT LPAD( FIRST_NAME, LENGTH(FIRST_NAME)+10,'*') ||' '|| RPAD(LAST_NAME, LENGTH(LAST_NAME)+10,'*') EMPLOYEES_DETAILS
   FROM HR.EMPLOYEES;
    
/* Q12:
   Display the following output using the EMPLOYEES table:

   Employee Id | Last Name | Weeks | Months | Years
   -------------------------------------------------
   100         | King      | 24    | 166    | 14
   101         | Kochhar   | 20    | 139    | 12
   102         | De Haan   | 28    | 195    | 16
   103         | Hunold    | 19    | 136    | 11
   104         | Ernst     | 17    | 119    | 10
   105         | Austin    | 20    | 142    | 12

   Hint: Use MONTHS_BETWEEN function.
*/

    SELECT EMPLOYEE_ID, LAST_NAME, 
          ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/4) WEEKS,
          ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) MONTHS,
          ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) YEARS
    FROM HR.EMPLOYEES;
                  
/* Q13:
   Generate the following output using the EMPLOYEES table:

   Employee_ID | Full_Name        | Email              | Salary
   -----------------------------------------------------------------
   100         | Steven King      | sking@gmail.com    | $24,000.00
   101         | Neena Kochhar    | nkochhar@gmail.com | $20,000.00
   102         | Lex De Haan      | ldehaan@gmail.com  | $17,000.00
   103         | Alexander Hunold | ahunold@gmail.com  | $9,000.00
   104         | Bruce Ernst      | bernst@gmail.com   | $6,000.00
   105         | David Austin    | daustin@gmail.com  | $4,800.00
   106         | Valli Pataballa | vpatabal@gmail.com | $4,800.00
*/

   SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME, EMAIL||'@GMAIL.COM' EMAIL, '$'||SALARY SALARY
   FROM HR.EMPLOYEES;
   
/* Q14:
   Write a query to display JOB_ID and number of managers
   working under each job.
   Show only those jobs that have more than one manager.
*/

   SELECT JOB_ID, COUNT(DISTINCT MANAGER_ID) NO_OF_MANAGERS
   FROM HR.EMPLOYEES
   GROUP BY JOB_ID
   HAVING COUNT(DISTINCT MANAGER_ID) >1;
   
   
/* Q15:
   Display COUNTRY_NAME and number of employees working in each city,
   where the employee count is greater than 30.
   Hint: Use equi-joins between EMPLOYEES, DEPARTMENTS,
   LOCATIONS, and COUNTRIES tables.
*/
   
   SELECT C.COUNTRY_NAME, COUNT(E.EMPLOYEE_ID) AS NO_OF_EMP_IN_CITY
   FROM HR.COUNTRIES C
   INNER JOIN HR.LOCATIONS L
   ON C.COUNTRY_ID=L.COUNTRY_ID
   INNER JOIN HR.DEPARTMENTS D
   ON L.LOCATION_ID=D.LOCATION_ID
   INNER JOIN HR.EMPLOYEES E
   ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
   GROUP BY C.COUNTRY_NAME
   HAVING COUNT(E.EMPLOYEE_ID) >30;
   
   ---------------------------------
   
   SELECT L.CITY, COUNT(E.EMPLOYEE_ID) AS NO_OF_EMP_IN_CITY
   FROM HR.LOCATIONS L
   INNER JOIN HR.DEPARTMENTS D
   ON L.LOCATION_ID=D.LOCATION_ID
   INNER JOIN HR.EMPLOYEES E
   ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
   GROUP BY L.CITY
   HAVING COUNT(E.EMPLOYEE_ID) >30;
   

/* Q16:
   Display city names and number of departments located in each city.
   Exclude departments that do not have any employees.
*/

   SELECT L.CITY, COUNT(D.DEPARTMENT_ID) DEPARTMENTS_IN_CITY
   FROM HR.EMPLOYEES E
   INNER JOIN HR.DEPARTMENTS D
   ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
   INNER JOIN HR.LOCATIONS L
   ON L.LOCATION_ID=D.LOCATION_ID
   WHERE E.DEPARTMENT_ID IS NOT NULL
   GROUP BY L.CITY;

/* Q17:
   Display salary range and number of employees whose salary
   falls within that range.
   Hint: Use JOB_GRADES table, equi-join, and group by.
*/
---------NO SUCH TABLE

   SELECT '1000' AS Low_Sal, '2999' AS Hig_Sal, COUNT(*) AS Number_Of_Employees FROM hr.employees WHERE salary BETWEEN 1000 AND 2999
   UNION ALL
   SELECT '3000', '4999', COUNT(*) FROM hr.employees WHERE salary BETWEEN 3000 AND 4999
   UNION ALL
   SELECT '5000', '9999', COUNT(*) FROM hr.employees WHERE salary BETWEEN 5000 AND 9999
   UNION ALL
   SELECT '10000', '14999', COUNT(*) FROM hr.employees WHERE salary BETWEEN 10000 AND 14999
   UNION ALL
   SELECT '15000', '19999', COUNT(*) FROM hr.employees WHERE salary BETWEEN 15000 AND 19999
   UNION ALL
   SELECT '20000', '25000', COUNT(*) FROM hr.employees WHERE salary BETWEEN 20000 AND 25000;

/* Q18:
   Display year-wise employee joining count using the HIRE_DATE column.
   Hint: Use GROUP BY and TO_CHAR function.
*/

   SELECT TO_CHAR(HIRE_DATE,'YEAR') YEAR, COUNT(EMPLOYEE_ID) EMPLOYEE_JOINED
   FROM HR.EMPLOYEES
   GROUP BY TO_CHAR(HIRE_DATE,'YEAR');
   
   ---------------------------------------------------
   
   SELECT EXTRACT (YEAR FROM HIRE_DATE) YEAR, COUNT(EMPLOYEE_ID) EMPLOYEE_JOINED
   FROM HR.EMPLOYEES
   GROUP BY EXTRACT (YEAR FROM HIRE_DATE);
   

/* Q19:
   Display MANAGER_ID, manager full name, and number of employees
   working under them.
   Show only those managers who have more than 5 employees,
   and sort the result by MANAGER_ID.
*/

   SELECT E2.EMPLOYEE_ID  AS MANAGER_ID,
       E2.FIRST_NAME || ' ' || E2.LAST_NAME AS MANAGER_NAME,
       COUNT(E1.EMPLOYEE_ID) AS NO_OF_EMPLOYEES
   FROM HR.EMPLOYEES E1
   JOIN HR.EMPLOYEES E2
   ON E1.MANAGER_ID = E2.EMPLOYEE_ID
   GROUP BY E2.EMPLOYEE_ID, E2.FIRST_NAME, E2.LAST_NAME
   HAVING COUNT(E1.EMPLOYEE_ID) > 5
   ORDER BY MANAGER_ID;

   

