/* ---------------------------------------------------------
   CASE STUDY 1: HR ANALYTICS
------------------------------------------------------------

TABLES:
1) EMPLOYEES(EMP_ID, NAME, DEPT, SALARY, JOIN_DATE)
2) DEPARTMENTS(DEPT, MANAGER_ID)
3) PERFORMANCE(EMP_ID, YEAR, RATING)

TASKS:
1) Find employees who never received a rating. (LEFT JOIN / MINUS)
2) Find employees earning more than their department average. (WINDOW FUNCTION)
3) Find departments where NO employee has joined in last 2 years.
4) Find employees who had ratings above 4 in consecutive years.
5) Find highest-paid employee per department. (RANK – WINDOW)
------------------------------------------------------------ */



/* ---------------------------------------------------------
   CASE STUDY 2: BANKING TRANSACTIONS
------------------------------------------------------------

TABLES:
1) ACCOUNT(ACC_NO, NAME, CITY, OPEN_DATE)
2) TRANSACTIONS(TXN_ID, ACC_NO, TXN_TYPE, AMOUNT, TXN_DATE)
3) BRANCH(BRANCH_ID, CITY, MANAGER)

TASKS:
1) Find customers with no transactions. (LEFT JOIN / MINUS)
2) Find top 10 customers by total debit amount. (SUM + WINDOW RANK)
3) Find customers whose average credit amount is more than 20,000.
4) Detect accounts with transactions on consecutive days. (LAG)
5) City-wise total debit vs credit amount. (GROUP BY)
------------------------------------------------------------ */



/* ---------------------------------------------------------
   CASE STUDY 3: HOSPITAL PATIENT MANAGEMENT
------------------------------------------------------------

TABLES:
1) PATIENT(PID, NAME, AGE, GENDER)
2) VISIT(PID, DOCTOR_ID, VISIT_DATE, DIAGNOSIS)
3) DOCTORS(DOCTOR_ID, NAME, SPECIALITY)

TASKS:
1) List patients who never visited the hospital. (MINUS / LEFT JOIN)
2) Age-group wise patient distribution (0–18, 19–40, 41–60, 60+).
3) Find doctors who treated more than 20 patients.
4) Identify patients who visited on consecutive dates. (LAG)
5) Doctor-wise most common diagnosis (MAX COUNT).
------------------------------------------------------------ */



/* ---------------------------------------------------------
   CASE STUDY 4: E-COMMERCE SALES ANALYTICS
------------------------------------------------------------

TABLES:
1) PRODUCTS(PID, NAME, CATEGORY, PRICE)
2) ORDERS(OID, CUSTOMER_ID, ORDER_DATE, TOTAL_AMOUNT)
3) ORDER_ITEMS(OID, PID, QTY, PRICE)

TASKS:
1) Identify products that were NEVER ordered. (MINUS)
2) Category-wise top-selling product. (SUM + RANK)
3) Customer-wise total revenue contribution.
4) Month-wise revenue trend. (GROUP BY MONTH)
5) Identify the most profitable product category. (SUM(QTY*PRICE))
------------------------------------------------------------ */



/* ---------------------------------------------------------
   CASE STUDY 5: RETAIL INVENTORY MANAGEMENT
------------------------------------------------------------

TABLES:
1) PRODUCTS(PID, NAME, CATEGORY, PRICE)
2) STOCK(PID, STORE_ID, QTY)
3) SALES(SALE_ID, PID, STORE_ID, QTY_SOLD, SALE_DATE)

TASKS:
1) Find products that are sold but have zero stock. (JOIN or INTERSECT)
2) Detect products present in stock table but NEVER sold. (MINUS)
3) Category-wise revenue & best-selling product per category. (SUM + RANK)
4) Store-wise stock shortage prediction (QTY < 10).
5) Month-wise revenue vs month-wise purchase cost. (GROUP BY MONTH)
------------------------------------------------------------ */



