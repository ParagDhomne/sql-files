CREATE TABLE SALESPEOPLE
(
       SNUM NUMBER CONSTRAINT PK_SNUM PRIMARY KEY,
       SNAME VARCHAR2(20),
       CITY VARCHAR2(30),
       COMM NUMBER
);

INSERT INTO SALESPEOPLE VALUES(1001,'Peel','London',0.12);
INSERT INTO SALESPEOPLE VALUES(1002,'Serres','San Jose',0.13);
INSERT INTO SALESPEOPLE VALUES(1004,'Monika','London',0.11);
INSERT INTO SALESPEOPLE VALUES(1007,'Rifkin','Barcelona',0.15);
INSERT INTO SALESPEOPLE VALUES(1003,'Axelrod','New York',0.10);
INSERT INTO SALESPEOPLE VALUES(1005,'Franc','London',0.26);

select * from salespeople;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE CUSTOMERS
(
       CNUM NUMBER CONSTRAINT PK_CNUM PRIMARY KEY,
       CNAME VARCHAR2(30),
       CITY VARCHAR2(20),
       RATING NUMBER,
       SNUM NUMBER,
       FOREIGN KEY(SNUM) REFERENCES SALESPEOPLE(SNUM)
);

INSERT INTO CUSTOMERS VALUES(2001,'Hoffman','London',100,1001);
INSERT INTO CUSTOMERS VALUES(2002,'Giovanni','Rome',200,1003);
INSERT INTO CUSTOMERS VALUES(2003,'Liu','San Jose',200,1002);
INSERT INTO CUSTOMERS VALUES(2004,'Grass','Berlin',300,1002);
INSERT INTO CUSTOMERS VALUES(2006,'Clemens','London',100,1001);
INSERT INTO CUSTOMERS VALUES(2008,'Cisneros','San Jose',300,1007);
INSERT INTO CUSTOMERS VALUES(2007,'Pereira','Rome',100,1004);

select * from customers;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ORDERS
(
       ONUM NUMBER CONSTRAINT PK_ONUM PRIMARY KEY,
       AMT NUMBER,
       ODATE DATE,
       CNUM NUMBER,
       FOREIGN KEY(CNUM) REFERENCES CUSTOMERS(CNUM),
       SNUM NUMBER,
       FOREIGN KEY(SNUM) REFERENCES SALESPEOPLE(SNUM)
);

INSERT INTO ORDERS VALUES(3001,18.69,TO_DATE('03/Oct/96 12:30','DD/Mon/YY HH24:MI'),2008,1007);
INSERT INTO ORDERS VALUES(3003,767.19,TO_DATE('03/Oct/96 13:45','DD/Mon/YY HH24:MI'),2001,1001);
INSERT INTO ORDERS VALUES(3002,1900.10,TO_DATE('03/Oct/96 12:05','DD/Mon/YY HH24:MI'),2007,1004);
INSERT INTO ORDERS VALUES(3005,5160.45,TO_DATE('03/Oct/96 14:00','DD/Mon/YY HH24:MI'),2003,1002);
INSERT INTO ORDERS VALUES(3006,1098.16,TO_DATE('03/Oct/96 13:37','DD/Mon/YY HH24:MI'),2008,1007);
INSERT INTO ORDERS VALUES(3009,1713.23,TO_DATE('04/Oct/96 15:21','DD/Mon/YY HH24:MI'),2002,1003);
INSERT INTO ORDERS VALUES(3007,75.75,TO_DATE('04/Oct/96 16:02','DD/Mon/YY HH24:MI'),2002,1003);
INSERT INTO ORDERS VALUES(3008,4723.00,TO_DATE('05/Oct/96 12:07','DD/Mon/YY HH24:MI'),2006,1001);
INSERT INTO ORDERS VALUES(3010,1309.95,TO_DATE('06/Oct/96 13:12','DD/Mon/YY HH24:MI'),2004,1002);
INSERT INTO ORDERS VALUES(3011,9891.88,TO_DATE('06/Oct/96 13:09','DD/Mon/YY HH24:MI'),2006,1001);
INSERT INTO ORDERS VALUES(3012,3455.78,TO_DATE('04/Oct/96 15:21','DD/Mon/YY HH24:MI'),2002,1003);
INSERT INTO ORDERS VALUES(3013,1245.98,TO_DATE('04/Oct/96 16:32','DD/Mon/YY HH24:MI'),2002,1003);
INSERT INTO ORDERS VALUES(3014,3721.53,TO_DATE('05/Oct/96 12:45','DD/Mon/YY HH24:MI'),2006,1001);
INSERT INTO ORDERS VALUES(3015,734.50,TO_DATE('06/Oct/96 13:16','DD/Mon/YY HH24:MI'),2004,1002);
INSERT INTO ORDERS VALUES(3016,1729.67,TO_DATE('06/Oct/96 13:07','DD/Mon/YY HH24:MI'),2006,1001);


SELECT * FROM ORDERS;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--1.  List all customers with a rating of 100.

      SELECT * FROM CUSTOMERS
      WHERE RATING=100;

--2.  Find all records in the Customer table with NULL values in the city column.

      SELECT * FROM CUSTOMERS 
      WHERE CITY IS NULL;      

--3.  Find the largest order taken by each salesperson on each date.

      SELECT O.SNUM, S.SNAME, TRUNC(ODATE), MAX(AMT) LARGEST_ORDER FROM ORDERS O
      INNER JOIN SALESPEOPLE S
      ON S.SNUM=O.SNUM
      GROUP BY TRUNC(ODATE),O.SNUM, S.SNAME;
      
