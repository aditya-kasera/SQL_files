USE org;

DESC Worker;

insert into Worker(worker_id,  f_name, l_name, join_date, department) values 
	(006, 'Saraswati', 'Mayra', '21-02-12 09:12:00', 'Devops');
-- default salary took as 55000

-- delete row?

select * from Worker where worker_id = 006;

-- update
UPDATE Worker set salary = 100000 where l_name = 'Kumar';
-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE Worker set city = 'Bombay';

-- delete
DELETE FROM Worker where worker_id = 1;
-- SET SQL_SAFE_UPDATES = 0;
-- DELETE FROM Worker

-- replce
REPLACE INTO Worker (city) VALUE ('Bhopal');
REPLACE INTO Worker (worker_id, city) VALUE (6,'Bhopal');
-- Provides clarity, use when you want to specify exactly which columns are being replaced
-- with their corresponding values, ensuring - only specific columns are affected.

REPLACE INTO Worker SET f_name = 'Manu', city = 'Kota';
-- Concise syntax. Easy to R/W, when you have a smaller number of columns to replace

REPLACE INTO Worker (worker_id, f_name, salary, city) 
	SELECT worker_id, f_name, salary, city FROM Worker WHERE  worker_id = 5; 
    -- this replaces data of worker_id = 5 worker by only those attributes mentioned in subquery
    
replace into Worker(worker_id,  f_name, l_name, salary, join_date, department) values 
	(005, 'Akash', 'Kumar', 150000, '21-03-12 09:12:00', 'Full Stack');
    
    -- DOUBT??  It essentially updates the "city" column for the worker with ID 5
    -- based on the data of another row with the same worker ID. 
    -- If no such row exists, nothing will be replaced. DOUBT.
    
-- Suitable when you need to replace data based on conditions or from another table.
-- Helpful for more complex scenarios where you need to retrieve data from another table or apply filtering conditions.
select * from worker;