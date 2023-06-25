/* TASK 1 : creating company database */

-- 1 employee table 
CREATE TABLE employee (
	emp_id INT PRIMARY KEY, -- set primary key
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT 
);

-- 2 branch table
CREATE TABLE branch (
	branch_id INT PRIMARY KEY,
    branch_name VARCHAR(50),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
/* It specifies that the child data is set to NULL when the parent data is deleted. 
The child data is NOT deleted. */
);

-- add foreign keys to employee table created
AlTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id) ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id) ON DELETE SET NULL;

-- 3 client table
CREATE TABLE client (
	client_id INT PRIMARY KEY,
    client_name VARCHAR(50),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

-- 4 works_with table 
CREATE TABLE work_with (
	emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id,client_id), -- Composite Key
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
/*  It is used in conjunction with ON DELETE or ON UPDATE. 
It means that the child data is either deleted or updated when the parent data is deleted or updated. */
);

-- 5 branch supplier table
CREATE TABLE branch_supplier (
	branch_id INT,
    supplier_name VARCHAR(50),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id,supplier_name), -- Composite Key
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

/* TASK 2 : inserting data/information */

# employee table and branch table 
--  for corporate branch
INSERT INTO employee VALUES(100,'David','Wallace','1967-11-17','M',250000,NULL,NULL);
-- NULL because branch_id is not created yet
INSERT INTO branch VALUES(1,'corporate',100,'2006-02-09');
-- Now we can update employee table davids branch id as it is added in branch table
UPDATE employee
SET branch_id=1
WHERE emp_id=100;
-- insert next employee info
INSERT INTO employee VALUES(101,'Jan','Levinson','1961-05-11','F',110000,100,1);

-- for scranton branch
INSERT INTO employee VALUE(102,'Michael','Scott','1964-03-15','M',75000,100,NULL);
INSERT INTO branch VALUE(2,'Scranton',102,'1992-04-06');

UPDATE employee
SET branch_id=2
WHERE emp_id=102;

INSERT INTO employee VALUES(103,'Angela','Martin','1964-03-15','F',63000,102,2);
INSERT INTO employee VALUES(104,'Kelly','Kapoor','1964-03-15','F',55000,102,2);
INSERT INTO employee VALUES(105,'Stanley','Hudson','1964-03-15','M',69000,102,2);

-- for stamford branch
INSERT INTO employee VALUES(106,'Josh','Porter','1969-09-05','M',78000,100,NULL);
INSERT INTO branch VALUES(3,'Stamford',106,'1998-02-13');

UPDATE employee SET branch_id=3 WHERE emp_id=106;
INSERT INTO employee VALUES(107,'Andy','Bernard','1973-07-22','M',65000,106,3);
INSERT INTO employee VALUES(108,'Jim','Halpert','1978-10-01','M',71000,106,3);

# for client table
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

# rename table name of work_with
ALTER TABLE work_with
RENAME TO works_with;

# for works_with table 
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

# for branch supplier table
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

/* Tables are created and data is populated not to check :*/
SELECT * FROM employee;
SELECT * FROM branch;
-- change corporate to Corporate
UPDATE branch
SET branch_name='Corporate'
WHERE branch_id=1;

SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch_supplier;

/* TASK 3 : write basic queries to get the data for 15 questions mentioned in Readme file */

-- Find all employees
SELECT * 
FROM employee;

-- Find all clients
SELECT * 
FROM client;

-- Find all employees ordered by salary
SELECT * 
FROM employee 
ORDER BY salary DESC;

-- Find all employees ordered by sex then name
SELECT * 
FROM employee 
ORDER BY sex, first_name;

-- Find the first 5 employees in the table
SELECT * 
FROM employee 
LIMIT 5;

-- Find the first and last names of all employees
SELECT first_name,last_name 
FROM employee;

-- Find the forename and surnames names of all employees
SELECT first_name AS forename, last_name AS surname
FROM employee;

-- Find out all the different genders
SELECT DISTINCT sex
FROM employee;

-- Find all male employees
SELECT *
FROM employee
WHERE sex='M';

-- Find all employees at branch 2
SELECT *
FROM employee
WHERE branch_id = 2;

-- Find all employee's id's and names who were born after 1969
SELECT emp_id,first_name
FROM employee
WHERE birth_date>= 1969-01-01;

-- Find all female employees at branch 2
SELECT *
FROM employee
WHERE sex='F' AND branch_id=2;

-- Find all employees who are female & born after 1969 or who make over 80000
SELECT *
FROM employee
WHERE (sex='F' AND birth_date>= 1969-01-01) OR salary>80000;

-- Find all employees born between 1970 and 1975
SELECT *
FROM employee
WHERE birth_date BETWEEN '1970-01-01' AND '1975-01-01';

-- Find all employees named Jim, Michael, Johnny or David
SELECT *
FROM employee
WHERE first_name IN ('Jim','Michael','Johnny','David');

/* TASK 4 : write functions to get the data relating to numbers/mathematical operations */



