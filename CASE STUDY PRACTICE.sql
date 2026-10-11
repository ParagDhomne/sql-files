/*
CASE STUDY 1: E-COMMERCE CUSTOMER INSIGHTS

TABLES:
1) CUSTOMERS(CID, NAME, CITY, JOIN_DATE)
2) ORDERS(ORDER_ID, CID, ORDER_DATE, AMOUNT)
3) PRODUCTS(PID, CATEGORY, PRICE)
4) ORDER_ITEMS(ORDER_ID, PID, QTY)

TASKS: */
--1) Find customers who have NEVER placed any order. (Use LEFT JOIN or MINUS)

     SELECT *
     FROM CUSTOMERS 
     WHERE CID IN(
           SELECT CID FROM CUSTOMERS
            MINUS
           SELECT CID FROM ORDERS
     );  

--2) Identify customers who placed orders in BOTH 2023 and 2024. (Use INTERSECT)

     SELECT *
     FROM CUSTOMERS
     WHERE CID IN(
           SELECT CID 
           FROM ORDERS
           WHERE EXTRACT (YEAR FROM ORDER_DATE)=2023
             INTERSECT
           SELECT CID 
           FROM ORDERS
           WHERE EXTRACT (YEAR FROM ORDER_DATE)=2024
           );



--3) Get the top 5 customers by total spent using window functions.

     SELECT * FROM(
           SELECT C.CID , 
                  C.NAME,
                  SUM(O.AMOUNT) TOTAL, 
                  ROW_NUMBER() OVER(ORDER BY SUM(O.AMOUNT)DESC) RN
           FROM ORDERS O
           INNER JOIN CUSTOMERS C
           ON O.CID=C.CID
           GROUP BY C.CID, C.NAME 
                 )
     WHERE RN<=5 ;

--4) Find the month-wise revenue trend for the last 12 months.

     SELECT TO_CHAR(ORDER_DATE,'YYYY-MM') AS YEAR_MONTH,
            SUM(AMOUNT) AS REVENUE
     FROM ORDERS
     WHERE ORDER_DATE >= ADD_MONTHS(SYSDATE,-12)
     GROUP BY TO_CHAR(ORDER_DATE,'YYYY-MM')
     ORDER BY TO_CHAR(ORDER_DATE,'YYYY-MM');

--5) Identify repeat customers (those with 2+ orders).

     SELECT * 
     FROM CUSTOMERS
     WHERE CID IN(
      SELECT CID
      FROM ORDERS
      GROUP BY CID
      HAVING COUNT(*)>=2
     );


/*
CASE STUDY 2: BANKING SUSPICIOUS TRANSACTION ANALYSIS

TABLES:
1) ACCOUNTS(ACC_NO, CUSTOMER_ID, BALANCE, BRANCH)
2) TRANSACTIONS(TID, ACC_NO, TXN_TYPE, AMOUNT, TXN_DATE)

TASKS: */
--1) Find accounts with NO transactions in the last 6 months.
     
     SELECT A.* 
     FROM ACCOUNTS A
     LEFT JOIN TRANSACTIONS T
     ON A.ACC_NO= T.ACC_NO
     AND T.TXN_DATE >= ADD_MONTHS(SYSDATE,-6)
     WHERE T.ACC_NO IS NULL;
       
--2) Find customers who performed BOTH 'DEBIT' AND 'CREDIT' on same day. (INTERSECT)

     SELECT * 
     FROM 
         (
            SELECT ACC_NO,
                   TRUNC(TXN_DATE) TXN_DATE
            FROM TRANSACTIONS
            WHERE TXN_TYPE = 'DEBIT'
            
            INTERSECT
               
            SELECT ACC_NO,
                   TRUNC(TXN_DATE) TXN_DATE
            FROM TRANSACTIONS
            WHERE TXN_TYPE = 'CREDIT'
         );
     
