/* =========================================================
   ORACLE HR SCHEMA – SQL PRACTICE QUESTIONS
   ========================================================= */

/* Q1:
   Write a query to display the full name (first name + last name)
   of employees whose FIRST_NAME starts with the letter 'S'
   from the EMPLOYEES table.
*/

/* Q2:
   Find the highest, lowest, total, and average salary of all employees.
   Label the columns as Maximum, Minimum, Sum, and Average respectively.
   Round the values to the nearest whole number.
*/

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

/* Q4:
   Determine the number of managers in the company without listing them.
   Label the column as Number of Managers.
   Hint: Use the MANAGER_ID column from the EMPLOYEES table.
*/

/* Q5:
   Find the difference between the highest and lowest salaries.
   Label the column as DIFFERENCE.
*/

/* Q6:
   Display how many employees joined in each month.
   Hint: Use the HIRE_DATE column, group by month,
   and use the TO_CHAR function.
*/

/* Q7:
   Display EMPLOYEE_ID, full name, and HIRE_DATE of employees
   who have more than 10 years of experience in the company.
*/

/* Q8:
   Write a query to multiply salary with commission
   and calculate the average salary of employees.
   Hint: COMMISSION_PCT column contains NULL values.
*/

/* Q9:
   Write a query to display DEPARTMENT_ID and number of managers
   working under each department.
   Exclude records where DEPARTMENT_ID is NULL.
   Hint: Group by DEPARTMENT_ID.
*/

/* Q10:
   Display JOB_TITLE, number of employees working in each job,
   and number of managers performing that job.
   Hint: Use EMPLOYEES and JOBS tables.
*/

/* Q11:
   Display employee full name padded with 10 asterisks (*)
   on both left and right sides.
*/

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

/* Q14:
   Write a query to display JOB_ID and number of managers
   working under each job.
   Show only those jobs that have more than one manager.
*/

/* Q15:
   Display COUNTRY_NAME and number of employees working in each city,
   where the employee count is greater than 30.
   Hint: Use equi-joins between EMPLOYEES, DEPARTMENTS,
   LOCATIONS, and COUNTRIES tables.
*/

/* Q16:
   Display city names and number of departments located in each city.
   Exclude departments that do not have any employees.
*/

/* Q17:
   Display salary range and number of employees whose salary
   falls within that range.
   Hint: Use JOB_GRADES table, equi-join, and group by.
*/

/* Q18:
   Display year-wise employee joining count using the HIRE_DATE column.
   Hint: Use GROUP BY and TO_CHAR function.
*/

/* Q19:
   Display MANAGER_ID, manager full name, and number of employees
   working under them.
   Show only those managers who have more than 5 employees,
   and sort the result by MANAGER_ID.
*/