--4.  Arrange the Orders table by descending customer number.

      SELECT * FROM ORDERS
      ORDER BY CNUM DESC;
      
--5.  Find which salespeople currently have orders in the Orders table.
      
      SELECT * FROM SALESPEOPLE
      WHERE SNUM IN(SELECT SNUM FROM ORDERS);

--6.  List names of all customers matched with the salespeople serving them.

      SELECT C.CNAME CUSTOMER, S.SNAME SALESMAN FROM CUSTOMERS C
      INNER JOIN SALESPEOPLE S
      ON C.SNUM=S.SNUM;
      
--7.  Find the names and numbers of all salespeople who had more than one customer.

      SELECT SNUM, SNAME FROM SALESPEOPLE
      WHERE SNUM IN(
      SELECT SNUM FROM CUSTOMERS
      GROUP BY SNUM
      HAVING COUNT(*)>1);
     
--8.  Count the orders of each of the salespeople and output the results in descending order.
      
      SELECT S.SNAME , COUNT(*) NO_OF_ORDERS FROM SALESPEOPLE S
      INNER JOIN ORDERS O
      ON S.SNUM=O.SNUM
      GROUP BY SNAME 
      ORDER BY COUNT(*) DESC;
      
--9.  List the Customer table if and only if one or more of the customers in the Customer tables are located in San Jose.
   
      SELECT * FROM customers
      WHERE EXISTS (
      SELECT 1
      FROM customers
      WHERE city = 'San Jose'
       );
       
--10. Match salespeople to customers according to what city they lived in.

      SELECT S.SNAME,C.CNAME FROM SALESPEOPLE S
      INNER JOIN CUSTOMERS C
      ON S.CITY=C.CITY;
      
--11. Find the largest order taken by each salesperson.

      SELECT DISTINCT SNUM,MAX(AMT) OVER(PARTITION BY SNUM) LARGEST_ORDER FROM ORDERS;
     
--12. Find customers in San Jose who has a rating above 200.

      SELECT * FROM CUSTOMERS
      WHERE UPPER(CITY)='SAN JOSE'
      AND RATING>200;
      
--13. List the names and commissions of all salespeople in London.

      SELECT SNAME,COMM COMMISSION FROM SALESPEOPLE
      WHERE UPPER(CITY)='LONDON';
      
--14. List all the orders of salesperson Monika from the Orders table.

      SELECT * FROM ORDERS
      WHERE SNUM=(SELECT SNUM FROM SALESPEOPLE
      WHERE UPPER(SNAME)='MONIKA');
      
--15. Find all customers with orders on October 3.
      
      SELECT * FROM CUSTOMERS
      WHERE CNUM IN (SELECT CNUM FROM ORDERS
      WHERE TRUNC(ODATE)=TO_DATE('03-OCT-96','DD-MON-YY'));
      
--16. Give the sums of the amounts from the orders table, grouped by date.
      
      SELECT TRUNC(ODATE), SUM(AMT) FROM ORDERS
      GROUP BY TRUNC(ODATE);
      
--17. Eliminating all those dates where the SUM was not at least 2000.00 above the MAX amount.

      SELECT TRUNC(ODATE) ORDER_DATE, SUM(AMT) TOTAL_AMOUNT FROM ORDERS
      GROUP BY TRUNC(ODATE)
      HAVING SUM(AMT) >=(SELECT MAX(AMT)+2000 FROM ORDERS);
      
--18. Select all orders that had amounts that were greater than at least one of the orders from October 6.

      SELECT * FROM ORDERS
      WHERE AMT > (SELECT MIN(AMT) FROM ORDERS
      WHERE TRUNC(ODATE)=TO_DATE('06-OCT-96','DD-MON-YY'));
      
--19. Write a query that uses the EXISTS operator to extract all salespeople who have customers with a rating of 300.

      SELECT * FROM SALESPEOPLE S
      WHERE EXISTS( SELECT 1
      FROM CUSTOMERS C
      WHERE C.RATING=300
      AND S.SNUM=C.SNUM);
      
--20. Find all pairs of customers having the same rating.
      
      SELECT C1.CNAME, C2.CNAME FROM CUSTOMERS C1
      JOIN CUSTOMERS  C2
      ON C1.RATING=C2.RATING;
         
--21. Find all customers with CNUM, 1000 above the SNUM of Serres.

      SELECT * FROM CUSTOMERS
      WHERE CNUM >
      ( SELECT SNUM FROM SALESPEOPLE
      WHERE UPPER(SNAME)='SERRES')+1000;
      
--22. Give the salespeople’s commissions as percentage instead of decimal numbers.

      SELECT SNUM,SNAME,CITY,COMM*100 COMMISSION_AS_PCT FROM SALESPEOPLE;
      
--23. Find the largest order taken by each salesperson on each date, eliminating those MAX orders, which are less than $3000.00 in value.

      SELECT S.SNUM, S.SNAME ,MAX(AMT) LARGEST_ORDER ,TRUNC(ODATE) ODATE FROM SALESPEOPLE S
      INNER JOIN ORDERS O
      ON S.SNUM=O.SNUM
      GROUP BY S.SNUM,S.SNAME, TRUNC(ODATE)
      HAVING MAX(AMT)>3000;
      
