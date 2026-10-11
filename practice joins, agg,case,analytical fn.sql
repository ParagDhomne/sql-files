/* =========================================================
   ORACLE SQL PRACTICE – HR SCHEMA
   SECTION 1: AGGREGATE FUNCTIONS ONLY
   (COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING)
   ========================================================= */

/* A1.
   Display department_id and total salary of employees
   in each department.
*/

   select department_id, sum(salary) total_salary
   from hr.employees
   group by department_id;
    
/* A2.
   Display job_id and average salary for each job.
*/

   SELECT JOB_ID, AVG(SALARY)
   FROM HR.EMPLOYEES
   GROUP BY JOB_ID;   

/* A3.
   Display department_id and number of employees
   in each department.
*/

   SELECT DEPARTMENT_ID, COUNT(*) AS NUMBER_OF_EMPLOYEES
   FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID;

/* A4.
   Display department_id and average salary.
   Show only departments where average salary
   is greater than 8000.
*/

   SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),2)
   FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID
   HAVING AVG(SALARY)>8000;

/* A5.
   Display job_id, minimum salary, and maximum salary
   for each job.
*/

   SELECT JOB_ID, MIN(SALARY) MINIMUM_SALARY,MAX(SALARY) MAXIMUM_SALARY
   FROM HR.EMPLOYEES
   GROUP BY JOB_ID;

/* =========================================================
   SECTION 2: COALESCE / NVL ONLY
   ========================================================= */

/* C1.
   Display employee_id, first_name, commission_pct.
   If commission_pct is NULL, show it as 0.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, NVL(COMMISSION_PCT,0)
   FROM HR.EMPLOYEES;

/* C2.
   Display employee_id, salary, commission_pct,
   and total earnings as salary + commission_pct*salary.
   Treat NULL commission_pct as 0.
*/

   SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT, SALARY+NVL(COMMISSION_PCT,0)*SALARY AS TOTAL_EARNINGS
   FROM HR.EMPLOYEES;

/* C3.
   Display employee_id and a column commission_status:
   - 'HAS COMMISSION' if commission_pct is NOT NULL
   - 'NO COMMISSION' if commission_pct is NULL
   (Use COALESCE or NVL)
*/

    SELECT EMPLOYEE_ID, NVL2(COMMISSION_PCT,'HAS COMMISSIION','NO COMMISSION') AS COMMISSION_STATUS
    FROM HR.EMPLOYEES;


/* =========================================================
   SECTION 3: CASE STATEMENT ONLY
   ========================================================= */

/* K1.
   Display employee_id, salary, and salary_grade:
   - 'A' if salary >= 12000
   - 'B' if salary between 8000 and 11999
   - 'C' otherwise
*/

     SELECT EMPLOYEE_ID,SALARY,
     CASE
       WHEN SALARY>=12000 THEN 'A'
         WHEN SALARY BETWEEN 8000 AND 11999 THEN 'B'
           ELSE 'C'
             END AS SALARY_GRADE
      FROM HR.EMPLOYEES;
      
/* K2.
   Display employee_id, hire_date, and hire_category:
   - 'OLD EMPLOYEE' if hired before 01-JAN-2005
   - 'NEW EMPLOYEE' otherwise
*/

   SELECT EMPLOYEE_ID,HIRE_DATE,
   CASE 
     WHEN HIRE_DATE<'01-JAN-2005' THEN 'OLD EMPLOYEE'
       ELSE 'NEW EMPLOYEE'
         END AS HIRE_CATEGORY
    FROM HR.EMPLOYEES;

/* K3.
   Display employee_id, department_id, and department_type:
   - 'IT' if department_id = 60
   - 'SALES' if department_id = 80
   - 'OTHER' otherwise
*/

     SELECT EMPLOYEE_ID, DEPARTMENT_ID,
     CASE 
       WHEN DEPARTMENT_ID= 60 THEN 'IT'
         WHEN DEPARTMENT_ID = 80 THEN 'SALES'
           ELSE 'OTHER'
             END AS DEPARTMENT_TYPE
      FROM HR.EMPLOYEES;

/* =========================================================
   SECTION 4: JOINS ONLY
   (No aggregates, no analytics)
   ========================================================= */
SELECT * FROM HR.EMPLOYEES;
SELECT * FROM HR.DEPARTMENTS;
SELECT * FROM HR.JOBS;
/* J1.
   Display employee_id, first_name, and department_name.
*/
   
   SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
   FROM HR.EMPLOYEES E
   INNER JOIN HR.DEPARTMENTS D
   ON E.DEPARTMENT_ID=D.DEPARTMENT_ID;

