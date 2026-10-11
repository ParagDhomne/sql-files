/* ----------------------------------------------------------
   CASE STUDY 1: E-COMMERCE ORDER ANALYTICS
   ----------------------------------------------------------
   TABLES:
   1) CUSTOMERS(CUST_ID, NAME, CITY, AGE, JOIN_DATE)
   2) ORDERS(ORDER_ID, CUST_ID, ORDER_DATE, ORDER_AMOUNT, STATUS)
   3) ORDER_ITEMS(ITEM_ID, ORDER_ID, PRODUCT_ID, QTY, PRICE)
   4) PRODUCTS(PRODUCT_ID, CATEGORY, PRODUCT_NAME)

   TASKS:  */
--   a) Find the top 5 customers by total spend.
                    
      SELECT *
      FROM CUSTOMERS
      WHERE CUST_ID IN (
       SELECT CUST_ID
       FROM (
             SELECT CUST_ID,
                    SUM(ORDER_AMOUNT) AS TOTAL_SPEND,
                    RANK() OVER(ORDER BY SUM(ORDER_AMOUNT) DESC) AS RN
             FROM ORDERS
             GROUP BY CUST_ID
            )
       WHERE RN <= 5
     );



--   b) Identify customers who have not ordered anything in the last 90 days.

     SELECT C.*
     FROM CUSTOMERS C
     WHERE NOT EXISTS (
           SELECT 1 
           FROM ORDERS O
           WHERE O.ORDER_DATE >= SYSDATE-90
           AND C.CUST_ID = O.CUST_ID
                        );
                       
S

--   c) Find month-over-month revenue change using LAG().
     
     SELECT MONTH,
           THIS_MONTH_REV,
           LAST_MONTH_REV,
           THIS_MONTH_REV - LAST_MONTH_REV AS DIFF_IN_REV
     FROM (
        SELECT 
            TO_CHAR(ORDER_DATE, 'YYYY-MM') AS MONTH,
            SUM(ORDER_AMOUNT) AS THIS_MONTH_REV,
            LAG(SUM(ORDER_AMOUNT)) OVER (ORDER BY TO_CHAR(ORDER_DATE, 'YYYY-MM')) AS LAST_MONTH_REV
        FROM ORDERS
        GROUP BY TO_CHAR(ORDER_DATE, 'YYYY-MM')
        ORDER BY TO_CHAR(ORDER_DATE, 'YYYY-MM')
        );

   
--   d) For each category, find the best-selling product (by quantity).

      SELECT CATEGORY,
             PRODUCT_ID,
             PRODUCT_NAME,
             TOTAL_QTY
      FROM (
              SELECT 
                  P.CATEGORY,
                  P.PRODUCT_ID,
                  P.PRODUCT_NAME,
                  SUM(O.QTY) AS TOTAL_QTY,
                  RANK() OVER (PARTITION BY P.CATEGORY 
                               ORDER BY SUM(O.QTY) DESC) AS RN
              FROM PRODUCTS P
              INNER JOIN ORDER_ITEMS O
              ON P.PRODUCT_ID = O.PRODUCT_ID
              GROUP BY P.CATEGORY, P.PRODUCT_ID, P.PRODUCT_NAME
           )
      WHERE RN = 1;

     
--   e) Find customers whose average order value is higher than the overall platform average.
   
     SELECT * FROM CUSTOMERS
     WHERE CUST_ID IN(
     SELECT  DISTINCT CUST_ID 
     FROM(
           SELECT CUST_ID,
                  AVG(ORDER_AMOUNT) OVER (PARTITION BY CUST_ID) CUST_AVG,
                  AVG(ORDER_AMOUNT) OVER()PLATFORM_AVG
           FROM ORDERS
           )
      WHERE CUST_AVG > PLATFORM_AVG
            );
      
     


----------------------------------------------------------- 
/* ----------------------------------------------------------
   CASE STUDY 2: BANKING — TRANSACTION MONITORING
   ----------------------------------------------------------
   TABLES:
   1) ACCOUNTS(ACC_NO, CUST_ID, OPEN_DATE, BALANCE)
   2) TRANSACTIONS(TXN_ID, ACC_NO, TXN_DATE, AMOUNT, TXN_TYPE)
      -- TXN_TYPE = 'DEBIT' or 'CREDIT'
   3) CUSTOMERS(CUST_ID, NAME, CITY, AGE)

   TASKS: */