/* ---------------------------------------------------------
   CASE STUDY 6: TELECOM CUSTOMER CHURN ANALYSIS
------------------------------------------------------------

TABLES:
1) CUSTOMERS(CUST_ID, NAME, CITY, JOIN_DATE, PLAN_TYPE)
2) CALL_RECORDS(CUST_ID, CALL_DATE, DURATION, CALL_TYPE) 
      -- CALL_TYPE = LOCAL / STD / ISD
3) RECHARGE(CUST_ID, RECHARGE_DATE, AMOUNT)
4) CHURN(CUST_ID, CHURN_DATE, REASON)

TASKS:
1) Identify customers who stopped recharging in last 3 months. (NOT EXISTS)
2) Find customers whose average call duration increased month-over-month. (LAG)
3) City-wise highest revenue customers. (SUM + RANK)
4) Customers who made calls on 5+ consecutive days. (LAG + date difference)
5) Find customers who churned but had high usage (top 10%). (WINDOW PERCENT_RANK)
------------------------------------------------------------ */



/* ---------------------------------------------------------
   CASE STUDY 7: AIRLINE BOOKING ANALYTICS
------------------------------------------------------------

TABLES:
1) FLIGHTS(FLIGHT_ID, SOURCE, DESTINATION, FLIGHT_DATE)
2) BOOKINGS(BOOKING_ID, FLIGHT_ID, PASSENGER_ID, BOOKING_DATE, FARE)
3) PASSENGERS(PASSENGER_ID, NAME, AGE, GENDER)
4) CANCELLATIONS(BOOKING_ID, CANCEL_DATE, REASON)

TASKS:
1) Find flights with ZERO bookings. (MINUS / LEFT JOIN)
2) Identify passengers who flew the most number of times. (COUNT + RANK)
3) Route-wise revenue and highest revenue route. (SUM + ORDER BY)
4) Detect passengers with consecutive flight bookings. (LAG)
5) Find cancellation rate percentage per flight. (COUNT / TOTAL BOOKINGS)
------------------------------------------------------------ */



/* ---------------------------------------------------------
   CASE STUDY 8: FULL SQL INTERVIEW TEST (20 MIXED QUESTIONS)
------------------------------------------------------------

TABLES:
1) EMP(EMP_ID, NAME, DEPT, SALARY, JOIN_DATE)
2) PROJECT(PROJ_ID, PROJ_NAME, START_DATE, END_DATE)
3) EMP_PROJECT(EMP_ID, PROJ_ID, HOURS_WORKED)
4) SALARY_HIKE(EMP_ID, HIKE_DATE, HIKE_PERCENT)

TASKS:
1) List employees who are not assigned to any project. (LEFT JOIN)
2) Find employees working on more than 2 projects. (COUNT + HAVING)
3) Project-wise total hours worked. (SUM)
4) Employees who worked continuously for 3+ projects (LAG on project dates).
5) Highest paid employee per department. (RANK)
6) Find employees whose salary increased more than 20% in a year. (LAG)
7) List employees with same salary as their department average. (AVG OVER)
8) Show project-wise employee count and average hours. (GROUP BY)
9) Detect overlapping project assignments for an employee. (LEAD/LAG)
10) Employees whose salary never increased. (NOT EXISTS)
11) Employees with salary hike in consecutive years. (LAG)
12) Highest average project hours employee. (AVG + ORDER)
13) Department-wise top 3 employees by salary. (DENSE_RANK)
14) Employees with more hours than project average. (WINDOW)
15) Employees who joined in last 2 months but got a hike. (JOIN + date)
16) Project with longest duration. (DATEDIFF / MAX)
17) Year-wise salary hike count per employee. (GROUP BY YEAR)
18) Find employees working on all projects. (DIVISION logic)
19) Employees who never changed project. (COUNT DISTINCT)
20) Employees who worked maximum cumulative hours. (SUM + ORDER)
------------------------------------------------------------ */