/* J2.
   Display employee_id, first_name, job_title.
*/
   
   SELECT E.EMPLOYEE_ID, E.FIRST_NAME,J.JOB_TITLE
   FROM HR.EMPLOYEES E
   INNER JOIN HR.JOBS J
   ON E.JOB_ID=J.JOB_ID; 

/* J3.
   Display department_name and location_id.
*/

   SELECT DEPARTMENT_NAME,LOCATION_ID
   FROM HR.DEPARTMENTS;
  
/* J4.
   Display employee_id, first_name, and manager name.
*/

   SELECT E.EMPLOYEE_ID, E.FIRST_NAME AS EMPLOYEE, M.FIRST_NAME AS MANAGER_NAME
   FROM HR.EMPLOYEES E
   LEFT JOIN HR.EMPLOYEES M
   ON E.MANAGER_ID=M.EMPLOYEE_ID; 

/* =========================================================
   SECTION 5: ANALYTICAL / WINDOW FUNCTIONS ONLY
   (No GROUP BY, no HAVING)
   ========================================================= */

/* W1.
   Display employee_id, department_id, salary,
   and average salary of the employee’s department.
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY, 
   AVG(SALARY)OVER( 
                     PARTITION BY DEPARTMENT_ID
                    )AS DEPT_AVG_SALARY
   FROM HR.EMPLOYEES
   ORDER BY DEPARTMENT_ID;

/* W2.
   Display employee_id, department_id, salary,
   and rank of employee within department
   based on salary.
*/

   SELECT EMPLOYEE_ID, DEPARTMENT_ID,SALARY,
   RANK()OVER (PARTITION BY DEPARTMENT_ID
                ORDER BY SALARY DESC) AS DEPT_RANK
   FROM HR.EMPLOYEES;
   
/* W3.
   Display employee_id, salary,
   and previous employee’s salary
   ordered by salary.
*/

   SELECT EMPLOYEE_ID,SALARY,
   LAG(SALARY) OVER(ORDER BY EMPLOYEE_ID) AS PREVIOUS_EMP_SALARY
   FROM HR.EMPLOYEES; 

/* W4.
   Display employee_id, department_id, salary,
   and row number within department
   ordered by hire_date.
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   ROW_NUMBER() OVER (
                        PARTITION BY DEPARTMENT_ID
                        ORDER BY HIRE_DATE
                     ) AS ROW_NUMBER
    FROM HR.EMPLOYEES;        

/* W5.
   Display employee_id, salary,
   and overall average salary of all employees.
*/

   SELECT EMPLOYEE_ID,SALARY,
   AVG(SALARY) OVER() AS AVG_SALARY
   FROM HR.EMPLOYEES;



/* =========================================================
   END OF PRACTICE
   ========================================================= */
   
/* =========================================================
   SECTION 5: ANALYTICAL / WINDOW FUNCTIONS PRACTICE
   Table: HR.EMPLOYEES
   Allowed: SELECT, analytical functions
   Not allowed: SUBQUERY, TRANSACTIONS
   ========================================================= */

SELECT * FROM HR.EMPLOYEES;

/* ---------------------------------------------------------
   PART A: OVER() WITHOUT PARTITION
   --------------------------------------------------------- */

/* Q1.
   Display employee_id, first_name, salary,
   and overall average salary using analytical function.
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, SALARY,
   ROUND(AVG(SALARY)OVER())
   FROM HR.EMPLOYEES;

/* Q2.
   Display employee_id, salary,
   and difference between employee salary
   and overall average salary.
*/
   SELECT EMPLOYEE_ID, SALARY, 
   ABS(SALARY- AVG(SALARY) OVER()) AS DIFFERENCE_IN_SALARY
   FROM HR.EMPLOYEES;

/* Q3.
   Display employee_id, salary,
   and cumulative total salary ordered by salary ascending.
*/

   SELECT EMPLOYEE_ID, SALARY,
   SUM(SALARY) OVER(ORDER BY SALARY ASC) AS CUMULATIVE_SALARY
   FROM HR.EMPLOYEES;

/* ---------------------------------------------------------
   PART B: PARTITION BY
   --------------------------------------------------------- */

/* Q4.
   Display employee_id, department_id, salary,
   and average salary of the department.
*/
   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   AVG(SALARY) OVER ( PARTITION BY DEPARTMENT_ID) AVG_SALARY
   FROM HR.EMPLOYEES;

/* Q5.
   Display employee_id, job_id, salary,
   and maximum salary for that job.
*/
    SELECT EMPLOYEE_ID,JOB_ID, SALARY,
    MAX(SALARY) OVER (PARTITION BY JOB_ID)AS MAX_SALARY
    FROM HR.EMPLOYEES;

/* Q6.
   Display employee_id, department_id, salary,
   and total salary of the department.
*/
   SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY,
   SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID) TOTAL_DEPT_SALARY
   FROM HR.EMPLOYEES;

