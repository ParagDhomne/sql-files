---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE CUSTOMER
(
       CID NUMBER CONSTRAINT CID_PK PRIMARY KEY,
       CNAME VARCHAR2(50),
       CADD VARCHAR2(20),
       C_CONTACT NUMBER,
       C_CREDIT_DAYS NUMBER,
       CJ_DATE DATE,
       SEX VARCHAR2(10)
);

INSERT INTO CUSTOMER (CID, CNAME, CADD, C_CONTACT, C_CREDIT_DAYS, CJ_DATE, SEX) VALUES(1001,'Cyona blake','NEW YORK',1235684,20, TO_DATE('20-Jan-11','DD-MON-YY'),'FEMALE');
INSERT INTO CUSTOMER (CID, CNAME, CADD, C_CONTACT, C_CREDIT_DAYS, CJ_DATE, SEX) VALUES(1002,'JOHN SMITH','NEW JERSI',1341684,20, TO_DATE('21-Feb-11','DD-MON-YY'),'MALE');
INSERT INTO CUSTOMER (CID, CNAME, CADD, C_CONTACT, C_CREDIT_DAYS, CJ_DATE, SEX) VALUES(1003,'JORDAN WOOD','PRAG',1805184,20, TO_DATE('22-Mar-11','DD-MON-YY'),'MALE');
INSERT INTO CUSTOMER (CID, CNAME, CADD, C_CONTACT, C_CREDIT_DAYS, CJ_DATE, SEX) VALUES(1004,'CHRISTNA','MANHATTON',1125684,31,TO_DATE('23-Apr-13','DD-MON-YY'),'FEMALE');
INSERT INTO CUSTOMER (CID, CNAME, CADD, C_CONTACT, C_CREDIT_DAYS, CJ_DATE, SEX) VALUES(1005,'TOM HILL','LONDON',1239284,10, TO_DATE('25-Jun-15','DD-MON-YY'),'MALE');
INSERT INTO CUSTOMER (CID, CNAME, CADD, C_CONTACT, C_CREDIT_DAYS, CJ_DATE, SEX) VALUES(1006,'KAMILA JOSEF','PARISE',124568,9,TO_DATE('28-Jul-11','DD-MON-YY'),'FEMALE');
INSERT INTO CUSTOMER (CID, CNAME, CADD, C_CONTACT, C_CREDIT_DAYS, CJ_DATE, SEX) VALUES(1007,'ANDRU SYMON','TAXES',125654,15, TO_DATE('01-Apr-16','DD-MON-YY'),'MALE');
INSERT INTO CUSTOMER (CID, CNAME, CADD, C_CONTACT, C_CREDIT_DAYS, CJ_DATE, SEX) VALUES(1008,'SANJU SAMSUNG','NEW YORK',12346341,4, TO_DATE('20-Jan-16','DD-MON-YY'),'MALE');

select * from customer;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE VENDORS
(
       VID NUMBER CONSTRAINT VID_PK PRIMARY KEY,
       VNAME VARCHAR2(50),
       VADD VARCHAR2(20),
       VCONTACT NUMBER,
       VCREDITDAYS NUMBER,
       VJ_DATE DATE
);

INSERT INTO VENDORS (VID, VNAME, VADD, VCONTACT, VCREDITDAYS, VJ_DATE) VALUES(2001,'KIRAN PATIL','PUNE',20535535,20,TO_DATE('20-Jan-10','DD-MON-YY'));
INSERT INTO VENDORS (VID, VNAME, VADD, VCONTACT, VCREDITDAYS, VJ_DATE) VALUES(2002,'PRAKASH JAIN','MUMBAI',2063564,10,TO_DATE('05-Nov-11','DD-MON-YY'));
INSERT INTO VENDORS (VID, VNAME, VADD, VCONTACT, VCREDITDAYS, VJ_DATE) VALUES(2003,'SWAPNIL THETE','NASHIK',25355352,15,TO_DATE('18-Mar-10','DD-MON-YY'));
INSERT INTO VENDORS (VID, VNAME, VADD, VCONTACT, VCREDITDAYS, VJ_DATE) VALUES(2004,'AMOL SHENDE','SATARA',23674776,18,TO_DATE('07-Apr-15','DD-MON-YY'));
INSERT INTO VENDORS (VID, VNAME, VADD, VCONTACT, VCREDITDAYS, VJ_DATE) VALUES(2005,'KARAN SINTRE','BULDHANA',256756,30,TO_DATE('22-Apr-09','DD-MON-YY'));
INSERT INTO VENDORS (VID, VNAME, VADD, VCONTACT, VCREDITDAYS, VJ_DATE) VALUES(2006,'RAM KULKARNI','OSMANABAD',20367454,21,TO_DATE('09-Jul-10','DD-MON-YY'));

