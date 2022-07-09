-- COMPANY DATABASE EXERCISE

-- In this exercise, a database for a hypothetical company will be created, given its schema.

-- > Create the database

CREATE DATABASE company_database;

-- > Create tables 'employee' and 'branch'

CREATE TABLE employee (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  supervisor_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(20),
  manager_id INT,
  manager_start_date DATE
  FOREIGN KEY(manager_id) REFERENCES employee(employee_id) ON DELETE SET NULL -- Foreign key 'manager_id' references the 'employee_id' from the table 'employee'
);


-- > Set foreign keys in 'employee' table

-- Set 'branch_id' as a foreign key that references branch.branch_id
ALTER TABLE employee
ADD FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
ON DELETE SET NULL;

-- Set 'supervisor_id' as a foreign key that references employee.employee_id
ALTER TABLE employee
ADD FOREIGN KEY (supervisor_id) REFERENCES employee(employee_id)
ON DELETE SET NULL;


-- > Continue creating tables 'client', 'works_with', and 'branch_supplier'

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(30),
  branch_id INT,
  FOREIGN KEY branch_id REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  employee_id INT,
  client_id INT,
  total_sales DECIMAL(10, 2),
  PRIMARY KEY (employee_id, client_id), -- Sets a composite key as the combination of 'employee_id' and 'client_id'
  FOREIGN KEY employee_id REFERENCES employee(employee_id) ON DELETE CASCADE,
  FOREIGN KEY client_id REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(30),
  supply_type VARCHAR(40),
  PRIMARY KEY (branch_id, supplier_name),
  FOREIGN KEY branch_id REFERENCES branch(branch_id) ON DELETE CASCADE,
)


-- > Inserting data 

-- Corporate' branch

INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL); -- Last field is null because 'branch' table isn't created yet

INSERT INTO branch VALUES (1, 'Corporate', 100, '2006-02-09');

UPDATE employee SET branch_id = 1 WHERE employee_id = 100; -- Updates branch_id now that it is created

INSERT INTO employee VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- 'Scranton' branch

INSERT INTO employee VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL)

INSERT INTO branch VALUES (2, 'Scranton', 102, '1992-04-06');

UPDATE employee SET branch_id = 2 WHERE employee_id = 102; -- Updates branch_id now that it is created

INSERT INTO employee VALUES (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- 'Stamford' branch

INSERT INTO employee VALUES (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL)

INSERT INTO branch VALUES (3, 'Stamford', 106, '1998-02-13');

UPDATE employee SET branch_id = 3 WHERE employee_id = 106; -- Updates branch_id now that it is created

INSERT INTO employee VALUES (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES (108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- 'Buffalo' branch

INSERT INTO branch VALUES (4, 'Buffalo', NULL, NULL);

-- Branch_supplier

INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- client

INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- works_with

INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);