--3) Detect accounts where balance increased but NO CREDIT transaction exists.

   
              
     
--4) Find top 10 high-value customers by total debit amount.

     SELECT ACC_NO,TOTAL_DEBIT
     FROM(
         SELECT ACC_NO, 
                SUM(AMOUNT) TOTAL_DEBIT,
                RANK() OVER(ORDER BY SUM(AMOUNT) DESC) RN
         FROM TRANSACTIONS
         WHERE TXN_TYPE ='DEBIT'
         GROUP BY ACC_NO
          )
     WHERE RN<=10;    
              
--5) Identify branches showing decreasing transaction volume month-over-month.
*/



/*
CASE STUDY 3: HOSPITAL PATIENT MANAGEMENT

TABLES:
1) PATIENT(PID, NAME, AGE, CITY, ADMIT_DATE)
2) DOCTOR(DID, NAME, SPECIALIZATION)
3) APPOINTMENTS(AP_ID, PID, DID, VISIT_DATE, FEES)
4) BILLING(BILL_ID, PID, AMOUNT, BILL_DATE)

TASKS: */

--1) Find patients who never visited any doctor. (MINUS / LEFT JOIN)

     SELECT P.* 
     FROM PATIENT P
     LEFT JOIN APPOINTMENTS A
     ON P.PID = A.PID
     WHERE A.PID IS NULL;

--2) Find doctors who have seen patients in BOTH 2023 AND 2024. (INTERSECT)

     SELECT D.* 
     FROM DOCTOR D
     INNER JOIN APPOINTMENTS A
     ON D.DID = A.DID
     WHERE EXTRACT( YEAR FROM A.VISIT_DATE)=2023 
     
     INTERSECT
     
     SELECT D.* 
     FROM DOCTOR D
     INNER JOIN APPOINTMENTS A
     ON D.DID = A.DID
     WHERE EXTRACT( YEAR FROM A.VISIT_DATE)=2024;
         
     
--3) Identify highest revenue-generating doctor.       
  
    SELECT *
    FROM (
           SELECT D.DID,
                  D.DNAME,
                  SUM(A.FEES) AS TOTAL_REVENUE,
                  RANK() OVER (ORDER BY SUM(A.FEES) DESC) AS RN
           FROM DOCTOR D
           JOIN APPOINTMENTS A ON D.DID = A.DID
           GROUP BY D.DID, D.DNAME
         )
    WHERE RN = 1;
     
--4) Monthly revenue summary for hospital.

     SELECT TO_CHAR( BILL_DATE ,'YYYY-MON') AS YEAR_MONTH,
            SUM(AMOUNT) AS MONTHLY_REVENUE 
     FROM BILLING
     GROUP BY TO_CHAR( BILL_DATE ,'YYYY-MON')
     ORDER BY TO_CHAR( BILL_DATE ,'YYYY-MON') ;
            
--5) Age-group based patient distribution (0–18, 18–40, 40–60, 60+)
     
      SELECT 
      CASE 
          WHEN AGE BETWEEN 0 AND 18 THEN '0-18'
          WHEN AGE BETWEEN 19 AND 40 THEN '19-40'
          WHEN AGE BETWEEN 41 AND 60 THEN '41-60'
          ELSE '60+'
      END AS AGE_GROUP,
      COUNT(*) AS NO_OF_PATIENTS
      FROM PATIENT
      GROUP BY 
          CASE 
              WHEN AGE BETWEEN 0 AND 18 THEN '0-18'
              WHEN AGE BETWEEN 19 AND 40 THEN '19-40'
              WHEN AGE BETWEEN 41 AND 60 THEN '41-60'
              ELSE '60+'
          END
      ORDER BY AGE_GROUP;
      

/*
CASE STUDY 4: HR EMPLOYEE PERFORMANCE ANALYSIS

TABLES:
1) EMP(EMP_ID, NAME, DEPT, SALARY, JOIN_DATE)
2) PERFORMANCE(EMP_ID, YEAR, RATING)
3) DEPARTMENTS(DEPT, MANAGER_ID) 

TASKS: */

--1) Find employees who never received a rating. (LEFT JOIN / MINUS)

  SELECT * FROM EMP
  WHERE EMP_ID IN (
          SELECT EMP_ID
          FROM EMP 
          MINUS
          SELECT EMP_ID
          FROM PERFORMANCE 
               );
           