--24. List the largest orders on October 3, for each salesperson.

      SELECT SNUM, MAX(AMT)MAX_ORDER ,TRUNC(ODATE) ODATE FROM ORDERS
      GROUP BY TRUNC(ODATE),SNUM 
      HAVING TRUNC(ODATE)= TO_DATE('03-Oct-96','DD-Mon-YY');
      
--25. Find all customers located in cities where Serres (SNUM 1002) has customers.

      SELECT * FROM CUSTOMERS
      WHERE CITY IN
      (SELECT CITY FROM CUSTOMERS
      WHERE SNUM=1002);
      
--26. Select all customers with a rating above 200.00.

      SELECT * FROM CUSTOMERS
      WHERE RATING>200;
      
--27. Count the number of salespeople currently listing orders in the Orders table.

      SELECT COUNT(DISTINCT SNUM) WORKING_SPEOPLE FROM ORDERS;
      
--28. Write a query that produces all customers serviced by salespeople with a commission above 12%. Output the customer’s name and the salesperson‘s rate of commission.

      SELECT C.CNAME, S.COMM FROM CUSTOMERS C
      INNER JOIN SALESPEOPLE S
      ON C.SNUM=S.SNUM
      WHERE S.COMM>.12
      
--29. Find salespeople who have multiple customers.

      SELECT SNAME FROM SALESPEOPLE
      WHERE SNUM IN (SELECT SNUM FROM CUSTOMERS
      GROUP BY SNUM
      HAVING COUNT(*)>1);
      
--30. Find salespeople with customers located in their city.

      SELECT S.* FROM SALESPEOPLE S
      WHERE S.SNUM IN(SELECT SNUM FROM CUSTOMERS C
      WHERE S.CITY=C.CITY);
      
--31. Find all salespeople whose name starts with ‘P’ and the fourth character is ‘I’.

      SELECT * FROM SALESPEOPLE
      WHERE UPPER(SNAME) LIKE 'P__I%';
      
--32. Write a query that uses a sub query to obtain all orders for the customer named ‘Cisneros’. Assume you do not know his customer number.

      SELECT * FROM ORDERS
      WHERE CNUM = (SELECT CNUM FROM CUSTOMERS
      WHERE CNAME='Cisneros');
      
--33. Find the largest orders for ‘Serres’ and ‘Rifkin’.

      SELECT SNUM,MAX(AMT)  FROM ORDERS
      GROUP BY SNUM
      HAVING SNUM IN(SELECT SNUM FROM SALESPEOPLE
      WHERE UPPER(SNAME) ='SERRES'
      OR UPPER(SNAME)='RIFKIN');
      
--34. Extract the Salespeople table in the following order: SNUM, SNAME, COMMISSION, CITY.

      SELECT SNUM,SNAME,COMM AS COMMISSION,CITY FROM SALESPEOPLE;
      
--35. Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.

      SELECT * FROM CUSTOMERS 
      WHERE ASCII(SUBSTR(CNAME,1,1)) BETWEEN ASCII('A') AND ASCII('G') ;
      
--36. Select all the possible combinations of customers that you can assign.

      SELECT * FROM CUSTOMERS 
       CROSS JOIN SALESPEOPLE ;
     
--37. Select all orders that are greater than the average for October 4.

      SELECT * FROM ORDERS
      WHERE AMT>(SELECT AVG(AMT) FROM ORDERS
      WHERE TRUNC(ODATE)=TO_DATE('04-Oct-96','DD-Mon-YY'));
      
--38. Write a select command using a correlated sub query that selects the names and numbers of all customers with ratings equal to the maximum for their city.
     
      SELECT C1.CNAME, C1.CNUM  FROM CUSTOMERS C1 
      WHERE C1.RATING =(
      SELECT  MAX(C2.RATING) FROM CUSTOMERS C2 
      WHERE C1.CITY=C2.CITY);
      
--39. Write a query that totals the orders for each day and places the results in descending order.

      SELECT TRUNC(ODATE),SUM(AMT) FROM ORDERS
      GROUP BY TRUNC(ODATE)
      ORDER BY SUM(AMT) DESC;
      
--40. Write a select command that produces the rating followed by the name of each customer in San Jose.

      SELECT CNAME, RATING FROM CUSTOMERS
      WHERE UPPER(CITY)='SAN JOSE';
      
--41. Find all orders with amounts smaller than any amount for a customer in San Jose.

      SELECT * FROM ORDERS
      WHERE AMT<(      
      SELECT MIN(AMT) FROM ORDERS
      WHERE CNUM IN(
      SELECT CNUM FROM CUSTOMERS
      WHERE UPPER(CITY)='SAN JOSE'));
     
--42. Find all orders with above average amounts for their customers.

      SELECT * FROM ORDERS
      WHERE AMT>(SELECT AVG(AMT) FROM ORDERS);
      
--43. Write a query that selects the highest rating in each city.

      SELECT CITY, MAX(RATING) FROM CUSTOMERS
      GROUP BY CITY;
      
--44. Write a query that calculates the amount of the salesperson’s commission on order by a customer with a rating above 100.00.

      SELECT S.SNUM, S.SNAME, SUM(S.COMM*O.AMT) AS COMMISSION FROM SALESPEOPLE S
      INNER JOIN ORDERS O
      ON S.SNUM=O.SNUM 
      WHERE S.SNUM IN( 
      SELECT SNUM FROM CUSTOMERS
      WHERE RATING>100);
   
