create table student
(stuid  NUMBER,
 FNAME  VARCHAR2(20),
 LNAME  VARCHAR2(20),
 CITY   VARCHAR2(10)
);

Select * from Student;

drop table student;

truncate table student;

insert into student values(1001,'Parag','Dhomne','Nagpur',34655687);
insert into student values(1002,'Prasad','Dhote','Nagpur',3456789);

alter table student
add contact_no number;

update student 
set contact_no=9049067962;