--2) Find employees who had ratings above 4 in consecutive years.

      

--3) Identify department-wise salary expense.

     SELECT DEPT, 
            SUM(SALARY)
     FROM EMP 
     GROUP BY DEPT;
     
--4) Find employees earning more than their department average. (WINDOW)

     SELECT * 
     FROM ( SELECT EMP_ID, 
                   NAME, 
                   SALARY, 
                   AVG(SALARY) OVER(PARTITION BY DEPT) AS AVG_DEPT_SAL 
            FROM EMP
           )
     WHERE SALARY > AVG_DEPT_SAL; 
            
     
--5) Find departments where NO employee has joined in last 2 years.

     SELECT DEPT
     FROM EMP
     GROUP BY DEPT
     HAVING MAX(JOIN_DATE) < ADD_MONTHS(SYSDATE, -24);

/*
CASE STUDY 5: RETAIL INVENTORY MANAGEMENT

TABLES:
1) PRODUCTS(PID, NAME, CATEGORY, PRICE)
2) STOCK(PID, STORE_ID, QTY)
3) SALES(SALE_ID, PID, STORE_ID, QTY_SOLD, SALE_DATE)

TASKS: */

--1) Find products that are sold but have zero stock. (INTERSECT or JOIN)

     SELECT P.* 
     FROM PRODUCTS P
     INNER JOIN SALES S  ON P.PID = S.PID
     INNER JOIN STOCK ST ON S.PID = ST.PID
     WHERE ST.QTY = 0;

     
--2) Detect products present in stock table but NEVER sold. (MINUS)

     SELECT * FROM PRODUCTS
     WHERE PID IN(
           SELECT PID FROM STOCK
           MINUS
           SELECT PID FROM SALES
                  );
     
--3) Category-wise revenue and best-selling product per category.
       
     -- 1st CTE: Category-wise revenue
WITH REV AS (
    SELECT 
        P.CATEGORY,
        SUM(P.PRICE * S.QTY_SOLD) AS CATEGORY_REVENUE
    FROM PRODUCTS P
    JOIN SALES S ON P.PID = S.PID
    GROUP BY P.CATEGORY
),

-- 2nd CTE: Best-selling product per category
BEST_PRODUCT AS (
    SELECT CATEGORY, NAME, TOTAL_SOLD
    FROM (
        SELECT 
            P.CATEGORY,
            P.NAME,
            SUM(S.QTY_SOLD) AS TOTAL_SOLD,
            RANK() OVER (PARTITION BY P.CATEGORY ORDER BY SUM(S.QTY_SOLD) DESC) AS RN
        FROM PRODUCTS P
        JOIN SALES S ON P.PID = S.PID
        GROUP BY P.CATEGORY, P.NAME
    )
    WHERE RN = 1
)

SELECT R.CATEGORY, R.CATEGORY_REVENUE, B.NAME AS BEST_SELLING_PRODUCT
FROM REV R
JOIN BEST_PRODUCT B ON R.CATEGORY = B.CATEGORY;

     
--4) Store-wise stock shortage prediction (QTY < 10).

     SELECT * FROM STOCK
     WHERE QTY < 10;  
     
--5) Find month-wise revenue vs month-wise purchase cost.
     
     SELECT TO_CHAR(S.SALE_DATE, 'YYYY-MM') AS SALE_MONTH,
            SUM(P.PRICE * S.QTY_SOLD) AS MONTHLY_REVENUE,
            SUM(P.PRICE * ST.QTY) AS MONTHLY_PURCHASE_COST
     FROM PRODUCTS P
     JOIN SALES S ON P.PID = S.PID
     JOIN STOCK ST ON P.PID = ST.PID
     GROUP BY TO_CHAR(S.SALE_DATE, 'YYYY-MM')
     ORDER BY SALE_MONTH;


