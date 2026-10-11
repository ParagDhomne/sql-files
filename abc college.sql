CREATE TABLE abc_college 
(
       Student_ID number primary key,
       Student_name varchar2(30),
       city varchar2(20),
       phone_number number,
       email varchar2(50)
);

drop table abc_college;

insert into abc_college values(01,'Parag Dhomne','Tumsar',9049067962,'paragdhomne@gmail.com',to_date('21/02/1998','dd/mm/yyyy'));
insert into abc_college values(02,'Prasad Dhote','Hinganghat',9044567878,'prasaddhote@gmail.com');
insert into abc_college values(03,'Kshitij Baswar','Saoner',9049064462,'kshitijbaswar@gmail.com',to_date('1/02/1999','dd/mm/yyyy'));
insert into abc_college values(04,'Vaishnavi Thakur','Nagpur',9077067962,'vaishanavithakur@gmail.com');
insert into abc_college values(05,'Pranav Baswar','Saonerr',9049068862,'pranavbaswar@gmail.com');
insert into abc_college values(06,'Ankita Selukar','Nagpur',9049007962,'ankitaselukar@gmail.com');
insert into abc_college values(07,'Mohit Rangwani','Tumsar',9049967962,'mohitrangwani@gmail.com');
insert into abc_college values(08,'Rishabh Wahile','Pune',9049070955,'rishabhwahil@gmail.com');


Alter table abc_college
add constraint chk_phone_number check (Length (Phone_number)=10);

alter table abc_college
modify Student_id not null;

ALTER TABLE abc_college 
add DOB date;

select sysdate from dual;

SELECT TO_CHAR(SYSDATE,'DD/MM/YYYY') FROM DUAL;

update abc_college
set DOB =to_date('06/11/1998','DD/MM/YYYY')
where Student_id = 02;

delete from abc_college
where Student_id = 03;

update abc_college
set city='Delhi'
where Student_id = 07;

select * from abc_college
ORDER BY STUDENT_ID;

truncate table abc_college;

1
--------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Semister_1
(
       Stu_ID number not null,
       Maths Number,
       Physcis number,
       Chemistry number,
       Computer number,
       foreign key (stu_id) references abc_College (Student_id)
       on delete cascade
);

INSERT INTO SEMISTER_1 VALUES(01,70,80,50,80);
INSERT INTO SEMISTER_1 VALUES(02,80,70,70,60);
INSERT INTO SEMISTER_1 VALUES(03,70,50,80,50);
INSERT INTO SEMISTER_1 VALUES(04,70,80,67,86);
INSERT INTO SEMISTER_1 VALUES(05,77,98,67,99);
INSERT INTO SEMISTER_1 VALUES(06,88,95,67,86);
INSERT INTO SEMISTER_1 VALUES(07,77,85,56,88);
INSERT INTO SEMISTER_1 VALUES(08,77,86,65,96);


ALTER TABLE SEMISTER_1
MODIFY STU_ID UNIQUE;

ALTER TABLE SEMISTER_1
ADD CONSTRAINT CHK_MATHS CHECK(MATHS>=70);




DELETE FROM SEMISTER_1
WHERE STU_ID=02;

drop table Semister_1;

truncate table Semister_1;

select * from Semister_1
ORDER BY STU_ID;

select * from abc_college;



----------------------------------------
select * from hr.employees;