--45. Count the customers with rating above San Jose’s average.
      
      SELECT COUNT(*) FROM CUSTOMERS
      WHERE RATING >
      (SELECT AVG(RATING) FROM CUSTOMERS
      WHERE UPPER(CITY) ='SAN JOSE');
      
--46. Write a query that produces all pairs of salespeople with themselves as well as duplicate rows with the order reversed.

      SELECT S1.SNAME, S2.SNAME FROM SALESPEOPLE S1
      JOIN SALESPEOPLE S2
      ON S1.SNUM=S2.SNUM;
        
--47. Find all salespeople that are located in either Barcelona or London.

      SELECT * FROM SALESPEOPLE
      WHERE UPPER(CITY) IN ('BARCELONA','LONDON');
      
--48. Find all salespeople with only one customer.
    
      SELECT * FROM SALESPEOPLE
      WHERE SNUM IN (
      SELECT SNUM
      FROM ORDERS
      GROUP BY SNUM
      HAVING COUNT(DISTINCT CNUM) = 1
      );
   
--49. Write a query that joins the Customer table to itself to find all pairs of customers served by a single salesperson.

     

      
--50. Write a query that will give you all orders for more than $1000.00.

      SELECT * FROM ORDERS
      WHERE AMT>1000;
      
--51. Write a query that lists each order number followed by the name of the customer who made that order.

      SELECT O.ONUM, C.CNAME FROM ORDERS O
      INNER JOIN CUSTOMERS C
      ON O.CNUM=C.CNUM 
      
/*52. Write 2 queries that select all salespeople (by name and number) who have customers in their cities who they do not service, 
      one using a join and one a correlated subquery. Which solution is more elegant?*/
      
      SELECT DISTINCT S.SNAME, S.SNUM FROM SALESPEOPLE S
      INNER JOIN CUSTOMERS C
      ON S.CITY=C.CITY
      WHERE S.SNUM<>C.SNUM;
      
    -----------***--------------
    
      SELECT SNAME, SNUM FROM SALESPEOPLE S
      WHERE EXISTS(
      SELECT 1 FROM CUSTOMERS C
      WHERE S.CITY=C.CITY
      AND S.SNUM<>C.SNUM);    
      
--53. Write a query that selects all customers whose ratings are equal than ANY (in the SQL sense) of Serres.

      SELECT * FROM CUSTOMERS
      WHERE RATING = ANY(
      SELECT RATING FROM CUSTOMERS
      WHERE SNUM =(
      SELECT SNUM FROM SALESPEOPLE
      WHERE UPPER(SNAME)='SERRES'));
      
--54. Write 2 queries that will produce all orders taken on October3 or October 4.

      SELECT * FROM ORDERS
      WHERE TRUNC(ODATE)=TO_DATE('03-Oct-96','DD-Mon-YY')
      OR  TRUNC(ODATE)=TO_DATE('04-Oct-96','DD-Mon-YY');
      
      SELECT * FROM ORDERS
      WHERE TRUNC(ODATE) IN (
      TO_DATE('03-Oct-96','DD-Mon-YY'),
      TO_DATE('04-Oct-96','DD-Mon-YY')
      );

--**55. Write a query that produces all pairs of orders by a given customer. Name that customer and eliminate duplicates.

      SELECT DISTINCT C.CNAME, O.ONUM FROM CUSTOMERS C
      INNER JOIN ORDERS O
      ON C.CNUM=O.CNUM;
      
--56. Find only those customers whose ratings are higher than every customer in Rome.

      SELECT * FROM CUSTOMERS
      WHERE RATING >(
      SELECT MAX(RATING) FROM CUSTOMERS
      WHERE UPPER(CITY)='ROME' );
      
--57. Write a query on the customers table whose output will exclude all customers with a rating < = 100.00, unless they are located in Rome.

      SELECT * FROM CUSTOMERS
      WHERE RATING >100
      OR UPPER(CITY)='ROME';
      
--58. Find all rows from the Customer table for which the salesperson number is 1001.

      SELECT * FROM CUSTOMERS
      WHERE SNUM =1001;
      
--59. Find the total amount in Orders for each salesperson for which this total is greater than the amount of the largest order in the table.

      SELECT SNUM,SUM(AMT)TOTAL_AMT FROM ORDERS
      GROUP BY SNUM
      HAVING SUM(AMT) >(
      SELECT MAX(AMT) FROM ORDERS);
      
--60. Write a query that selects all orders that have Zeroes or NULL in the Amount field.

      SELECT * FROM ORDERS
      WHERE AMT =0
      OR AMT IS NULL
      
--61. Produce all combinations of salespeople and customer names such that the former precedes the latter alphabetically, and the latter has a rating of less than 200.

      SELECT S.SNAME, C.CNAME FROM SALESPEOPLE S
      CROSS JOIN CUSTOMERS C
      WHERE S.SNAME < C.CNAME
      AND C.RATING<200
  
--62. List all salespeople’s names and the commission they have earned.

      SELECT S.SNAME, SUM(S.COMM*O.AMT) AS COMMISSION FROM SALESPEOPLE S
      INNER JOIN ORDERS O
      ON S.SNUM=O.SNUM
      GROUP BY S.SNAME
    
/*63. Write a query that produces the names and cities of all customers with the same rating as Hoffman. 
      Write the query using Hoffman’s CNUM rather than his rating, so that it would still be usable if his rating changed.*/
      
      SELECT CNAME, CITY FROM CUSTOMERS
      WHERE RATING=(
      SELECT RATING FROM CUSTOMERS
      WHERE CNUM=(
      SELECT CNUM FROM CUSTOMERS
      WHERE UPPER(CNAME)='HOFFMAN'));