/*
CASE STUDY 6: STREAMING PLATFORM ANALYTICS (LIKE NETFLIX)

TABLES:
1) USERS(UID, NAME, COUNTRY, SIGNUP_DATE)
2) WATCH_HISTORY(UID, MOVIE_ID, WATCH_TIME_MIN, DATE)
3) MOVIES(MOVIE_ID, GENRE, RELEASE_YEAR)

TASKS:  */
--1) Find users who haven't watched anything in last 3 months.

     SELECT *
     FROM USERS U
     WHERE NOT EXISTS (
     SELECT 1
     FROM WATCH_HISTORY WH
     WHERE WH.UID = U.UID
     AND WH.DATE >= ADD_MONTHS(SYSDATE, -3)
      );


--2) Find movies watched in BOTH 'INDIA' AND 'USA'. (INTERSECT)

     ---- MOVIES IN INDIA
     SELECT M.MOVIE_ID, M.GENRE, M.RELEASE_YEAR
     FROM MOVIES M
     INNER JOIN WATCH_HISTORY WH
     ON M.MOVIE_ID = WH.MOVIE_ID
     INNER JOIN USERS U
     ON WH.UID = U.UID
     WHERE U.COUNTRY = 'INDIA'
     
     INTERSECT
     
     ---- MOVIES IN USA
     SELECT M.MOVIE_ID, M.GENRE, M.RELEASE_YEAR
     FROM MOVIES M
     INNER JOIN WATCH_HISTORY WH
     ON M.MOVIE_ID = WH.MOVIE_ID
     INNER JOIN USERS U
     ON WH.UID = U.UID
     WHERE U.COUNTRY = 'USA' ;
     
     

     
--3) Find the most popular genre per country.     
--4) Identify binge-watch users (watch > 300 minutes/day).
   
    SELECT U.UID, U.NAME, U.COUNTRY
    FROM USERS U
    JOIN (
        SELECT UID, DATE, SUM(WATCH_TIME_MIN) AS DAILY_MIN
        FROM WATCH_HISTORY
        GROUP BY UID, DATE
        HAVING SUM(WATCH_TIME_MIN) > 300
    ) BH
    ON U.UID = BH.UID;

   
--5) Year-wise new user acquisition trend.

     SELECT TO_CHAR( SIGNUP_DATE,'YYYY-MM') YEAR_MONTH,
            COUNT(*) NEW_USERS
     FROM USER 
     GROUP BY TO_CHAR( SIGNUP_DATE,'YYYY-MM')
     ORDER BY TO_CHAR( SIGNUP_DATE,'YYYY-MM');


/* ---------------------------------------------------------
   CASE STUDY 6: TELECOM CUSTOMER CHURN ANALYSIS
------------------------------------------------------------

TABLES:
1) CUSTOMERS(CUST_ID, NAME, CITY, JOIN_DATE, PLAN_TYPE)
2) CALL_RECORDS(CUST_ID, CALL_DATE, DURATION, CALL_TYPE) 
      -- CALL_TYPE = LOCAL / STD / ISD
3) RECHARGE(CUST_ID, RECHARGE_DATE, AMOUNT)
4) CHURN(CUST_ID, CHURN_DATE, REASON)

TASKS:*/

--1) Identify customers who stopped recharging in last 3 months. (NOT EXISTS)

     SELECT * 
     FROM CUSTOMERS C
     WHERE NOT EXISTS(
           SELECT 1 
           FROM RECHARGE R
           WHERE C.CUST_ID = R.CUST_ID
           AND RECHARGE_DATE >= ADD_MONTHS(SYSDATE,-3)
                      );
     

--2) Find customers whose average call duration increased month-over-month.(LAG)    
--3) City-wise highest revenue customers. (SUM + RANK)
     
     SELECT C.CITY,
            C.NAME,
            C.CUST_ID
            FROM CUSTOMERS C
      INNER JOIN RECHARGE R
      ON C.CUST_ID = R.CUST_ID
      WHERE C.CUST_ID IN(
      SELECT CUST_ID FROM RECHARGE
           
--4) Customers who made calls on 5+ consecutive days. (LAG + date difference)
--5) Find customers who churned but had high usage (top 10%). (WINDOW PERCENT_RANK)
------------------------------------------------------------ */



