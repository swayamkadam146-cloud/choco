create database Triggers;
use Triggers;

create table person (name varchar(45),age int);
insert into person values ('Aditi',25),('Aakash',20);
select * from person;

CREATE TABLE avg_age (average double);
INSERT INTO avg_age SELECT AVG(age) FROM person;

CREATE TABLE person_archive (
name varchar(45),
age int,
time timestamp DEFAULT NOW());

delimiter //
create trigger person_bi
before insert
on person
for each row
if new.age<18 then set new.age=0;
end if //

delimiter ;

insert into person value ("Ashwin",55);
insert into person value ("Deeksha",17);

select * from person;

delimiter //
create trigger person_bi2
before insert
on person
for each row
if new.age<18 then 
signal sqlstate '50001' set message_text="Insert Age Older Than 18";
end if //

delimiter ;

insert into person value ("Ash",55);
insert into person value ("Deep",17);

select * from person;
select * from avg_age;

delimiter //
create trigger person_after_insert
after insert
on person
for each row
update avg_age set average=(select avg(age) from person);
//

delimiter ;

insert into person value ("Das",25);

select * from avg_age;

select * from person;

delimiter //
create trigger person_bu
before update
on person
for each row
if new.age<18 then 
signal sqlstate '50001' set message_text="Insert Age Older Than 18";
end if //

delimiter ;

update person set age=19 where name="Ash";