-- a) Identify top 10 high-value customers by total debit amount.
     WITH DEBIT_TOTAL AS (
       SELECT ACC_NO,
              SUM(AMOUNT) AS TOTAL_DEBIT,
              RANK() OVER (ORDER BY SUM(AMOUNT) DESC) AS RN
          FROM TRANSACTIONS
          WHERE TXN_TYPE = 'DEBIT'
          GROUP BY ACC_NO
      )
      SELECT 
          A.ACC_NO,
          A.CUST_ID,
          A.OPEN_DATE,
          A.BALANCE,
          D.TOTAL_DEBIT
      FROM ACCOUNTS A
      JOIN DEBIT_TOTAL D
      ON A.ACC_NO = D.ACC_NO
      WHERE D.RN <= 10;

   
-- b) Detect accounts where balance increased without any credit transaction
      --(use LAG balance comparison + checking missing credit records).
    
 /*TABLES:
   1) ACCOUNTS(ACC_NO, CUST_ID, OPEN_DATE, BALANCE)
   2) TRANSACTIONS(TXN_ID, ACC_NO, TXN_DATE, AMOUNT, TXN_TYPE)
      -- TXN_TYPE = 'DEBIT' or 'CREDIT'
   3) CUSTOMERS(CUST_ID, NAME, CITY, AGE) */
   
-- c) Find customers who perform more than 5 transactions per day (frequent users).
   
    SELECT DISTINCT A.CUST_ID
    FROM (
            SELECT 
                ACC_NO,
                TRUNC(TXN_DATE) AS TXN_DAY,
                COUNT(*) AS TXN_PER_DAY
            FROM TRANSACTIONS
            GROUP BY ACC_NO, TRUNC(TXN_DATE)
         ) T
    INNER JOIN ACCOUNTS A ON A.ACC_NO = T.ACC_NO
    WHERE T.TXN_PER_DAY >= 5;

-- d) Calculate rolling 7-day transaction total per account using window SUM().
   
   
   
-- e) Detect suspicious accounts:
     -- more than 3 high-value (> ₹50,000) debits in one day.
----------------------------------------------------------- 
/* ----------------------------------------------------------
   CASE STUDY 3: HOSPITAL — PATIENT & DOCTOR ANALYTICS
   ----------------------------------------------------------
   TABLES:
   1) PATIENT(PATIENT_ID, NAME, AGE, CITY, DISEASE)
   2) DOCTOR(DOC_ID, NAME, SPECIALIZATION, JOIN_DATE)
   3) APPOINTMENT(APP_ID, PATIENT_ID, DOC_ID, APP_DATE, FEE)
   4) TREATMENT(TREAT_ID, PATIENT_ID, DOC_ID, START_DATE, END_DATE, COST)

   TASKS:
   a) Find total revenue generated by each doctor.
   
      
   
   b) Identify patients who visited more than 3 different doctors.
   c) Find the average treatment duration for each specialization.
   d) Categorize patients into age groups (0-18, 19-40, 41-60, 60+) 
      and count per group. */
      
      SELECT CASE 
                WHEN AGE BETWEEN 0 AND 18 THEN '0-18'
                  WHEN AGE BETWEEN 19 AND 40 THEN '19-40'
                    WHEN AGE BETWEEN 41 AND 60 THEN '41-60'
                      ELSE '60+'
                        END,
             COUNT(*) AS COUNT_PER_GROUP 
      FROM PATIENT
      GROUP BY 
            CASE 
                WHEN AGE BETWEEN 0 AND 18 THEN '0-18'
                  WHEN AGE BETWEEN 19 AND 40 THEN '19-40'
                    WHEN AGE BETWEEN 41 AND 60 THEN '41-60'
                      ELSE '60+'
                        END  ;
                        
      
      
      
      
      
   e) Find doctors whose total appointment fee + treatment cost 
      is above the hospital average earnings.
----------------------------------------------------------- */