/* ---------------------------------------------------------
   CASE STUDY 7: AIRLINE BOOKING ANALYTICS
------------------------------------------------------------

TABLES:
1) FLIGHTS(FLIGHT_ID, SOURCE, DESTINATION, FLIGHT_DATE)
2) BOOKINGS(BOOKING_ID, FLIGHT_ID, PASSENGER_ID, BOOKING_DATE, FARE)
3) PASSENGERS(PASSENGER_ID, NAME, AGE, GENDER)
4) CANCELLATIONS(BOOKING_ID, CANCEL_DATE, REASON)

TASKS:    */
--1) Find flights with ZERO bookings. (MINUS / LEFT JOIN)

    SELECT F.* FROM FLIGHTS F
    LEFT JOIN BOOKINGS B
    ON F.FLIGHT_ID = B.FLIGHT_ID
    WHERE B.FLIGHT_ID IS NULL;
    
--2) Identify passengers who flew the most number of times. (COUNT + RANK)
     
     SELECT P.* FROM PASSENGERS P
     INNER JOIN (
     SELECT PASSENGER_ID,
            COUNT(*) AS NO_OF_TRIPS,
            RANK() OVER(ORDER BY COUNT(*) DESC) AS RN
     FROM BOOKINGS
     GROUP BY PASSENGER_ID) NT
     ON P.PASSENGER_ID = NT.PASSENGER_ID
     WHERE NT.RN = 1 ;
     
     
--3) Route-wise revenue and highest revenue route. (SUM + ORDER BY)

     SELECT F.SOURCE ||' - '|| F.DESTINATION AS ROUTE,
            F.FLIGHT_ID AS FLIGHT_ID,
            SUM(B.FARE) AS REVENUE    
     FROM FLIGHTS F
     INNER JOIN BOOKINGS B
     ON F.FLIGHT_ID = B.FLIGHT_ID
     GROUP BY F.SOURCE ||' - '|| F.DESTINATION, F.FLIGHT_ID
     ORDER BY SUM(B.FARE) DESC;
          
--4) Detect passengers with consecutive flight bookings. (LAG)
    
     SELECT CF.PASSENGER_ID, P.NAME, P.AGE, CF.FIRST_BOOKING, CF.NEXT_BOOKING
     FROM(
             SELECT PASSENGER_ID,
                    BOOKING_DATE AS NEXT_BOOKING,
                    LAG(BOOKING_DATE) OVER(PARTITION BY PASSENGER_ID ORDER BY BOOKING_DATE)FIRST_BOOKING 
             FROM BOOKINGS 
          ) CF
     INNER JOIN PASSENGERS P
     ON CF.PASSENGER_ID = P.PASSENGER_ID
     WHERE TRUNC(NEXT_BOOKING) = TRUNC(FIRST_BOOKING) +1;
     
--5) Find cancellation rate percentage per flight. (COUNT / TOTAL BOOKINGS)
------------------------------------------------------------ 



/* ---------------------------------------------------------
   CASE STUDY 8: FULL SQL INTERVIEW TEST (20 MIXED QUESTIONS)
------------------------------------------------------------

TABLES:
1) EMP(EMP_ID, NAME, DEPT, SALARY, JOIN_DATE)
2) PROJECT(PROJ_ID, PROJ_NAME, START_DATE, END_DATE)
3) EMP_PROJECT(EMP_ID, PROJ_ID, HOURS_WORKED)
4) SALARY_HIKE(EMP_ID, HIKE_DATE, HIKE_PERCENT)

TASKS: */

--1) List employees who are not assigned to any project. (LEFT JOIN)

     SELECT E.* 
     FROM EMP E
     LEFT JOIN EMP_PROJECT EP
     ON E.EMP_ID = EP.EMP_ID
     WHERE EP.EMP_ID IS NULL ;

