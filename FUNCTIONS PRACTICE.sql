/* =========================================================
   SQL PRACTICE QUESTIONS – FUNCTIONS (HR.EMPLOYEES)
   Level: Moderate to Tough
   Allowed: SELECT, WHERE, GROUP BY, HAVING, functions
   Not allowed: JOIN, SUBQUERY, COALESCE
   ========================================================= */

   SELECT * FROM HR.EMPLOYEES;

/* Q1.
   Display employee_id, first_name (in uppercase),
   length of last_name, and monthly salary rounded to 2 decimals.
*/

   SELECT EMPLOYEE_ID,UPPER(FIRST_NAME) FIRST_NAME,LENGTH(LAST_NAME), ROUND(SALARY,2) SALARY
   FROM HR.EMPLOYEES;

/* Q2.
   Display distinct job_id values and show them as
   "Job Code" using column alias.
*/

   SELECT JOB_ID AS JOB_CODE
   FROM HR.EMPLOYEES
   GROUP BY JOB_ID ;

/* Q3.
   Display employee_id, email username (part before '@'),
   and domain name (part after '@').
*/

   SELECT EMPLOYEE_ID,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS USERNAME,
   SUBSTR(EMAIL,INSTR(EMAIL,'@'),10) AS DOMAIN_NAME
   FROM HR.EMPLOYEES;

   /*SELECT SUBSTR('PARAGDHOMNE@GMAIL.COM',1,INSTR('PARAGDHOMNE@GMAIL.COM','@')-1) AS USERNAME,
   SUBSTR('PARAGDHOMNE@GMAIL.COM',INSTR('PARAGDHOMNE@GMAIL.COM','@'),10) AS dOMAIN_NAME
   FROM DUAL;*/

/* Q4.
   Display employee_id, first_name, and salary.
   Replace NULL commission_pct with 0.
*/

  SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,NVL(COMMISSION_PCT,0) COMMISSION_PCT
  FROM HR.EMPLOYEES;

/* Q5.
   Display employee_id, hire_date,
   number of months the employee has worked till today (rounded).
*/

   SELECT EMPLOYEE_ID, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) EXPERIENCE
   FROM HR.EMPLOYEES;

/* Q6.
   Display employee_id, first_name, hire_date,
   and hire month name in uppercase.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, TO_CHAR(HIRE_DATE,'DD/MM/YY')HIRE_DATE, TO_CHAR(HIRE_DATE,'MONTH')HIRE_MONTH
   FROM HR.EMPLOYEES;

/* Q7.
   Display employee_id, first_name,
   and salary truncated to nearest thousand.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, ROUND(SALARY)SALARY
   FROM HR.EMPLOYEES; 

/* Q8.
   Display employee_id, first_name,
   and total annual salary (salary * 12).
*/
   
   SELECT EMPLOYEE_ID, FIRST_NAME, SALARY*12 AS TOTAL_ANNUAL_SALARY
   FROM HR.EMPLOYEES;

/* Q9.
   Display employee_id, first_name,
   and next salary review date which is 6 months after hire_date.
*/
   
   SELECT EMPLOYEE_ID, FIRST_NAME, ADD_MONTHS(HIRE_DATE,6)SALARY_REVIEW
   FROM HR.EMPLOYEES;

/* Q10.
   Display employee_id, first_name,
   and day of the week on which the employee was hired.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, TO_CHAR(HIRE_DATE,'DAY')HIRE_DAY
   FROM HR.EMPLOYEES;


/* =========================================================
   AGGREGATE + GROUP BY + FUNCTIONS
   ========================================================= */


/* Q11.
   Display department_id and average salary (rounded to 2 decimals)
   only for departments having more than 5 employees.
*/

   SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),2)AVERAGE_SALARY
   FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID
   HAVING COUNT(*)>5;
   

/* Q12.
   Display job_id and total salary paid.
   Exclude employees with NULL department_id.
*/

   SELECT JOB_ID, SUM(SALARY)
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID IS NOT NULL
   GROUP BY JOB_ID;

/* Q13.
   Display department_id and maximum salary.
   Ignore departments where department_id is NULL.
*/

   SELECT DEPARTMENT_ID,MAX(SALARY)MAXEIMUM_SALARY
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID IS NOT NULL
   GROUP BY DEPARTMENT_ID; 
   
/* Q14.
   Display department_id, minimum salary,
   and maximum salary for each department.
*/

   SELECT DEPARTMENT_ID, MIN(SALARY) MIN_SALARY, MAX(SALARY) MAX_SALARY
   FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID
   ORDER BY DEPARTMENT_ID;

/* Q15.
   Display department_id and count of employees hired in year 2005.
*/

   SELECT DEPARTMENT_ID, COUNT(*)NO_OF_EMPLOYEES
   FROM HR.EMPLOYEES
   WHERE TO_CHAR(HIRE_DATE,'YYYY')='2005'
   GROUP BY DEPARTMENT_ID;

/* =========================================================
   STRING + DATE + AGGREGATE (TOUGH)
   ========================================================= */


/* Q16.
   Display department_id and average length of employee first names.
*/
   
   SELECT DEPARTMENT_ID, ROUND(AVG(LENGTH(FIRST_NAME)))AVG_LENGTH_OF_FIRST_NAME
   FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID;

/* Q17.
   Display job_id and total annual salary (salary * 12)
   rounded to nearest integer.
*/

   SELECT JOB_ID, ROUND(SUM((SALARY*12))) AS TOTAL_ANNUAL_SALARY
   FROM HR.EMPLOYEES 
   GROUP BY JOB_ID ;

/* Q18.
   Display department_id and total commission amount
   (salary * commission_pct * 12),
   treat NULL commission as 0.
*/

   SELECT DEPARTMENT_ID, SUM(SALARY*NVL(COMMISSION_PCT,0)*12) TOTAL_COMMISSION
   FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID ;

/* Q19.
   Display department_id and earliest hire_date.
*/

   SELECT DEPARTMENT_ID, MIN(HIRE_DATE)EARLIEST_HIRE_DATE
   FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID;

/* Q20.
   Display department_id and number of employees
   whose first name starts with 'A'.
*/

   SELECT DEPARTMENT_ID, COUNT(*)
   FROM HR.EMPLOYEES
   WHERE FIRST_NAME LIKE'A%'
   GROUP BY DEPARTMENT_ID;

/* =========================================================
   DATE FILTERING + FUNCTIONS (TOUGH)
   ========================================================= */


/* Q21.
   Display employee_id, first_name, hire_date
   for employees hired in the month of January.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
   FROM HR.EMPLOYEES
   WHERE EXTRACT(MONTH FROM HIRE_DATE)=1
   
/* Q22.
   Display employee_id, first_name
   and years of experience (rounded) till today.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) EXPERIENCE
   FROM HR.EMPLOYEES;

/* Q23.
   Display department_id and count of employees
   hired after year 2007.
*/

   SELECT DEPARTMENT_ID, COUNT(*)
   FROM HR.EMPLOYEES
   WHERE EXTRACT(YEAR FROM HIRE_DATE)>2007
   GROUP BY DEPARTMENT_ID;

/* Q24.
   Display employee_id, first_name,
   and last day of the month in which they were hired.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, LAST_DAY(HIRE_DATE)MONTHS_LAST_DAY
   FROM HR.EMPLOYEES;

/* Q25.
   Display department_id and average salary,
   but show only those departments where
   average salary is greater than 8000.
*/

   SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),2) AVG_SALARY
   FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID
   HAVING AVG(SALARY)>8000;

/* =========================================================
   END OF PRACTICE SET
   ========================================================= */