--64. Find all salespeople for whom there are customers that follow them in alphabetical order.
  
     SELECT DISTINCT S.SNAME FROM SALESPEOPLE S
     JOIN CUSTOMERS C
     ON S.SNUM = C.SNUM
     WHERE C.CNAME > S.SNAME;
      
--65. Write a query that produces the names and ratings of all customers of all who have above average orders.

      SELECT DISTINCT CNAME, RATING FROM CUSTOMERS
      WHERE CNUM IN(
      SELECT CNUM FROM ORDERS
      WHERE AMT> (SELECT AVG(AMT) FROM ORDERS))
      
--66. Find the sum of all purchases from the Orders table.

      SELECT SUM(AMT) FROM ORDERS;
      
--67. Write a select command that produces the order number, amount, and date for all rows in the Order table.

      SELECT ONUM,AMT,ODATE FROM ORDERS;
      
--68. Count the number of not null rating fields in the Customer table including duplicates.

      SELECT COUNT(*) FROM CUSTOMERS
      WHERE RATING IS NOT NULL;
      
--69. Write a query that gives the names of both the salesperson and the customer for each order after the order number.

      SELECT O.ONUM, S.SNAME, C.CNAME FROM ORDERS O
      INNER JOIN SALESPEOPLE S
      ON O.SNUM=S.SNUM
      INNER JOIN CUSTOMERS C
      ON O.CNUM= C.CNUM
      
--70. List the commissions of all salespeople servicing customers in London.

      SELECT SNAME,COMM COMMISSION FROM SALESPEOPLE
      WHERE SNUM IN (SELECT SNUM FROM CUSTOMERS
      WHERE UPPER(CITY)='LONDON');
      
--71. Write a query using ANY or ALL that will find all salespeople who have no customers located in their city.
      
      SELECT * FROM SALESPEOPLE S
      WHERE S.CITY <> ALL (
      SELECT C.CITY
      FROM CUSTOMERS C
      WHERE C.SNUM = S.SNUM );

--72. Write a query using the EXISTS operator that selects all salespeople with customers located in their cities who are not assigned to them.

      SELECT * FROM SALESPEOPLE S
      WHERE EXISTS( SELECT 1 FROM CUSTOMERS C 
      WHERE C.CITY=S.CITY
      AND C.SNUM<>S.SNUM);
      
--73. Write a query that selects all customers serviced by Peel or Motika.

      SELECT * FROM CUSTOMERS
      WHERE SNUM IN(
      SELECT SNUM FROM SALESPEOPLE
      WHERE UPPER(SNAME)='PEEL'
      OR UPPER(SNAME)='MOTIKA');
      
--74. Count the number of salespeople registering orders for each day. (If a salesperson has more than one order on a given day, he or she should be counted only once.).

      SELECT TRUNC(ODATE)AS ODATE, COUNT(DISTINCT SNUM) SALESPERSONS FROM ORDERS
      GROUP BY TRUNC(ODATE);
      
--75. Find all orders attributed to salespeople in London.

      SELECT * FROM ORDERS
      WHERE SNUM IN (
      SELECT SNUM FROM SALESPEOPLE
      WHERE UPPER(CITY)='LONDON');
      
--76. Find all orders by customers not located in the same cities as their salespeople.

      SELECT * FROM ORDERS O
      WHERE EXISTS (
      SELECT 1 FROM CUSTOMERS C, SALESPEOPLE S
      WHERE C.SNUM=S.SNUM
      AND C.CNUM= O.CNUM
      AND C.CITY<> S.CITY);
      
--77. Find all salespeople who have customers with more than one current order.

      SELECT * FROM SALESPEOPLE
      WHERE SNUM IN(
      SELECT SNUM FROM CUSTOMERS
      WHERE CNUM IN(
      SELECT CNUM FROM ORDERS
      GROUP BY CNUM
      HAVING COUNT(*)>1));
      
 /*78. Write a query that extracts from the Customer table every customer assigned to a salesperson who currently has at least one other customer
       (besides the customer being selected) with orders in the Orders table.*/
      
       
      SELECT * FROM CUSTOMERS C
      WHERE EXISTS (
      SELECT 1
      FROM CUSTOMERS C2
      WHERE C2.SNUM = C.SNUM
      AND C2.CNUM <> C.CNUM
      AND EXISTS (
          SELECT 1
          FROM ORDERS O
          WHERE O.CNUM = C2.CNUM ) );

       
--79. Write a query that selects all customers whose name begins with ‘C’.

      SELECT * FROM CUSTOMERS
      WHERE CNAME LIKE 'C%'
      
--80. Write a query on the Customers table that will find the highest rating in each city. Put the output in this form:  for the city (city) the highest rating is : (rating).

      SELECT 'For the city '||CITY|| ' the highest rating is : '|| MAX(RATING) FROM CUSTOMERS
      GROUP BY CITY;
      
--81. Write a query that will produce the Snum values of all salespeople with orders currently in the Orders table without any repeats.

      SELECT DISTINCT SNUM FROM SALESPEOPLE 
      WHERE SNUM IN(SELECT SNUM FROM ORDERS);
      
--82. Write a query that lists customers in descending order of rating. Output the rating field first, followed by the customers’ names and numbers.

      SELECT RATING, CNAME, CNUM FROM CUSTOMERS
      ORDER BY RATING DESC;
      