SELECT * FROM VENDORS;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE EMPLOYEE_G
(
       EID NUMBER CONSTRAINT EID_PK PRIMARY KEY,
       ENAME VARCHAR2(50),
       EJOB VARCHAR2(20),
       EADD VARCHAR2(20),
       ECONTACT NUMBER,
       ESAL NUMBER,
       EDOJ DATE,
       EDOL DATE
);

INSERT INTO EMPLOYEE_G (EID, ENAME, EJOB, EADD, ECONTACT, ESAL, EDOJ, EDOL) VALUES(3001,'STEVEN KING','PAINTER','NEW YORK', 10367454,1200,'09-Jul-10',NULL);
INSERT INTO EMPLOYEE_G (EID, ENAME, EJOB, EADD, ECONTACT, ESAL, EDOJ, EDOL) VALUES(3002,'DAVID AUSTIN','FITTER','MANHATON', 10367434,1100,'19-Aug-10',NULL);
INSERT INTO EMPLOYEE_G (EID, ENAME, EJOB, EADD, ECONTACT, ESAL, EDOJ, EDOL) VALUES(3003,'BRUCE ERNST','MECHANIC','NEW JERCY', 10367264,2200,'08-Sep-10',NULL);
INSERT INTO EMPLOYEE_G (EID, ENAME, EJOB, EADD, ECONTACT, ESAL, EDOJ, EDOL) VALUES(3004,'LUIS POPP','MECHANIC','NEW JERCY', 10367264,1700,'19-Oct-09','06-Sep-10');
INSERT INTO EMPLOYEE_G (EID, ENAME, EJOB, EADD, ECONTACT, ESAL, EDOJ, EDOL) VALUES(3005,'SHERI GOMES','FITTER','PARIS', 10327264,1000,'19-Oct-09','01-Aug-10');
INSERT INTO EMPLOYEE_G (EID, ENAME, EJOB, EADD, ECONTACT, ESAL, EDOJ, EDOL) VALUES(3000,'JAMES PHILLIP','FITTER','PARIS', 10322264,NULL,'01-Jan-08',NULL);

SELECT * FROM EMPLOYEE_G

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE SPAREPART
(
       SPID NUMBER CONSTRAINT SPID_PK PRIMARY KEY,
       SPNAME VARCHAR2(50),
       SPRATE NUMBER,
       SPUNIT VARCHAR2(10)
);

INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4001,'TWO WHEELER TUBE',250,'NOS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4002,'TWO WHEELER ENGINE OIL',400,'LTRS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4003,'FOUR WHEELER ENGINE OIL',5000,'LTRS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4004,'TWO WHEELER CARBORATORL',680,'NOS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4005,'TWO WHEELER CLUTCH WIRE',129,'MTRS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4006,'TWO WHEELER TAIL LIGHT',100,'NOS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4007,'TWO WHEELER INDICATORS',150,'NOS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4008,'FOUR WHEELER GASKIT',1340,'NOS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4009,'WHITE COLOUR',340,'LTRS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4010,'BLACK COLOUR',240,'LTRS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4011,'TWO WHEELER SIDE MIRROR',250,'NOS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4012,'FOUR WHEELER SIDE MIRROR',450,'NOS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4013,'TWO WHEELER SHOCKUP',1320,'PAIR');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4014,'FOUR WHEELER BUMPER',6000,'NOS');
INSERT INTO SPAREPART (SPID,SPNAME,SPRATE,SPUNIT) VALUES(4015,'FOUR WHEELER FRONT GLASS',7000,'PCS');