/* ---------------------------------------------------------
   PART C: ORDER BY WITH ANALYTICAL FUNCTIONS
   --------------------------------------------------------- */

/* Q7.
   Display employee_id, department_id, salary,
   and running total of salary within each department
   ordered by salary.
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID
                     ORDER BY SALARY
                     ) AS CUMULATIVE_SUM_DEPT_WISE
    FROM HR.EMPLOYEES;

/* Q8.
   Display employee_id, hire_date, salary,
   and cumulative salary ordered by hire_date.
*/

   SELECT EMPLOYEE_ID,HIRE_DATE,SALARY,
   SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID
                     ORDER BY HIRE_DATE
                     ) AS CUMULATIVE_SUM_HIRE_DATE_WISE
   FROM HR.EMPLOYEES;

/* ---------------------------------------------------------
   PART D: ROW_NUMBER, RANK, DENSE_RANK
   --------------------------------------------------------- */

/* Q9.
   Display employee_id, department_id, salary,
   and row number within each department
   ordered by salary descending.
*/
   SELECT EMPLOYEE_ID, DEPARTMENT_ID, SALARY,
   ROW_NUMBER() OVER (PARTITION BY DEPARTMENT_ID
                      ORDER BY SALARY DESC
                      ) AS ROW_NUMBER
   FROM HR.EMPLOYEES;

/* Q10.
   Display employee_id, department_id, salary,
   and rank of salary within each department.
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   RANK() OVER(PARTITION BY DEPARTMENT_ID
               ORDER BY SALARY
               ) AS RANK
   FROM HR.EMPLOYEES;

/* Q11.
   Display employee_id, department_id, salary,
   and dense rank of salary within each department.
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID
                     ORDER BY SALARY DESC) AS RANK_SALARY
   FROM HR.EMPLOYEES;

/* ---------------------------------------------------------
   PART E: LEAD & LAG
   --------------------------------------------------------- */

/* Q12.
   Display employee_id, department_id, salary,
   and previous employee salary within department
   ordered by salary.
*/
   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   LAG(SALARY) OVER(PARTITION BY DEPARTMENT_ID
             ORDER BY SALARY DESC ) AS PREVIOUS_EMP_SAL
   FROM HR.EMPLOYEES;
   
/* Q13.
   Display employee_id, department_id, salary,
   and next employee salary within department
   ordered by salary.
*/
   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   LEAD(SALARY) OVER (PARTITION BY DEPARTMENT_ID
               ORDER BY SALARY DESC)
   FROM HR.EMPLOYEES;

/* Q14.
   Display employee_id, salary,
   and difference between salary
   and previous employee salary (ordered by salary).
*/

   SELECT EMPLOYEE_ID,SALARY,
   SALARY-LAG(SALARY) OVER(ORDER BY SALARY) AS DIFFERENCE
   FROM HR.EMPLOYEES;
   
/* ---------------------------------------------------------
   PART F: ANALYTICAL AGGREGATES (SUM / AVG)
   --------------------------------------------------------- */

/* Q15.
   Display employee_id, department_id, salary,
   and average salary of department
   using analytical AVG().
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   AVG(SALARY) OVER(PARTITION BY DEPARTMENT_ID)
   FROM HR.EMPLOYEES;
   
/* Q16.
   Display employee_id, job_id, salary,
   and total salary for the job role.
*/

   SELECT EMPLOYEE_ID,JOB_ID,SALARY,
   SUM(SALARY) OVER (PARTITION BY JOB_ID)
   FROM HR.EMPLOYEES;

/* Q17.
   Display employee_id, department_id, salary,
   and percentage contribution of employee salary
   to department total salary.
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   SALARY*100/ SUM(SALARY) OVER (PARTITION BY DEPARTMENT_ID) AS CONTRIBUTION_IN_SALARY
   FROM HR.EMPLOYEES;
   
/* ---------------------------------------------------------
   PART G: MIXED ANALYTICAL PRACTICE
   --------------------------------------------------------- */

/* Q18.
   Display employee_id, department_id, salary,
   rank by salary in department,
   and running total salary in department.
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   RANK() OVER(
                PARTITION BY DEPARTMENT ID 
                ORDER BY SALARY
               ) AS SALARY_RANK,
   SUM(SALARY) OVER(
                      PARTITION BY DEPARTMENT_ID
                    ) RUNNING_TOTAL_SALARY
   FROM HR.EMPLOYEES;
   
/* Q19.
   Display employee_id, job_id, hire_date,
   row number ordered by hire_date within job.
*/
   SELECT EMPLOYEE_ID,JOB_ID,HIRE_DATE,
   ROW_NUMBER() OVER(PARTITION BY JOB_ID
                              ORDER BY HIRE_DATE) ROW_NUM
    FROM HR.EMPLOYEES;
    

