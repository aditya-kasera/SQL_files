USE org;

SELECT f_name, l_name FROM Worker;
-- ORDER OF EXECUTION RIGHT TO LEFT

-- DUAL
SELECT 2+3;
SELECT now();
SELECT lcase('HO');

-- WHERE CLAUSE - TO FILTER
SELECT f_name, l_name, salary FROM Worker WHERE salary < 100000;
SELECT f_name, l_name, department FROM Worker WHERE department = 'Devops';

-- WHERE AND
SELECT f_name, l_name, department FROM Worker WHERE department = 'Devops' AND salary > 75000;

-- WHERE OR
SELECT f_name, l_name, department FROM Worker WHERE department = 'Devops' OR department = 'AI/ML';

-- BETTER WAY : IN
SELECT f_name, l_name, department FROM Worker WHERE department IN ('Devops', 'AI/ML');

-- WHERE NOT
SELECT f_name, l_name, department FROM Worker WHERE department NOT IN ('Devops');

-- WHERE BETWEEN - [N1, N2] - INCLUSIVE
SELECT f_name, l_name, salary FROM Worker WHERE salary BETWEEN 50000 AND 100000;

-- IS NULL
SELECT f_name, l_name, department FROM Worker WHERE department IS NULL;

-- NOT NULL
SELECT f_name, l_name, department FROM Worker WHERE department IS NOT NULL;


-- LIKE - WILDCARD
SELECT f_name FROM Worker WHERE f_name LIKE '_A%';

-- ORDER BY - SORTING
SELECT f_name, l_name, salary FROM Worker ORDER BY salary;
SELECT f_name, l_name, salary FROM Worker ORDER BY salary DESC;

-- DISTINCT - VALUES
SELECT DISTINCT department FROM Worker;

-- GROUP BY - GROUPING DATA
SELECT department FROM Worker GROUP BY department; -- OUTPUT SAME AS DISTINCT
SELECT department, COUNT(*) FROM Worker GROUP BY department; -- USED WITH AGGREGATION FUNCTIONS
SELECT department, AVG(salary) FROM Worker GROUP BY department;
SELECT department, MIN(salary) FROM Worker GROUP BY department;
SELECT department, MAX(salary) FROM Worker GROUP BY department;
SELECT department, SUM(salary) FROM Worker GROUP BY department;

-- GROUP BY HAVING - FILTERING IN GROUPING

SELECT department, COUNT(*) FROM Worker GROUP BY department HAVING COUNT(department) > 1;
-- dept and count having more than 1 workers

-- ---------|
--  JOINS   |
-- ---------|

-- inner join
SELECT w.*, b.* FROM Worker as w INNER JOIN Bonus as b ON w.worker_id = b.worker_ref_id;
SELECT w.*, b.* FROM Worker as w INNER JOIN Bonus as b ON w.worker_id = b.worker_ref_id where w.city = 'Indore';

-- outer join
SELECT w.*, b.* FROM Worker as w LEFT JOIN Bonus as b ON w.worker_id = b.worker_ref_id;
SELECT w.*, b.* FROM Worker as w RIGHT JOIN Bonus as b ON w.worker_id = b.worker_ref_id;

-- full outer join
SELECT w.*, b.* FROM Worker as w LEFT JOIN Bonus as b ON w.worker_id = b.worker_ref_id UNION
	SELECT w.*, b.* FROM Worker as w RIGHT JOIN Bonus as b ON w.worker_id = b.worker_ref_id;
    
-- cross join or cartisian product
SELECT Worker.*, Bonus.* FROM Worker CROSS JOIN Bonus;

-- self join - emulated using inner join and aliasing
SELECT w1.*, w2.* FROM Worker as w1 INNER JOIN Worker as w2 ON w1.worker_id = w2.worker_id;

-- inner join without join keyword
SELECT * FROM Worker, Bonus WHERE Worker.worker_id = Bonus.worker_ref_id;

-- -------------------| UNION - combines multiple select statements
--   SET OPERATIONS   | INTERSECTION
-- -------------------| MINUS

SELECT * FROM Title UNION SELECT * FROM Bonus; -- UNION 
SELECT * FROM Title UNION ALL SELECT * FROM Bonus; -- UNION 
SELECT DISTINCT * FROM Title INNER JOIN Bonus USING(worker_ref_id); -- INTERSECTION

DELETE FROM Bonus WHERE worker_ref_id = 3;
SELECT * FROM Title LEFT JOIN Bonus USING(worker_ref_id) 
	WHERE Bonus.worker_ref_id IS NULL; -- MINUS 
    
insert into Bonus(	worker_ref_id, bonus_amt, bonus_date) values   
	(003, 18000, '21-07-01');
    

-- --------------| /nested queries
--   SUBQUERIES  | alternative to JOINS
-- --------------| outer query depends in inner query

-- after where clause
SELECT * FROM Worker WHERE salary > 70000;
SELECT * FROM Worker WHERE salary IN 
	(SELECT salary FROM Worker WHERE salary > 70000);
   
SELECT * FROM Worker WHERE worker_id IN 
	(SELECT worker_ref_id FROM Bonus GROUP BY worker_ref_id HAVING worker_ref_id = 2);
SELECT * FROM Worker WHERE worker_id IN 
	(SELECT worker_ref_id FROM Bonus GROUP BY worker_ref_id HAVING COUNT(worker_ref_id) = 1);

-- single valued subquery
SELECT * FROM Worker WHERE 
	salary < (SELECT AVG(salary) FROM Worker);

-- after from - derived tables - selects TABLE
SELECT MAX(salary) FROM 
	(SELECT salary FROM Worker WHERE f_name LIKE '%m%') AS DerivedWorkerTable;	
    -- max(salary) of employees who's f_name has'm'

-- corelated subquery - inners query refers outer query
-- for outer query, inner query executes till condition is met
SELECT * FROM Worker w1 WHERE 2 = 
	(select count(w2.salary) FROM Worker w2 WHERE w2.salary > w1.salary);
-- worker with third highest salary - when 2 employees are having salary > that salary


-- case statemrnt
SELECT salary ,CASE
	WHEN salary>90000 THEN 'big SALARY'
    WHEN salary<90000 THEN 'small SALARY'
    ELSE '90000 HAI'
END AS IFELSE 
FROM WORKER;

-- COMMMON TABLE EXPRESSION
WITH AVG_SALARY_CTE AS (SELECT AVG(salary) as A_sal FROM Worker GROUP BY salary)
SELECT A_sal FROM AVG_SALARY_CTE WHERE A_sal>0;

-- WINDOW FUNCTIONS
SELECT DEPARTMENT, AVG(salary) FROM Worker GROUP BY department HAVING department IS NOT NULL;
SELECT DEPARTMENT, 
	AVG(salary) OVER(PARTITION BY department) AS dept_avg,
    MIN(salary) OVER(PARTITION BY department) AS dept_min,
    MAX(salary) OVER(PARTITION BY department) AS dept_max,
    RANK() OVER(ORDER BY salary DESC)
    FROM Worker WHERE department IS NOT NULL;