SELECT * FROM SPAREPART;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PURCHASE
(
       PID NUMBER CONSTRAINT PID_PK PRIMARY KEY,
       VID NUMBER,
       SPID NUMBER ,
       PQTY NUMBER,
       SPRATE NUMBER,
       SPGST NUMBER,
       PDATE DATE,
       TRANCOST NUMBER,
       TOTAL NUMBER,
       RCV_EID NUMBER,
       FOREIGN KEY(VID) REFERENCES VENDORS(VID),
       FOREIGN KEY(SPID) REFERENCES SPAREPART(SPID),
       FOREIGN KEY(RCV_EID) REFERENCES EMPLOYEE_G(EID)
);

INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5001,2001,4001,10,250,350,'01-Jan-11',1300,4150,3001);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5002,2002,4002,2,400,288,'02-Mar-11',100,1988,3001);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5003,2003,4004,8,680,761.6,'12-Jun-11',50,6251.6,3003);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5004,2004,4005,10,129,154.8,'22-Aug-11',125,1569.8,3004);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5005,2005,4006,20,100,300,'07-Sep-11',20,2320,3003);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5006,2006,4007,30,150,630,'12-Oct-11',60,5190,3000);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5007,2001,4003,20,5000,14000,'07-Sep-11',1000,115000,3000);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5008,2006,4005,1,129,15.48,'12-Oct-11',50,194.48,3005);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5009,2006,4005,1,129,15.48,'15-Oct-11',50,194.48,3005);
INSERT INTO PURCHASE (PID,VID,SPID,PQTY,SPRATE,SPGST,PDATE,TRANCOST,TOTAL,RCV_EID) VALUES(5010,2006,4009,5,340,238,'20-Oct-11',0,2938,3005);

SELECT * FROM PURCHASE;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE SER_DET
(
       SID NUMBER CONSTRAINT SID_PK PRIMARY KEY,
       CID NUMBER,
       EID NUMBER,
       SPID NUMBER,
       TYP_VEH VARCHAR2(30),
       VEH_NO VARCHAR2(30),
       TYP_SER VARCHAR2(30),
       SER_DATE DATE,
       QTY NUMBER,
       SP_RATE NUMBER,
       SP_AMT NUMBER,
       SP_G NUMBER,
       SER_AMT NUMBER,
       COMM NUMBER,
       TOTAL NUMBER,
       FOREIGN KEY (CID) REFERENCES CUSTOMER(CID),
       FOREIGN KEY (EID) REFERENCES EMPLOYEE_G(EID),
       FOREIGN KEY (SPID) REFERENCES SPAREPART(SPID)

);

INSERT INTO SER_DET (SID,CID,EID,SPID,TYP_VEH,VEH_NO,TYP_SER,SER_DATE,QTY,SP_RATE,SP_AMT,SP_G,SER_AMT,COMM,TOTAL)
             VALUES(6001,1001,3001,4001,'TWO WHEELER','MH15CA3228','TUBE DAMAGED','02-Jan-11',1,250,250,35,50,0,335);
INSERT INTO SER_DET (SID,CID,EID,SPID,TYP_VEH,VEH_NO,TYP_SER,SER_DATE,QTY,SP_RATE,SP_AMT,SP_G,SER_AMT,COMM,TOTAL)
             VALUES(6002,1002,3002,4002,'TWO WHEELER','MH-16U5713','FULL SERVICING','04-Mar-11',1,400,400,52,300,50,752);
INSERT INTO SER_DET (SID,CID,EID,SPID,TYP_VEH,VEH_NO,TYP_SER,SER_DATE,QTY,SP_RATE,SP_AMT,SP_G,SER_AMT,COMM,TOTAL)
             VALUES(6003,1003,3004,4005,'TWO WHEELER','MH12PQ1313','CLUCH WIRE','22-Aug-11',1,129,129,0,10,0,139);
INSERT INTO SER_DET (SID,CID,EID,SPID,TYP_VEH,VEH_NO,TYP_SER,SER_DATE,QTY,SP_RATE,SP_AMT,SP_G,SER_AMT,COMM,TOTAL)
             VALUES(6004,1002,3002,4002,'TWO WHEELER','MH-16U5713','FULL SERVICING','05-May-11',1,400,400,52,300,50,752);
INSERT INTO SER_DET (SID,CID,EID,SPID,TYP_VEH,VEH_NO,TYP_SER,SER_DATE,QTY,SP_RATE,SP_AMT,SP_G,SER_AMT,COMM,TOTAL)
             VALUES(6005,1004,3001,4009,'TWO WHEELER','MH-14PA335','COLOR','21-Oct-11',2.5,340,850,119,500,150,1469);
