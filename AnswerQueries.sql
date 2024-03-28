DROP DATABASE IF EXISTS company;
CREATE DATABASE IF NOT EXISTS company;
USE company;
CREATE TABLE WORKER (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT,
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO WORKER 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09:00:00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09:00:00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09:00:00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09:00:00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09:00:00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09:00:00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09:00:00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09:00:00', 'Admin');
        
CREATE TABLE BONUS (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES WORKER(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO BONUS 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');
        
CREATE TABLE TITLE (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES WORKER(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO TITLE (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');


-- Q-1. Write an SQL query to fetch “FIRST_NAME” from WORKER table using the alias name as <WORKER_NAME>.
SELECT FIRST_NAME AS WORKER_NAME FROM WORKER;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from WORKER table in upper case.
SELECT ucase(FIRST_NAME) FROM WORKER;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from WORKER table.
SELECT DEPARTMENT FROM WORKER GROUP BY DEPARTMENT;
SELECT DISTINCT DEPARTMENT FROM WORKER;

-- Q-4. Write an SQL query to print the first three characters of FIRST_NAME from WORKER table.
SELECT SUBSTRING(FIRST_NAME,1,3) FROM WORKER;

-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from WORKER table.
SELECT instr(FIRST_NAME, 'b') FROM WORKER WHERE FIRST_NAME = 'Amitabh';

-- Q-6. Write an SQL query to print the FIRST_NAME from WORKER table after removing white spaces from the right side.
SELECT RTRIM(FIRST_NAME) FROM WORKER;

-- Q-7. Write an SQL query to print the DEPARTMENT from WORKER table after removing white spaces from the left side.
SELECT LTRIM(DEPARTMENT) FROM WORKER;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from WORKER table and prints its length.
SELECT DISTINCT DEPARTMENT, length(DEPARTMENT) FROM WORKER;

-- Q-9. Write an SQL query to print the FIRST_NAME from WORKER table after replacing ‘a’ with ‘A’.
SELECT replace(FIRST_NAME, 'a', 'A') FROM WORKER;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from WORKER table into a single column COMPLETE_NAME.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS COMPLETE_NAME FROM WORKER;

-- Q-11. Write an SQL query to print all WORKER details from the WORKER table order by FIRST_NAME Ascending.
SELECT * FROM WORKER order by FIRST_NAME;

-- Q-12. Write an SQL query to print all WORKER details from the WORKER table order by FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM WORKER order by FIRST_NAME, DEPARTMENT DESC;

-- Q-13. Write an SQL query to print details for WORKERs with the first name as “Vipul” and “Satish” from WORKER table.
SELECT * FROM WORKER WHERE FIRST_NAME IN ("Vipul", "Satish");

-- Q-14. Write an SQL query to print details of WORKERs excluding first names, “Vipul” and “Satish” from WORKER table.
SELECT * FROM WORKER WHERE FIRST_NAME NOT IN ("Vipul", "Satish");

-- Q-15. Write an SQL query to print details of WORKERs with DEPARTMENT name as “Admin*”.
SELECT * FROM WORKER WHERE DEPARTMENT = "Admin";

-- Q-16. Write an SQL query to print details of the WORKERs whose FIRST_NAME contains ‘a’.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%a%';

-- Q-17. Write an SQL query to print details of the WORKERs whose FIRST_NAME ends with ‘a’.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%a';

-- Q-18. Write an SQL query to print details of the WORKERs whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%h' AND length(FIRST_NAME) = 6;

-- Q-19. Write an SQL query to print details of the WORKERs whose SALARY lies between 100000 and 500000.
SELECT * FROM WORKER WHERE SALARY BETWEEN 100000 and 500000;

-- Q-20. Write an SQL query to print details of the WORKERs who have joined in Feb’2014.
SELECT * FROM WORKER WHERE substring(JOINING_DATE, 0,2) = '14';

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT DISTINCT DEPARTMENT, COUNT(*) FROM WORKER WHERE DEPARTMENT = 'Admin';
SELECT DEPARTMENT, COUNT(WORKER_ID) FROM WORKER WHERE DEPARTMENT = 'Admin';

-- Q-22. Write an SQL query to fetch WORKER full names with salaries >= 50000 and <= 100000.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME), SALARY FROM WORKER WHERE SALARY >= 50000 and SALARY <= 100000;

-- Q-23. Write an SQL query to fetch the no. of WORKERs for each department in the descending order.
SELECT DISTINCT DEPARTMENT, COUNT(*) AS WORKER_COUNT FROM WORKER GROUP BY DEPARTMENT 
	ORDER BY WORKER_COUNT DESC;

-- Q-24. Write an SQL query to print details of the WORKERs who are also Managers. ✔️
SELECT * FROM WORKER RIGHT JOIN TITLE ON TITLE.WORKER_REF_ID = WORKER.WORKER_ID 
	WHERE TITLE.WORKER_TITLE = 'Manager';

-- Q-25. Write an SQL query to fetch number (more than 1) of same TITLEs in the ORG of different types.
SELECT WORKER_TITLE, COUNT(*) FROM TITLE GROUP BY WORKER_TITLE;

-- Q-26. Write an SQL query to show only odd rows from a table.
SELECT * FROM WORKER WHERE MOD(WORKER_ID,2) <> 0;

-- Q-27. Write an SQL query to show only even rows from a table. 
SELECT * FROM WORKER WHERE MOD(WORKER_ID,2) = 0;

-- Q-28. Write an SQL query to clone a new table from another table.
CREATE TABLE WORKER_CLONE LIKE WORKER;
INSERT INTO WORKER_CLONE SELECT * FROM WORKER;

-- Q-29. Write an SQL query to fetch intersecting records of two tables.
SELECT DISTINCT * FROM WORKER INNER JOIN TITLE;
SELECT DISTINCT * FROM WORKER INNER JOIN WORKER_CLONE USING(WORKER_ID);

-- Q-30. Write an SQL query to show records from one table that another table does not have.
SELECT * FROM WORKER LEFT JOIN WORKER_CLONE ON WORKER.WORKER_ID = WORKER_CLONE.WORKER_ID 
	WHERE WORKER.WORKER_ID IS NULL;
    
-- Q-31. Write an SQL query to show the current date and time.
SELECT curdate(), NOW();

-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 5;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 4,1;

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword. ✔️ corelated subquery
SELECT SALARY FROM WORKER W1 WHERE 4 = (
	SELECT COUNT(DISTINCT(W2.SALARY)) FROM WORKER W2 WHERE W2.SALARY >= W1.SALARY
); -- 4 salaries are more than answer salary

-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT W1.* FROM WORKER W1, WORKER W2 WHERE W1.SALARY = W2.SALARY AND W1.WORKER_ID != W2.WORKER_ID;

-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
SELECT MAX(SALARY) FROM WORKER WHERE SALARY != (SELECT MAX(SALARY) FROM WORKER);

-- Q-37. Write an SQL query to show one row twice in results from a table.
SELECT * FROM WORKER UNION ALL SELECT * FROM WORKER ORDER BY WORKER_ID;

-- Q-38. Write an SQL query to list WORKER_id who does not get BONUS.
SELECT WORKER_ID FROM WORKER WHERE WORKER_ID NOT IN 
	(SELECT WORKER_REF_ID FROM BONUS);

-- Q-39. Write an SQL query to fetch the first 50% records from a table.
SELECT * FROM WORKER WHERE WORKER_ID <= (SELECT COUNT(*)/2 FROM WORKER);

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
SELECT DEPARTMENT, COUNT(DEPARTMENT) AS WOR_COUNT FROM WORKER GROUP BY DEPARTMENT HAVING 4 > COUNT(*);

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
SELECT DEPARTMENT, COUNT(DEPARTMENT) AS WOR_COUNT FROM WORKER GROUP BY DEPARTMENT;

-- Q-42. Write an SQL query to show the last record from a table.
SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MAX(WORKER_ID) FROM WORKER);

-- Q-43. Write an SQL query to fetch the first row of a table.
SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MIN(WORKER_ID) FROM WORKER);

-- Q-44. Write an SQL query to fetch the last five records from a table.
SELECT * FROM WORKER WHERE WORKER_ID > (SELECT MAX(WORKER_ID) FROM WORKER) - 5;
(select * from worker order by worker_id desc limit 5) order by worker_id; -- ✔️ using limit

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT W2.DEPARTMENT, W2.FIRST_NAME, W2.SALARY FROM 
	(SELECT MAX(SALARY) AS MAX_SALARY, DEPARTMENT FROM WORKER GROUP BY DEPARTMENT) W1 INNER JOIN WORKER W2 ON 
    W1.DEPARTMENT = W2.DEPARTMENT AND W1.MAX_SALARY = W2.SALARY;

-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
SELECT DISTINCT SALARY FROM WORKER W1 
	WHERE (SELECT COUNT(DISTINCT SALARY) FROM WORKER W2 WHERE W1.SALARY <= W2.SALARY) <= 3
    ORDER BY W1.SALARY desc;
    
-- USING LIMIT:
select distinct salary from worker order by salary desc limit 3;

-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
SELECT DISTINCT SALARY FROM WORKER W1 
	WHERE (SELECT COUNT(DISTINCT SALARY) FROM WORKER W2 WHERE W1.SALARY >= W2.SALARY) <= 3
    ORDER BY W1.SALARY;

-- Q-48. Write an SQL query to fetch nth max salaries from a table. (IF N = 5)
SELECT DISTINCT SALARY FROM WORKER W1 
	WHERE (SELECT COUNT(DISTINCT SALARY) FROM WORKER W2 WHERE W1.SALARY <= W2.SALARY) <= 5
    ORDER BY W1.SALARY desc;

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT DEPARTMENT, SUM(SALARY) AS total_sal FROM WORKER GROUP BY DEPARTMENT;

-- Q-50. Write an SQL query to fetch the names of WORKERs who earn the highest salary.
SELECT FIRST_NAME, LAST_NAME, SALARY FROM WORKER WHERE SALARY = (SELECT MAX(SALARY) FROM WORKER);