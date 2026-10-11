create table school
( Roll_Number number,
  Full_Name varchar2(30),
  Standerd number,
  Phone_Number number
);

insert into school values(01,'Parag Dhomne',12,9049067962);
insert into school values(02,'Prasad Dhote',12,9049057962);
insert into school values(03,'kshitij baswar',12,9069067962);
insert into school values(04,'Pranav baswar',12,9049087962);

select * from school;

drop table school;