INSERT INTO SER_DET (SID,CID,EID,SPID,TYP_VEH,VEH_NO,TYP_SER,SER_DATE,QTY,SP_RATE,SP_AMT,SP_G,SER_AMT,COMM,TOTAL)
             VALUES(6006,1006,3001,4009,'TWO WHEELER','MH-12WE334','COLOR','01-Dec-11',2.5,340,850,119,500,150,1469);
INSERT INTO SER_DET (SID,CID,EID,SPID,TYP_VEH,VEH_NO,TYP_SER,SER_DATE,QTY,SP_RATE,SP_AMT,SP_G,SER_AMT,COMM,TOTAL)
             VALUES(6007,1007,3001,4001,'FOUR WHEELER','MH17BB1345','TUBE DAMAGE','01-Jan-12',1,250,250,35,150,0,435);

SELECT * FROM SER_DET;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Garage System Questions.

--Q.1 List all the customers serviced.

      SELECT * FROM CUSTOMER C
      WHERE EXISTS(
      SELECT 1 FROM SER_DET S
      WHERE S.CID=C.CID ) 
      
--Q.2 Customers who are not serviced.

      SELECT * FROM CUSTOMER C
      WHERE NOT EXISTS(
      SELECT 1 FROM SER_DET S
      WHERE S.CID=C.CID ) 
      
--Q.3 Employees who have not received the commission.
     
      SELECT * FROM EMPLOYEE_G
      WHERE EID IN(
      SELECT DISTINCT EID FROM SER_DET
      WHERE COMM =0
      OR COMM IS NULL);
      
--Q.4 Name the employee who have maximum Commission.

      SELECT ENAME FROM EMPLOYEE_G
      WHERE EID IN (
      SELECT EID FROM SER_DET
      WHERE COMM =(
      SELECT MAX(COMM) FROM SER_DET)); 

--Q.5 Show employee name and minimum commission amount received by an employee.

      SELECT ENAME FROM EMPLOYEE_G
      WHERE EID IN (
      SELECT EID FROM SER_DET
      WHERE COMM =(
      SELECT MIN(COMM) FROM SER_DET )); 
     
--Q.6 Display the Middle record from any table.
      
      SELECT * FROM (
      SELECT S.*, ROW_NUMBER() OVER (ORDER BY SID) AS RN,
      COUNT(*) OVER () AS TOTAL_CNT
      FROM SER_DET S
      )
      WHERE RN IN (
      CEIL(TOTAL_CNT / 2),
      FLOOR(TOTAL_CNT / 2) + 1
      );
       
--Q.7 Display last 4 records of any table.

      SELECT * FROM (
      SELECT S.*, ROW_NUMBER() OVER (ORDER BY SPID DESC) AS RN
      FROM SPAREPART S
      )
      WHERE RN<=4
      
--Q.8 Count the number of records without count function from any table.
  
      SELECT SUM(1) TOTAL_RECORDS FROM SPAREPART;
      
--Q.9 Delete duplicate records from "Ser_det" table on cid.(note Please rollback after execution).

      /*DELETE FROM SER_DET
      WHERE ROWID NOT IN(
      SELECT MIN(ROWID) FROM SER_DET
      GROUP BY CID)*/
      
--Q.10 Show the name of Customer who have paid maximum amount 
     
       SELECT * FROM CUSTOMER
       WHERE CID IN(
       SELECT CID FROM SER_DET 
       WHERE TOTAL=(
       SELECT MAX(TOTAL) FROM SER_DET));

--Q.11 Display Employees who are not currently working.

       SELECT * FROM EMPLOYEE_G E
       WHERE NOT EXISTS (
       SELECT 1 FROM SER_DET S
       WHERE S.EID=E.EID
       );
       
--Q.12 How many customers serviced their two wheelers.

       SELECT COUNT(*) TWO_WHEELERS_SERVICED FROM SER_DET
       WHERE UPPER(TYP_VEH)='TWO WHEELER'
       AND UPPER(TYP_SER)='FULL SERVICING';
  
--Q.13 List the Purchased Items which are used for Customer Service with Unit of that Item.
       
       SELECT * FROM SPAREPART
       WHERE SPID IN(
       SELECT SPID FROM SER_DET);
       