--2) Find employees working on more than 2 projects. (COUNT + HAVING)

     SELECT E.EMP_ID, 
            E.NAME, 
            E.DEPT, 
            E.SALARY,
            E.JOIN_DATE 
     FROM EMP E
     INNER JOIN EMP_PROJECT EP
     ON E.EMP_ID = EP.EMP_ID
     GROUP BY E.EMP_ID, E.NAME, E.DEPT, E.SALARY, E.JOIN_DATE       
     HAVING COUNT(EP.PROJ_ID) > 2 ;
     
--3) Project-wise total hours worked. (SUM)

     SELECT P.PROJ_ID,
            P.PROJ_NAME,
            SUM(EP.HOURS_WORKED) AS TOTAL_HOURS_WORKED
     FROM PROJECT P
     INNER JOIN EMP_PROJECT EP
     ON P.PROJ_ID = EP.PROJ_ID
     GROUP BY P.PROJ_ID,P.PROJ_NAME ;

--4) Employees who worked continuously for 3+ projects (LAG on project dates).

       
--5) Highest paid employee per department. (RANK)

     SELECT *
     FROM   (
               SELECT EMP_ID, 
                      NAME,
                      DEPT,
                      SALARY AS HIGHEST_SAL_PER_DEPT,
                      JOIN_DATE,
                      RANK() OVER(PARTITION BY DEPT ORDER BY SALARY DESC) AS RN
               FROM EMP
             ) E
       WHERE RN=1;     

--6) Find employees whose salary increased more than 20% in a year. (LAG)

--7) List employees with same salary as their department average. (AVG OVER)
     SELECT * 
     FROM(
           SELECT EMP_ID, NAME, DEPT, SALARY, JOIN_DATE,
                  AVG(SALARY) OVER(PARTITION BY DEPT ) AS DEPT_AVG
           FROM EMP
          ) E
     WHERE E.SALARY = E.DEPT_AVG;
           
      

--8) Show project-wise employee count and average hours. (GROUP BY)
     
     SELECT PROJ_ID,
            COUNT(*) TOTAL_EMP,
            AVG(HOURS_WORKED) AVG_HOURS
     FROM EMP_PROJECT
     GROUP BY PROJ_ID ;
     
--9) Detect overlapping project assignments for an employee. (LEAD/LAG)

     

--10) Employees whose salary never increased. (NOT EXISTS)

      SELECT E.* 
      FROM EMP E
      WHERE NOT EXISTS (
                SELECT 1
                FROM SALARY_HIKE SH
                WHERE E.EMP_ID = SH.EMP_ID 
                   );
                   
       /* TABLES:
        1) EMP(EMP_ID, NAME, DEPT, SALARY, JOIN_DATE)
        2) PROJECT(PROJ_ID, PROJ_NAME, START_DATE, END_DATE)
        3) EMP_PROJECT(EMP_ID, PROJ_ID, HOURS_WORKED)
        4) SALARY_HIKE(EMP_ID, HIKE_DATE, HIKE_PERCENT) */
              
--11) Employees with salary hike in consecutive years. (LAG)
     
      SELECT * FROM EMP
      WHERE EMP_ID IN (
            SELECT EMP_ID
            FROM(
                    SELECT EMP_ID,
                          EXTRACT (YEAR FROM HIKE_DATE) AS THIS_YEAR,
                           LAG( EXTRACT (YEAR FROM HIKE_DATE)) OVER(PARTITION BY EMP_ID ORDER BY HIKE_DATE ) AS PREV_YEAR
                    FROM SALARY_HIKE
                 )
            WHERE THIS_YEAR = PREV_YEAR + 1
                       );

--12) Highest average project hours employee. (AVG + ORDER)
   
      SELECT * FROM EMP
      WHERE EMP_ID IN(
          SELECT EMP_ID
          FROM(
                SELECT EMP_ID,
                       AVG(HOURS_WORKED) AS AVG_HOURS,
                       RANK() OVER (ORDER BY AVG(HOURS_WORKED) DESC) AS RN
                FROM EMP_PROJECT
                GROUP BY EMP_ID
               ) AH 
          WHERE RN =1
          );
            
