-----------------------------AGE CALCULATION METHOD 1-----------------------------------------------------------

CREATE TABLE DOB
(
DOB DATE
);

INSERT INTO DOB VALUES(TO_DATE('21/02/1998','DD/MM/YYYY'));

SELECT 
     DOB,
     SYSDATE TODAYS_DATE,
     FLOOR(SYSDATE-DOB) AGE_IN_DAYS,
     FLOOR(MONTHS_BETWEEN(SYSDATE,DOB)) AGE_IN_MONTHS,
     FLOOR((MONTHS_BETWEEN(SYSDATE,DOB)/12)) AGE_IN_YEARS
FROM DOB;

-----------------------------AGE CALCULATION METHOD 2-----------------------------------------------------------

SELECT 
     TO_DATE('21/02/1998','DD/MM/YYYY') AS DOB,
     TRUNC(SYSDATE) AS TODAYS_DATE,
     FLOOR(SYSDATE-TO_DATE('21/02/1998','DD/MM/YYYY')) AS AGE_IN_DAYS,
     FLOOR(MONTHS_BETWEEN(SYSDATE,TO_date('21/02/1998','DD/MM/YYYY'))) AS  AGE_IN_MONTHS,
     FLOOR(MONTHS_BETWEEN(SYSDATE,TO_date('21/02/1998','DD/MM/YYYY'))/12) AS  AGE_IN_YEARS
FROM DUAL;

-----------------------------AGE CALCULATION METHOD 3------------------------------------------------------------

SELECT
     TO_DATE('21/02/1998','DD/MM/YYYY') AS DOB,
     TRUNC(SYSDATE) AS TODAYS_DATE,
     TRUNC(SYSDATE - DATE '1998-02-21')AS AGE_IN_DAYS,
     TRUNC(MONTHS_BETWEEN(SYSDATE, DATE '1998-02-21')) AS AGE_IN_MONTHS,
     TRUNC(MONTHS_BETWEEN(SYSDATE, DATE '1998-02-21') / 12) AS AGE_IN_YEARS
FROM DUAL;

------------------------------------------------------------------------------------------------------------------

SELECT TRUNC(SYSDATE) FROM DUAL

SELECT employee_id, job_id, salary
FROM hr.employees
ORDER BY
   CASE
      WHEN job_id = 'IT_PROG' THEN 1
      ELSE 2
  -- END as results,
  END ,
   salary DESC;
   
   SELECT employee_id, job_id, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
FROM hr.employees;


SELECT employee_id, department_id, salary,
      RANK() OVER (
           PARTITION BY department_id
           ORDER BY salary DESC
       ) AS dept_rank
FROM hr.employees;

SELECT employee_id, hire_date, salary,
       SUM(salary) OVER (
           ORDER BY hire_date
       ) AS running_salary_total
FROM hr.employees;



SELECT TO_CHAR(SYSDATE,'HH12:MI') FROM DUAL;



------------------------------- coalesce()---------------------------------------------------------

select coalesce(NULL,NULL,NULL,10,NULL,11,12) from dual;


select * from HR.EMPLOYEES;

------------------------ Case statement------------------------------------------

SELECT employee_id,first_name,last_name,salary,
case 
  when salary >= 10000 THEN 'High salary'
  when salary between 5000 and 9999 THEN 'Medium Salary'
  when salary between 3000 and 4999 THEN 'Low salary'
  ELSE 'Not Specified'
END as Salary_Category
FROM Hr.employees;


SELECT employee_id,first_name,last_name,salary,
case 
  when salary >= 10000 THEN 1.5
  when salary between 5000 and 9999 THEN 1.0
  when salary between 3000 and 4999 THEN 0.5
  ELSE 0.1
END as commission_pct,salary * case 
  when salary >= 10000 THEN 1.5
  when salary between 5000 and 9999 THEN 1.0
  when salary between 3000 and 4999 THEN 0.5
  ELSE 0.1
END as total_salary
FROM Hr.employees;


-------------Decode--------------------------------

SELECT DECODE(1,1,'one','not equal') FROM DUAL;

SELECT DECODE(6,1,'one',2,'two',3,'three',4,'four','not matching') FROM DUAL;

----------------------------------------------Analytical function----------------------------------------------------------------
-- rank()/dense_rank()/row_number()

SELECT DEPARTMENT_ID,MAX(SALARY)
FROM HR.employees
group by department_id;

SELECT * FROM (SELECT employee_id,first_name,last_name,salary,department_id,
RANK() OVER(order by salary desc) rnk
FROM HR.employees)
where rnk = 2;

SELECT employee_id,first_name,last_name,salary,salary * updated_commission total_salary
FROM (SELECT employee_id,first_name,last_name,salary,
case 
  when salary >= 10000 THEN 1.5
  when salary between 5000 and 9999 THEN 1.0
  when salary between 3000 and 4999 THEN 0.5
  ELSE 0.1
end as updated_commission
FROM Hr.employees);


SELECT * FROM (SELECT employee_id,first_name,last_name,salary,department_id,
RANK() OVER( partition by department_id order by salary desc) rnk,
DENSE_RANK() OVER(partition by department_id order by salary desc) drnk,
row_number() OVER(partition by department_id order by salary desc) rn
FROM HR.employees)
where drnk = 1
;


--HIGHEST SALARY DEPARTMENT WISE
SELECT * FROM (SELECT employee_id,first_name,last_name,salary,department_id,hire_date,Year,
RANK() OVER( partition by Year order by salary desc) rnk,
DENSE_RANK() OVER(partition by Year order by salary desc) drnk,
row_number() OVER(partition by Year order by salary desc) rn
FROM (SELECT employee_id,first_name,last_name,salary,department_id,hire_date, to_char(hire_date,'YYYY') Year
FROM HR.employees))
where drnk = 1;