--Q.14 Customers who have Colored their vehicles.

       SELECT * FROM CUSTOMER
       WHERE CID IN(
       SELECT CID FROM SER_DET
       WHERE UPPER(TYP_SER)='COLOR');
       
--Q.15 Find the annual income of each employee inclusive of Commission
       
       SELECT E.EID, E.ENAME, SUM((NVL(E.ESAL,0)*12)+NVL(S.COMM,0)) AS ANNUAL_INCOME FROM EMPLOYEE_G E
       LEFT JOIN SER_DET S
       ON E.EID=S.EID
       GROUP BY E.EID,E.ENAME;
       
--Q.16 Vendor Names who provides the engine oil.
       
       SELECT VNAME FROM VENDORS
       WHERE VID IN(
       SELECT DISTINCT VID FROM PURCHASE
       WHERE SPID IN(
       SELECT SPID FROM SPAREPART
       WHERE UPPER(SPNAME) LIKE'% ENGINE OIL'));

--Q.17 Total Cost to purchase the Color and name the color purchased.

       SELECT S.SPNAME AS COLOUR, P.TOTAL TOTAL_COST FROM SPAREPART S
       INNER JOIN PURCHASE P
       ON S.SPID=P.SPID
       WHERE S.SPNAME LIKE'% COLOUR';

--Q.18 Purchased Items which are not used in "Ser_det".
     
       SELECT * FROM SPAREPART
       WHERE SPID IN(
       SELECT SPID FROM PURCHASE
       WHERE SPID NOT IN(
       SELECT  DISTINCT SPID FROM SER_DET));
      
--Q.19 Spare Parts Not Purchased but existing in Sparepart
      
       SELECT s.* FROM SPAREPART s
       LEFT JOIN PURCHASE p
       ON s.SPID = p.SPID
       WHERE p.SPID IS NULL;
       
--Q.20 Calculate the Profit/Loss of the Firm. consider one month salary of each employee for Calculation.
       
       SELECT (
       (SELECT SUM(TOTAL) FROM SER_DET)
       -(SELECT SUM(TOTAL) FROM PURCHASE)
       -(SELECT SUM(ESAL) FROM EMPLOYEE_G) 
          ) AS PROFIT_LOSS
       FROM DUAL;
       
       
--Q.21 Specify the names of customers who have serviced their vehicles more than one time.

       SELECT CNAME FROM CUSTOMER
       WHERE CID IN(
       SELECT CID FROM SER_DET        
       GROUP BY CID 
       HAVING COUNT(*)>1);
       
--Q.22 List the Items purchased from vendors location wise.
      
       SELECT V.VADD, S.SPNAME FROM VENDORS V 
       INNER JOIN PURCHASE P
       ON V.VID=P.VID
       INNER JOIN SPAREPART S
       ON P.SPID=S.SPID;

--Q.23 Display count of two wheeler and four wheeler from ser_details

       SELECT TYP_VEH, COUNT(*)NO_OF_VEH FROM SER_DET
       GROUP BY TYP_VEH;
       
--Q.24 Display name of customers who paid highest SPGST and for which item.
       
       SELECT CNAME, SPNAME, SPGST FROM (
       SELECT C.CNAME,
           S.SPNAME,
           P.SPGST,
           RANK() OVER (ORDER BY P.SPGST DESC) AS RN
       FROM SER_DET SD
       INNER JOIN CUSTOMER C ON SD.CID = C.CID
       INNER JOIN PURCHASE P ON SD.SPID = P.SPID
       INNER JOIN SPAREPART S ON SD.SPID = S.SPID
       )
       WHERE RN = 1;
        
--Q.25 Display vendors name who have charged highest SPGST rate for which item

       SELECT * FROM(
       SELECT V.VNAME, S.SPNAME,
       RANK() OVER(ORDER BY SPGST DESC) AS RN FROM PURCHASE P
       INNER JOIN VENDORS V
       ON P.VID=V.VID
       INNER JOIN SPAREPART S
       ON P.SPID=S.SPID)
       WHERE RN=1;
       
--Q.26 list name of item and employee name who have received item .

       SELECT E.ENAME, S.SPNAME FROM PURCHASE P
       INNER JOIN EMPLOYEE_G E
       ON P.RCV_EID=E.EID
       INNER JOIN SPAREPART S
       ON P.SPID=S.SPID ;
           