--83. Find the average commission for salespeople in London.

      SELECT AVG(COMM) FROM SALESPEOPLE
      WHERE UPPER(CITY)='LONDON';
      
--84. Find all orders credited to the same salesperson that services Hoffman.

      SELECT * FROM ORDERS 
      WHERE SNUM=(
      SELECT SNUM FROM CUSTOMERS
      WHERE UPPER(CNAME)='HOFFMAN');
      
--85. Find all salespeople whose commission is in between 0.10 and 0.12 both inclusive.

      SELECT * FROM SALESPEOPLE
      WHERE COMM BETWEEN 0.1 AND 0.12;
      
--86. Write a query that will give you the names and cities of all salespeople in London with commission above 0.10

      SELECT SNAME,CITY FROM SALESPEOPLE
      WHERE COMM>0.1
      AND UPPER(CITY)='LONDON';
      
/*87. What will be the output from the following query? 
  SELECT * FROM ORDERS WHERE (AMT < 1000 OR NOT (ODATE = 10/03/1996 AND CNUM > 2003)); */
  
         
  
--88. Write a query that selects each customer’s smallest order.

      SELECT * FROM ORDERS O1
      WHERE AMT =( 
      SELECT MIN(AMT) FROM ORDERS O2
      WHERE O2.CNUM=O1.CNUM);
      
--89. Write a query that selects the first customer in alphabetical order whose name begins with ‘G’.
     
      SELECT * FROM(
      SELECT * FROM CUSTOMERS
      WHERE CNAME LIKE 'G%'
      ORDER BY CNAME )
      WHERE ROWNUM=1;
      
--90. Write a query that counts the number of different not NULL city values in the Customers table.

      SELECT COUNT(DISTINCT CITY) CITY_COUNT FROM CUSTOMERS;
      
--91. Find the average amount from the Orders table.

      SELECT AVG(AMT) AVG_AMT FROM ORDERS;
      
--92. What would be the output from the following query?
--SELECT*FROM ORDERS WHERE NOT  (Odate =10/03/1996 OR Snum>1006) AND amt. >=1500);

--93. Find all customers who are not located in San Jose & whose rating is above 200.

      SELECT * FROM CUSTOMERS
      WHERE UPPER(CITY)<>'SAN JOSE'
      AND RATING>200;
      
--94. Give a simpler way to write this query:
--SELECT Snum, Sname, city, Comm FROM salespeople WHERE (Comm>0.12 and Comm <0.14);

      SELECT * FROM SALESPEOPLE
      WHERE COMM BETWEEN 0.12 AND 0.14;

--95. Evaluate the following query:
--SELECT * FROM orders WHERE NOT ((Odate = 10/03/1996 AND Snum>1002) OR amt>2000);

--96. Which salespeople attend to customers not in the city they have been assigned to?

      SELECT S.* FROM SALESPEOPLE S
      INNER JOIN CUSTOMERS C
      ON S.SNUM=C.SNUM
      WHERE S.CITY<>C.CITY;  
      
--97. Which salespeople get commission greater than 0.11 and serving customers rated less than 250?

      SELECT * FROM SALESPEOPLE
      WHERE COMM>0.11
      AND SNUM IN(
      SELECT SNUM FROM CUSTOMERS
      WHERE RATING>250);
      
--98. Which salespeople have been assigned to the same city but get different commission percentages?
      
      SELECT DISTINCT S1.SNAME FROM SALESPEOPLE S1
      WHERE EXISTS (
      SELECT 1 FROM SALESPEOPLE S2
      WHERE S2.SNUM <> S1.SNUM
      AND S2.CITY = S1.CITY
      AND S2.COMM <> S1.COMM );

--99. Which salesperson has earned the most by way of commission?
      
      SELECT * FROM SALESPEOPLE
      WHERE SNUM = (
      SELECT SNUM FROM (
      SELECT S.SNUM
      FROM SALESPEOPLE S
      JOIN ORDERS O
      ON S.SNUM = O.SNUM
      GROUP BY S.SNUM
      ORDER BY SUM(O.AMT * S.COMM) DESC
      )
      WHERE ROWNUM = 1 );

--100. Does the customer who has placed the maximum number of orders have the maximum rating? 
      
       WITH HIGHEST_ORDER AS(
       SELECT CNUM CNUM1 FROM(
       SELECT CNUM, COUNT(*), RANK() OVER(ORDER BY COUNT(*) DESC) RN FROM ORDERS
       GROUP BY CNUM)
       WHERE RN=1),
       HIGHEST_RATING AS(
       SELECT CNUM CNUM2 FROM(
       SELECT CNUM, RATING ,RANK() OVER (ORDER BY RATING DESC) RN FROM CUSTOMERS )
       WHERE RN=1)
       SELECT CASE
       WHEN CNUM1=CNUM2 THEN 'Yes, The customer who has placed the maximum number of orders have the maximum rating '
         ELSE 'NO, the customer who has placed the maximum number of orders dont have the maximum rating'
       END AS RESULT_
       FROM HIGHEST_ORDER
       JOIN HIGHEST_RATING
     ---------------------------------------------------------------------------- BOTH QUERIES USING WITH CTE  
       WITH HIGHEST_ORDER AS (
       SELECT CNUM FROM (
        SELECT CNUM, RANK() OVER (ORDER BY COUNT(*) DESC) RN FROM ORDERS
        GROUP BY CNUM )
        WHERE RN = 1
       ),
       HIGHEST_RATING AS (
       SELECT CNUM FROM (
        SELECT CNUM, RANK() OVER (ORDER BY RATING DESC) RN
        FROM CUSTOMERS
       )
       WHERE RN = 1
       )
       SELECT CASE
         WHEN EXISTS (
              SELECT 1
              FROM HIGHEST_ORDER HO
              JOIN HIGHEST_RATING HR
              ON HO.CNUM = HR.CNUM
         )
         THEN 'YES, Customer with max orders also has max rating'
         ELSE 'NO, Customer with max orders does NOT have max rating'
       END AS RESULT
      FROM DUAL;


       
