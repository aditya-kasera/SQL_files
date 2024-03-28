drop database if exists org;
create database if not exists org;
use org;

-- -------------------|
--  CREATING SCHEMA   |
-- -------------------|

-- primary key makes automatically unique and not null-- 
create table Worker(
	worker_id int primary key auto_increment,
    f_name varchar(255),
    l_name varchar(255) unique,
    salary int not null default 55000,
    constraint salary_check check(salary > 50000),
    join_date datetime,
    department varchar(255)    
);

-- primary key(id), ... [OR]

insert into Worker(worker_id,  f_name, l_name, salary, join_date, department) values 
	(001, 'Saraswati', 'Arora', 70000, '21-02-12 09:12:00', 'Devops'),
    (002, 'Arpita', 'Singh', 95000, '21-06-19 14:12:22', 'Data'),
    (003, 'Mahesh', 'Basin', 80000, '21-02-12 09:12:00', 'Devops'),
    (004, 'Swarna', 'Swain', 90000, '20-08-19 10:12:00', 'AI/ML'),
    (005, 'Akash', 'Kumar', 150000, '21-03-12 09:12:00', 'Full Stack');
    
create table Bonus(
	worker_ref_id int, 
	foreign key (worker_ref_id) 
		references Worker(worker_id)
        ON DELETE CASCADE,
    bonus_amt int,
    bonus_date datetime
);

insert into Bonus(	worker_ref_id, bonus_amt, bonus_date) values 
	(001, 12000, '21-09-11'),
	(002, 15000, '21-10-10'),
	(003, 18000, '21-07-01');

create table Title(
	worker_ref_id int, 
		foreign key (worker_ref_id) 
			references Worker(worker_id)
			on delete set null,
    worker_title varchar(255),
    affected_from datetime 
);

insert into Title(	worker_ref_id, worker_title, affected_from) values 
	(001, 'Devops Executive', '21-09-11'),
	(002, 'Data Engineer', '21-10-10'),
	(003, 'Devops Engineer', '21-07-01');

-- -------------------|
--  ALTERING SCHEMA   |
-- -------------------|

-- add column
ALTER TABLE Worker ADD level bit not null default 0;
ALTER TABLE Worker ADD city varchar(20) default 'Indore';

-- modify datatype, etc. properties of column
ALTER TABLE Worker MODIFY level TINYINT default 1;	-- not null is overridden to can be null
DESC Worker;  -- describe table

-- change column - rename column, datatype should also be specified
ALTER TABLE Worker CHANGE COLUMN level position TINYINT DEFAULT 1;
DESC Worker; 

-- drop column - deletes column
ALTER TABLE Worker DROP COLUMN position;
DESC Worker; 

-- rename to - rename table
ALTER TABLE Worker RENAME TO Employee;
DESC Employee;
ALTER TABLE Employee RENAME TO Worker;
DESC Worker;

-- ---------|
--  VIEWS   |
-- ---------|

SELECT * FROM Worker;
CREATE VIEW name AS SELECT f_name, l_name FROM Worker;
ALTER VIEW name AS SELECT f_name FROM Worker;
SELECT * FROM name;
DROP VIEW IF EXISTS name;