/*Q.27 Display the Name and Vehicle Number of Customer who serviced his vehicle, And Name the Item used for Service, 
       And specify the purchase date of that Item with his vendor and Item Unit and Location, And employee Name who serviced the vehicle. 
       for Vehicle NUMBER "MH-14PA335".'*/
     
       SELECT C.CNAME, SD.VEH_NO, S.SPNAME, P.PDATE,V.VNAME, S.SPUNIT, V.VADD, E.ENAME FROM SER_DET SD
       INNER JOIN CUSTOMER C
       ON SD.CID=C.CID
       INNER JOIN SPAREPART S
       ON SD.SPID=S.SPID
       INNER JOIN PURCHASE P
       ON SD.SPID=P.SPID
       INNER JOIN EMPLOYEE_G E
       ON SD.EID=E.EID
       INNER JOIN VENDORS V
       ON P.VID=V.VID
       WHERE SD.VEH_NO='MH-14PA335' 
        
--Q.28 who belong this vehicle  MH-14PA335" Display the customer name 

       SELECT CNAME FROM CUSTOMER
       WHERE CID=( 
       SELECT CID FROM SER_DET
       WHERE VEH_NO='MH-14PA335');
       
--Q.29 Display the name of customer who belongs to New York and when he /she service their  vehicle on which date   

       SELECT C.CNAME, S.SER_DATE FROM CUSTOMER C
       INNER JOIN SER_DET S
       ON C.CID=S.CID 
       WHERE UPPER(TRIM(C.CADD))='NEW YORK';
        
--Q.30 from whom we have purchased items having maximum cost?

       SELECT V.* FROM VENDORS V
       INNER JOIN PURCHASE P
       ON V.VID=P.VID
       WHERE P.SPRATE=(
       SELECT MAX(SPRATE) FROM  PURCHASE )  ;   

--Q.31 Display the names of employees who are not working as Mechanic and that employee done services .

       SELECT DISTINCT E.ENAME FROM EMPLOYEE_G E
       INNER JOIN SER_DET SD
       ON E.EID=SD.EID
       WHERE TRIM(E.EJOB) <>'MECHANIC';
       
--Q.32 Display the various jobs along with total number of employees in each job. The output should contain only those jobs with more than two employees.

       SELECT DISTINCT EJOB, COUNT(*) AS TOTAL_NO_OF_EMP FROM EMPLOYEE_G
       GROUP BY EJOB 
       HAVING COUNT(*)>1;
       
--Q.33 Display the details of employees who done service and give them rank according to their no. of services .
     
       SELECT EID, ENAME, EJOB, ECONTACT, ESAL, NO_OF_SER,RANK() OVER(ORDER BY NO_OF_SER DESC) SER_RANK FROM(
       SELECT E.EID, E.ENAME, E.EJOB, E.ECONTACT, E.ESAL , COUNT(*) NO_OF_SER FROM EMPLOYEE_G E
       INNER JOIN SER_DET SD
       ON E.EID=SD.EID
       GROUP BY E.EID, E.ENAME, E.EJOB, E.ECONTACT, E.ESAL);
       
--Q.34 Display those employees who are working as Painter and fitter and who provide service and total count of service done by fitter and painter  

       SELECT E.ENAME, E.EJOB, COUNT(*) AS COUNT_OF_SER FROM EMPLOYEE_G E
       INNER JOIN SER_DET S
       ON E.EID=S.EID
       GROUP BY E.ENAME, E.EJOB
       HAVING E.EJOB='PAINTER'
       OR E.EJOB='FITTER';
       
--Q.35 Display employee salary and as per highest salary provide Grade to employee.

       SELECT ENAME, NVL(ESAL,0) ESAL, DENSE_RANK() OVER(ORDER BY NVL(ESAL,0) DESC) GRADE  FROM EMPLOYEE_G
       ORDER BY ESAL DESC;
       
--Q.36 Display the 4th record of emp table without using group by and rowid
       
       SELECT * FROM (
       SELECT E.*, ROWNUM RN FROM EMPLOYEE_G E)
       WHERE RN=4;
       
