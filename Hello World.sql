drop database if exists temp;

create database temp;
show databases;

use temp;

create table student (
	id int primary key,
    name varchar(255)
);

insert into student values(1,'Hello World');

select * from student;