/* Q20.
   Display employee_id, department_id, salary,
   and count of employees in the department
   using analytical COUNT().
*/
   
   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   COUNT(*) OVER (PARTITION BY DEPARTMENT_ID) TOTAL_EMP
   FROM HR.EMPLOYEES



/* =========================================================
   ORACLE SQL PRACTICE – HR SCHEMA
   Level: Moderate to Tough
   Allowed: JOINs, Aggregate functions, CASE, COALESCE,
            Analytical / Window functions
   Not Allowed: Subqueries, Transactions
   ========================================================= */
select * from hr.employees;
select * from hr.departments;
select * from hr.locations;
SELECT * FROM HR.JOBS;
/* Q1.
   Display department_id, department_name, and total salary
   of employees in each department.
   Include departments with no employees.
   If total salary is NULL, show it as 0.
*/
   
    SELECT D.DEPARTMENT_ID,D.DEPARTMENT_NAME,NVL(SUM(E.SALARY), 0) AS TOTAL_SALARY
    FROM HR.DEPARTMENTS D
    LEFT JOIN HR.EMPLOYEES E
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
    ORDER BY DEPARTMENT_ID ;

/* Q2.
   Display employee_id, first_name, salary, and a column
   salary_category such that:
   - 'HIGH' if salary >= 10000
   - 'MEDIUM' if salary between 6000 and 9999
   - 'LOW' otherwise
*/

   SELECT EMPLOYEE_ID, FIRST_NAME, SALARY ,
   CASE
     WHEN SALARY>=10000 THEN 'HIGH'
       WHEN SALARY BETWEEN 6000 AND 9999 THEN 'MEDIUM'
         ELSE 'LOW'
           END AS SALARY_CATEGORY
   FROM HR.EMPLOYEES;
           


/* Q3.
   Display job_id and average salary.
   Show only those jobs where average salary
   is greater than the overall average salary
   (use analytical function, no subquery).
*/

  


/* Q4.
   Display employee_id, department_id, salary,
   and rank of employee within their department
   based on salary (highest salary = rank 1).
*/

   SELECT EMPLOYEE_ID,DEPARTMENT_ID,SALARY,
   RANK() OVER(PARTITION BY DEPARTMENT_ID
               ORDER BY SALARY) AS DEPT_RANK
               FROM HR.EMPLOYEES;

/* Q5.
   Display department_id, employee_id, salary,
   previous employee’s salary in the same department
   based on hire_date ordering.
*/
   

/* Q6.
   Display employee_id, department_name, salary,
   and total department salary using analytical function.
*/


/* Q7.
   Display employee_id, manager_id, and a column
   manager_status such that:
   - 'HAS MANAGER' if manager_id is not NULL
   - 'NO MANAGER' if manager_id is NULL
   (Use COALESCE or CASE appropriately)
*/


/* Q8.
   Display department_id, job_id, and number of employees.
   Use JOINs and aggregate functions.
*/


/* Q9.
   Display employee_id, salary,
   average salary of their department,
   and difference between employee salary
   and department average salary.
*/


/* Q10.
   Display employee_id, department_id, salary,
   row number of employee within department
   ordered by salary descending.
*/


/* Q11.
   Display employee_id, hire_date,
   and number of employees hired before them
   in the same department.
*/


/* Q12.
   Display department_name and count of employees.
   If a department has no employees,
   display employee count as 0.
*/


/* Q13.
   Display employee_id, salary,
   and label salary as:
   - 'ABOVE DEPT AVG'
   - 'BELOW DEPT AVG'
   - 'EQUAL TO DEPT AVG'
   using analytical functions and CASE.
*/


/* Q14.
   Display job_id, employee_id, salary,
   and dense rank of employees within each job
   based on salary.
*/


/* Q15.
   Display employee_id, salary,
   next higher salary in the same department
   ordered by salary.
*/


/* =========================================================
   END OF PRACTICE QUESTIONS
   ========================================================= */
   
   
   
   
   create table t1
   (
        ID NUMBER,
        AMOUNT NUMBER   
   );
   
   INSERT INTO T1 VALUES(101,500);
   INSERT INTO T1 VALUES(102,600);
   INSERT INTO T1 VALUES(103,700);
   
   SELECT to_char(id) id,amount FROM T1
   UNION all
   SELECT 'sum', SUM(AMOUNT) FROM T1;
   
   
   select * from hr.employees
   where department
   
   
   
   
   
   SELECT * FROM HR.EMPLOYEES
   WHERE SALARY>(SELECT AVG(SALARY) FROM HR.EMPLOYEES)
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