--Q.37 Provide a commission 100 to employees who are not earning any commission.
       
       UPDATE SER_DET 
       SET COMM=100
       WHERE NVL(COMM,0)=0 ;

--Q.38 write a query that totals no. of services  for each day and place the results in descending order
      
       SELECT SER_DATE, COUNT(*) AS TOTAL_NO_OF_SERVICES FROM SER_DET
       GROUP BY SER_DATE
       ORDER BY COUNT(*) DESC;
      
--Q.39 Display the service details of those customer who belong from same city 

      SELECT * FROM SER_DET
      WHERE CID IN (
      SELECT CID FROM CUSTOMER
      WHERE CADD IN (
      SELECT CADD  FROM CUSTOMER
      GROUP BY CADD
      HAVING COUNT(*) > 1 ));
       
--Q.40 write a query join customers table to itself to find all pairs of customers service by a single employee

      SELECT c1.cname AS customer1, c2.cname AS customer2,s1.eid
FROM ser_det s1 INNER JOIN ser_det s2 
ON s1.eid = s2.eid AND s1.cid < s2.cid
INNER JOIN customer c1 ON s1.cid = c1.cid
INNER JOIN customer c2 ON s2.cid = c2.cid;-------------------------------------------------------COPIED

--Q.41 List each service number follow by name of the customer who made that service
      
       SELECT S.SID, C.CNAME FROM SER_DET S
       INNER JOIN CUSTOMER C
       ON S.CID= C.CID;
       
/*Q.42 Write a query to get details of employee and provide rating on basis of  maximum services provide by employee 
       .Note (rating should be like A,B,C,D)*/
       
       SELECT EID, ENAME, EJOB, EADD,ECONTACT, ESAL, NO_OF_SER ,
       CASE
        WHEN SER_RANK = 1 THEN 'A'
        WHEN SER_RANK = 2 THEN 'B'
        WHEN SER_RANK = 3 THEN 'C'
        ELSE 'D'
        END AS RATING
       FROM(
       SELECT E.EID,E.ENAME, E.EJOB, E.EADD, E.ECONTACT, E.ESAL , COUNT(*) NO_OF_SER,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS SER_RANK
       FROM EMPLOYEE_G E
       INNER JOIN SER_DET S
       ON E.EID=S.EID
       GROUP BY  E.EID,E.ENAME, E.EJOB, E.EADD, E.ECONTACT, E.ESAL);
        
--Q.43 Write a query to get maximum service amount of each customer with their customer details ?

       SELECT C.CID,C.CNAME,C.CADD,C.C_CONTACT,C.C_CREDIT_DAYS,C.CJ_DATE,C.SEX, MAX(TOTAL) MAX_SERVICE_AMT FROM CUSTOMER C
       INNER JOIN SER_DET S
       ON C.CID=S.CID
       GROUP BY  C.CID,C.CNAME,C.CADD,C.C_CONTACT,C.C_CREDIT_DAYS,C.CJ_DATE,C.SEX;
      
--Q.44 Get the details of customers with his total no of services ?

       SELECT C.CID, C.CNAME, C.CADD, C.C_CONTACT, C.C_CREDIT_DAYS, C.CJ_DATE, C.SEX, COUNT(*) TOTAL_SER FROM CUSTOMER C
       INNER JOIN SER_DET S
       ON C.CID=S.CID
       GROUP BY  C.CID,C.CNAME,C.CADD,C.C_CONTACT,C.C_CREDIT_DAYS,C.CJ_DATE,C.SEX;
       
--Q.45 From which location sparpart purchased  with highest cost ?
       
       SELECT VADD AS LOCATION FROM VENDORS
       WHERE VID IN(
       SELECT VID FROM PURCHASE
       WHERE TOTAL =(
       SELECT MAX(TOTAL) FROM PURCHASE));
       
--Q.46 Get the details of employee with their service details who has salary is null

       SELECT * FROM EMPLOYEE_G
       WHERE ESAL IS NULL;

--Q.47 find the sum of purchase location wise 

       SELECT V.VADD AS LOCATION, SUM(P.TOTAL) TOTAL_AMT  FROM VENDORS V
       INNER JOIN PURCHASE P
       ON V.VID=P.VID
       GROUP BY V.VADD;
       