--101. Has the customer who has spent the largest amount of money been given the highest rating?
       
        WITH HIGHEST_AMOUNT AS (
       SELECT CNUM FROM (
        SELECT CNUM, SUM(AMT), RANK() OVER (ORDER BY SUM(AMT) DESC) RN FROM ORDERS
        GROUP BY CNUM )
        WHERE RN = 1
       ),
       HIGHEST_RATING AS (
       SELECT CNUM FROM (
        SELECT CNUM, RATING,  RANK() OVER (ORDER BY RATING DESC) RN
        FROM CUSTOMERS
       )
       WHERE RN = 1
       )
       SELECT CASE
         WHEN EXISTS (
              SELECT 1
              FROM HIGHEST_AMOUNT HA
              JOIN HIGHEST_RATING HR
              ON HA.CNUM = HR.CNUM
         )
         THEN 'YES,the customer who has spent the largest amount of money been given the highest rating '
         ELSE 'NO, the customer who has spent the largest amount of money been given the highest rating'
       END AS RESULT
      FROM DUAL;

      
--102. List all customers in descending order of customer rating.

       SELECT * FROM CUSTOMERS
       ORDER BY RATING DESC;
       
--103. On which days has Hoffman placed orders?

       SELECT ODATE FROM ORDERS
       WHERE CNUM=(
       SELECT CNUM FROM CUSTOMERS
       WHERE UPPER(CNAME)='HOFFMAN');
       
--104. Do all salespeople have different commissions?
       
       SELECT CASE
               WHEN EXISTS (
              SELECT 1
              FROM SALESPEOPLE S1
              INNER  JOIN SALESPEOPLE S2
                ON S1.SNUM <> S2.SNUM
               AND S1.COMM = S2.COMM
              )
       THEN 'NO, some salespeople share the same commission'
       ELSE 'YES, all salespeople have different commissions'
       END AS COMM_STATUS 
       FROM DUAL;

--105. Which salespeople have no orders between 10/03/1996 and 10/05/1996?
       
       SELECT * FROM SALESPEOPLE S
       WHERE NOT EXISTS (
       SELECT 1 FROM ORDERS O
       WHERE O.SNUM = S.SNUM
       AND TRUNC(O.ODATE) BETWEEN
          TO_DATE('10-03-1996','DD-MM-YYYY')
       AND TO_DATE('10-05-1996','DD-MM-YYYY'));

--106.  How many salespersons have succeeded in getting orders?

       SELECT COUNT( DISTINCT SNUM) WORKING_SALESPERSONS FROM ORDERS;
   
--107.  How many customers have placed orders?

       SELECT COUNT( DISTINCT CNUM) CUSTOMERS FROM ORDERS;
        
--108.  On which date has each salesperson booked an order of maximum value?

        SELECT SNUM, AMT , ODATE FROM ORDERS O
        WHERE AMT =(
        SELECT MAX(AMT)  FROM ORDERS
        WHERE SNUM=O.SNUM );

--109.  Who is the most successful salesperson?
     
        SELECT * FROM SALESPEOPLE
        WHERE SNUM IN (
        SELECT SNUM FROM(
        SELECT SNUM, SUM(AMT),RANK() OVER(ORDER BY SUM(AMT) DESC) RN FROM ORDERS 
        GROUP BY SNUM)
        WHERE RN=1);-----------------------------------------MAXIMUM  ORDER AMOUNT
        
--110.  Who is the worst customer with respect to the company ?
       
        SELECT * FROM CUSTOMERS
        WHERE CNUM IN(
        SELECT CNUM FROM(
        SELECT CNUM , SUM(AMT), RANK() OVER(ORDER BY SUM(AMT)) RN FROM ORDERS
        GROUP BY CNUM)
        WHERE RN =1);-------------------------------------- MINIMUM ORDER AMOUNT
        
  ----------------------------***-------------------------------------      
        
        SELECT * FROM CUSTOMERS
        WHERE CNUM IN (
        SELECT CNUM FROM(
        SELECT CNUM,RANK() OVER(ORDER BY RATING)RN FROM CUSTOMERS)
        WHERE RN=1);---------------------------------------- AS PER MINIMUM RATING 
        
        
        
--111.  Are all customers not having placed orders greater than 200 totally been serviced by salesperson Peel or Serres?
        
        SELECT CASE
         WHEN NOT EXISTS (
              SELECT 1
              FROM CUSTOMERS C
              INNER JOIN ORDERS O
                ON O.CNUM = C.CNUM
              INNER JOIN SALESPEOPLE S
                ON S.SNUM = C.SNUM
              WHERE O.AMT <= 200
                AND UPPER(S.SNAME) NOT IN ('PEEL', 'SERRES')
         )
         THEN 'YES, all such customers are serviced by Peel or Serres'
         ELSE 'NO, some customers are serviced by others'
        END AS STATUS
        FROM DUAL;