--13) Department-wise top 3 employees by salary. (DENSE_RANK)
      SELECT  EMP_ID,
             NAME,
             DEPT,
             SALARY,
             JOIN_DATE
      FROM(
            SELECT EMP_ID,
                   NAME,
                   DEPT,
                   SALARY,
                   JOIN_DATE,
                   DENSE_RANK() OVER (PARTITION BY DEPT ORDER BY SALARY DESC ) AS DRN
             FROM EMP
          )
       WHERE DRN <= 3;

--14) Employees with more hours than project average. (WINDOW)
     
      SELECT * 
      FROM EMP
      WHERE EMP_ID IN(
      SELECT EMP_ID 
      FROM(
            SELECT EMP_ID,
                   HOURS_WORKED,
                   AVG(HOURS_WORKED) OVER(PARTITION BY PROJ_ID) PROJ_AVG
            FROM EMP_PROJECT
           )
      WHERE HOURS_WORKED > PROJ_AVG
                         );

                         
--15) Employees who joined in last 2 months but got a hike. (JOIN + date)

      SELECT E.* FROM EMP E
      INNER JOIN SALARY_HIKE SH
      ON E.EMP_ID = SH.EMP_ID
      WHERE E.JOIN_DATE >= ADD_MONTHS(SYSDATE,-2)
      AND SH.HIKE_DATE >= ADD_MONTHS(SYSDATE,-2);     

--16) Project with longest duration. (DATEDIFF / MAX)

      SELECT PROJ_ID,
             PROJ_NAME
      FROM (
            SELECT PROJ_ID,
                   PROJ_NAME,
                   TRUNC(END_DATE)-TRUNC(START_DATE) AS DURATION
             FROM PROJECT
          )
       WHERE DURATION =  (
                            SELECT MAX(TRUNC(END_DATE) - TRUNC(START_DATE))
                            FROM PROJECT
                          );             

 /* TABLES:
        1) EMP(EMP_ID, NAME, DEPT, SALARY, JOIN_DATE)
        2) PROJECT(PROJ_ID, PROJ_NAME, START_DATE, END_DATE)
        3) EMP_PROJECT(EMP_ID, PROJ_ID, HOURS_WORKED)
        4) SALARY_HIKE(EMP_ID, HIKE_DATE, HIKE_PERCENT) */
--17) Year-wise salary hike count per employee. (GROUP BY YEAR)

        

--18) Find employees working on all projects. (DIVISION logic)
--19) Employees who never changed project. (COUNT DISTINCT)
--20) Employees who worked maximum cumulative hours. (SUM + ORDER)
------------------------------------------------------------


-- Find the highest paid employee per department.
/*TABLES:
1) EMP(EMP_ID, NAME, DEPT, SALARY, JOIN_DATE)
2) PERFORMANCE(EMP_ID, YEAR, RATING)
3) DEPARTMENTS(DEPT, MANAGER_ID)  */
        
          SELECT  EMP_ID, NAME, DEPT, SALARY, JOIN_DATE         
          FROM(
                 SELECT EMP_ID, NAME, DEPT, SALARY, JOIN_DATE,
                 RANK() OVER(PARTITION BY DEPT ORDER BY SALARY DESC) AS RN
                 FROM EMP
               )
          WHERE RN=1
          
          
          
          
-- CASE STUDY 1: HOSPITAL APPOINTMENT ANALYTICS

-- You are working as a Data Analyst in a large hospital.
-- The management wants insights into patient appointments,
-- doctors’ schedules, and missed appointments.

-- TABLES:
-- PATIENT(PATIENT_ID, NAME, AGE, GENDER)
-- DOCTOR(DOC_ID, DOC_NAME, SPECIALITY)
-- APPOINTMENT(APP_ID, PATIENT_ID, DOC_ID, APPT_DATE, STATUS)
-- STATUS can be: 'COMPLETED', 'MISSED', 'CANCELLED'