--Q.48 write a query sum of purchase amount in word location wise ?
    
       SELECT V.VADD AS LOCATION, TO_CHAR(to_date(TRUNC(SUM(P.TOTAL))),'J','JSP') TOTAL_AMT  FROM VENDORS V
       INNER JOIN PURCHASE P
       ON V.VID=P.VID
       GROUP BY V.VADD;
       
--Q.49 Has the customer who has spent the largest amount money has been give highest rating.
       
       --------NO RATING COLUMN IN ANY TABLE
       
       SELECT * FROM CUSTOMER
       SELECT * FROM SPAREPART
       SELECT * FROM PURCHASE
       SELECT * FROM SER_DET
       SELECT * FROM VENDORS
       SELECT * FROM EMPLOYEE_G
       
--Q.50 select the total amount in service for each customer for which the total is greater than the amount of the largest service amount in the table.
     
       SELECT * FROM(
       SELECT CID,SUM(TOTAL) TOTAL FROM SER_DET
       GROUP BY CID )
       WHERE TOTAL >
      (SELECT MAX(TOTAL) FROM SER_DET);
       
--Q.51  List the customer name and sparepart name used for their vehicle and  vehicle type

       SELECT C.CNAME, S.SPNAME, SD.TYP_VEH FROM SER_DET SD     
       INNER JOIN CUSTOMER C
       ON SD.CID= C.CID
       INNER JOIN SPAREPART S
       ON SD.SPID= S.SPID;
     
--Q.52 Write a query to get spname ,ename, cname, quantity ,rate ,service amount for record exist in service table 

       SELECT S.SPNAME, E.ENAME, C.CNAME, SD.QTY, SD.SP_RATE, SD.SER_AMT FROM SER_DET SD 
       INNER JOIN SPAREPART S
       ON SD.SPID=S.SPID
       INNER JOIN EMPLOYEE_G E
       ON SD.EID=E.EID
       INNER JOIN CUSTOMER C
       ON SD.CID=C.CID;

--Q.53 specify the vehicles owners who’s tube damaged.

       SELECT distinct C.* FROM CUSTOMER C
       INNER JOIN SER_DET S
       ON C.CID=S.CID
       WHERE UPPER(TRIM(S.TYP_SER)) LIKE 'TUBE DAMAGE%';
       
       SELECT * FROM CUSTOMER
       WHERE CID IN(
       SELECT CID FROM SER_DET
       WHERE UPPER(TRIM(TYP_SER)) LIKE 'TUBE DAMAGE%');
       
--Q.54 Specify the details who have taken full service.

       SELECT distinct C.* FROM CUSTOMER C
       INNER JOIN SER_DET S
       ON C.CID=S.CID
       WHERE UPPER(TRIM(S.TYP_SER))='FULL SERVICING';
       
--Q.55 Select the employees who have not worked yet and left the job.
       
       SELECT * FROM EMPLOYEE_G
       WHERE EID NOT IN(
       SELECT E.EID FROM EMPLOYEE_G E
       INNER JOIN SER_DET S
       ON E.EID=S.EID)
       AND EDOJ IS NOT NULL;-----------------------------------------------------------------------NO PROPER OUTPUT

--Q.56 Select employee who have worked first ever.  

       
       ---QUESTION NOT CLEAR
       SELECT * FROM CUSTOMER
       SELECT * FROM SPAREPART
       SELECT * FROM PURCHASE
       SELECT * FROM SER_DET
       SELECT * FROM VENDORS
       SELECT * FROM EMPLOYEE_G    
--Q.57 Display all records falling in odd date.

       SELECT * FROM SER_DET
       WHERE MOD(EXTRACT(DAY FROM SER_DATE),2)=1;
       
--Q.58 Display all records falling in even date.

       SELECT * FROM SER_DET
       WHERE MOD(EXTRACT(DAY FROM SER_DATE),2)=0;
      
--Q.59 Display the vendors whose material is not yet used.
  
       SELECT DISTINCT V.* FROM VENDORS V
       JOIN PURCHASE P
       ON V.VID = P.VID
       WHERE NOT EXISTS (
       SELECT 1
       FROM SER_DET S
       WHERE S.SPID = P.SPID );

--Q.60 Difference between purchase date and used date of spare part.
 
       SELECT P.PDATE-SD.SER_DATE FROM SER_DET SD
       INNER JOIN PURCHASE P
       ON SD.SPID=P.SPID;
       






