--112.  Which customers have the same rating?
       
        SELECT C1.CNAME, C1.RATING FROM CUSTOMERS C1
        WHERE EXISTS ( 
        SELECT 1 FROM CUSTOMERS C  
        WHERE C.CNUM <> C1.CNUM
        AND C.RATING= C1.RATING);
        
--113.  Find all orders greater than the average for October 4th.

        SELECT * FROM ORDERS
        WHERE AMT> (
        SELECT AVG(AMT) FROM ORDERS
        GROUP BY TRUNC(ODATE)
        HAVING TRUNC(ODATE)= TO_DATE('04-Oct-96','DD-Mon-YY'));
       
--114.  Which customers have above average orders?

        SELECT * FROM CUSTOMERS
        WHERE CNUM IN(
        SELECT DISTINCT CNUM FROM ORDERS
        WHERE AMT>(
        SELECT AVG(AMT) FROM ORDERS));
        
--115.  List all customers with ratings above San Jose’s average.

        SELECT * FROM CUSTOMERS
        WHERE RATING>(
        SELECT AVG(RATING) FROM CUSTOMERS
        WHERE UPPER(CITY)='SAN JOSE');
        
--116.  Select the total amount in orders for each salesperson for which the total is greater than the amount of the largest order in the table.

        SELECT SNUM, SUM(AMT) FROM ORDERS
        GROUP BY SNUM
        HAVING SUM(AMT)> (SELECT MAX(AMT) FROM ORDERS);
        
--117.  Give names and numbers of all salesperson that have more than one customer.

        SELECT SNAME, SNUM FROM SALESPEOPLE
        WHERE SNUM IN(
        SELECT SNUM FROM CUSTOMERS
        GROUP BY SNUM 
        HAVING COUNT(*)>1 );
        
--118.  Select all salesperson by name and numbers who have customers in their city whom they don’s the service.

       SELECT S.SNAME, S.SNUM FROM SALESPEOPLE S
       WHERE  EXISTS(
       SELECT 1 FROM CUSTOMERS C
       WHERE S.SNUM<> C.SNUM
       AND S.CITY=C.CITY);
        
--119.  Which customers’ rating should be lowered?

        SELECT * FROM CUSTOMERS
        WHERE CNUM IN(
        SELECT CNUM FROM(
        SELECT CNUM , SUM(AMT), RANK() OVER(ORDER BY SUM(AMT)) RN FROM ORDERS
        GROUP BY CNUM)
        WHERE RN =1);----------------------------MINMUM AMOUNT ORDER 

--120.  Is there a case for assigning a salesperson to Berlin ?

        SELECT * FROM SALESPEOPLE
        WHERE SNUM IN(
        SELECT SNUM FROM CUSTOMERS
        WHERE UPPER(CITY)='BERLIN');
       
--121.  Is there any evidence linking the performance of a salesperson to commission that he or she is being paid?
/*122.  Does the total amount in orders by customer in Rome and London exceeds the commission paid to salesperson in London and New York 
        by more than 5 times?*/
        
           
        SELECT CASE 
        WHEN
          ( SELECT SUM(AMT) FROM ORDERS
           WHERE CNUM IN(SELECT CNUM FROM CUSTOMERS
           WHERE UPPER(CITY) IN ('ROME','LONDON')))
           >
          ((SELECT SUM(O.AMT*S.COMM) FROM ORDERS O
           INNER JOIN SALESPEOPLE S
           ON O.SNUM=S.SNUM 
           WHERE UPPER(S.CITY) IN ('LONDON','NEW YORK'))*5)
           THEN 'YES,IT EXCEEDS'
             ELSE 'NO, IT DOES NOT EXCEED '
               END AS RESULT_
               FROM DUAL;
        
--123.  Which is the date, order number, amt and city for each salesperson (byname) for the maximum order he has obtained?
 
        SELECT S.SNAME, O.ODATE, O.ONUM, O.AMT, S.CITY FROM SALESPEOPLE S
        INNER JOIN ORDERS O
        ON S.SNUM = O.SNUM
        WHERE O.AMT = (
        SELECT MAX(O1.AMT) FROM ORDERS O1
        WHERE O1.SNUM = O.SNUM );
       
--124.  Which salesperson(s) should be fired?
        
        SELECT NULL WHO,'NOT' SHOULD,'WORKING' BE,NULL FIRED FROM DUAL
        
        UNION ALL
        
        SELECT * FROM SALESPEOPLE S
        WHERE NOT EXISTS (
        SELECT 1 FROM ORDERS O
        WHERE O.SNUM = S.SNUM)
        
        UNION ALL
        
        SELECT NULL,'MINIMUM','ORDER AMOUNT',NULL FROM DUAL
        
        UNION ALL
        
        SELECT * FROM SALESPEOPLE
        WHERE SNUM IN ( SELECT SNUM FROM(
        SELECT SNUM, SUM(AMT),RANK() OVER(ORDER BY SUM(AMT)) RN FROM ORDERS 
        GROUP BY SNUM)
        WHERE RN=1); ----------------------------------------------------------------JUST FOR FUN....
        
--125.  What is the total income for the company? 

         SELECT (
        (SELECT SUM(O1.AMT) FROM ORDERS O1) -
        (SELECT SUM(O.AMT*S.COMM) FROM ORDERS O
         INNER JOIN SALESPEOPLE S
         ON O.SNUM=S.SNUM )
                 ) TOTAL_INCOME FROM DUAL
         
         
         
   