-- QUESTIONS TO SOLVE:
-- 1) Find the doctor with the highest number of completed appointments in the last 60 days.
   
   SELECT * 
   FROM DOCTOR
   WHERE DOC_ID =(
         SELECT DOC_ID
         FROM(
               SELECT DOC_ID,
                      COUNT(*) APPT,
                      RANK() OVER(ORDER BY COUNT(*) DESC) AS RN
               FROM APPOINTMENT
               WHERE STATUS = 'COMPLETED'
               AND APPT_DATE >= SYSDATE-60 
               GROUP BY DOC_ID
             )
         WHERE RN=1
                   );

-- 2) List patients who have missed more than 3 appointments in the last 6 months.
      
      SELECT *
      FROM PATIENT
      WHERE PATIENT_ID IN (
            SELECT PATIENT_ID 
            FROM (
                    SELECT PATIENT_ID,
                           COUNT(*) TOTAL_MISSED_APPT
                    FROM APPOINTMENT
                    WHERE STATUS = 'MISSED'
                    AND APPT_DATE >= ADD_MONTHS(SYSDATE,-6)
                    GROUP BY PATIENT_ID 
                  )
             WHERE TOTAL_MISSED_APPT > 3
                           );

-- 3) For each speciality, show completion rate = completed / total appointments.

      WITH TA AS(
                 SELECT DOC_ID,
                        COUNT(*) AS TOTAL_APPT
                 FROM APPOINTMENT
                 GROUP BY DOC_ID 
                ),
                      
           CA AS(
                 SELECT DOC_ID,
                        COUNT(*) AS COMPLETED_APPT
                 FROM APPOINTMENT
                 WHERE STATUS ='COMPLETED'
                 GROUP BY DOC_ID 
                )
          SELECT D.SPECIALITY ,
                 SUM(CA.COMPLETED_APPT) / SUM(TA.TOTAL_APPT) *100 AS COMPLETION_RATE
          FROM DOCTOR D
          INNER JOIN TA
          ON TA.DOC_ID = D.DOC_ID
          LEFT JOIN CA
          ON CA.DOC_ID = D.DOC_ID
          GROUP BY D.SPECIALITY   ;

-- 4) Find doctors who have ZERO cancelled appointments in the past 30 days.

   SELECT D.DOC_ID, 
          D.DOC_NAME,
          D.SPECIALITY
   FROM DOCTOR D
   WHERE NOT EXISTS( 
             SELECT 1
             FROM APPOINTMENT A
             WHERE A.STATUS = 'CANCELLED'
               AND A.APPT_DATE >= SYSDATE-30
               AND D.DOC_ID = A.DOC_ID
         );            

-- 5) Identify patients who visited more than 3 different doctors.
   
   SELECT P.*,
          V.NO_OF_DOC_VISITED
   FROM PATIENT P
   INNER JOIN (
       SELECT PATIENT_ID,
              COUNT( DISTINCT DOC_ID)  AS NO_OF_DOC_VISITED
       FROM APPOINTMENT
       GROUP BY PATIENT_ID
       ) V
   ON P.PATIENT_ID = V.PATIENT_ID
   WHERE V.NO_OF_DOC_VISITED > 3 ;

-- CASE STUDY 2: FOOD DELIVERY PLATFORM ANALYSIS

-- You are working with a food delivery company like Zomato/Swiggy.
-- The team needs analytics regarding restaurants, orders, and delivery partners.

-- TABLES:
-- RESTAURANT(REST_ID, REST_NAME, CITY, RATING)
-- CUSTOMER(CUST_ID, NAME, CITY)
-- DELIVERY_PARTNER(DP_ID, DP_NAME)
-- ORDERS(ORDER_ID, CUST_ID, REST_ID, DP_ID, ORDER_TIME, DELIVERY_TIME, AMOUNT)

-- BUSINESS QUESTIONS:
-- 1) Find the top 5 restaurants with the highest average order value in each city.
-- 2) Calculate the delivery time (minutes) for each order and find partners 
--    whose average delivery time is BELOW the city average.
-- 3) For each customer, compute total spend and number of orders.
-- 4) Identify restaurants that have not received any orders in the last 45 days.
-- 5) Find the top 10 customers who ordered from the HIGHEST number of unique restaurants.

                       
                
                 
         
                 
                


