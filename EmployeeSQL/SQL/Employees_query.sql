CREATION OF TABLE from QUICKDBD imported file;

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "gender" VARCHAR(2)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(5)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" FLOAT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR(60)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");




Donwload data from CSV to tables created

COPY employees
    FROM 'D:\GT Data Science and Analytics\Home_work\sql_challenge\EmployeeSQL\data\employees.csv' DELIMITER ',' CSV HEADER;
	
COPY departments
    FROM 'D:\GT Data Science and Analytics\Home_work\sql_challenge\EmployeeSQL\data\departments.csv' DELIMITER ',' CSV HEADER;
	
COPY dept_manager
    FROM 'D:\GT Data Science and Analytics\Home_work\sql_challenge\EmployeeSQL\data\dept_manager.csv' DELIMITER ',' CSV HEADER;
	
COPY dept_emp
    FROM 'D:\GT Data Science and Analytics\Home_work\sql_challenge\EmployeeSQL\data\dept_emp.csv' DELIMITER ',' CSV HEADER;
	
COPY salaries
    FROM 'D:\GT Data Science and Analytics\Home_work\sql_challenge\EmployeeSQL\data\salaries.csv' DELIMITER ',' CSV HEADER;
	
COPY titles
    FROM 'D:\GT Data Science and Analytics\Home_work\sql_challenge\EmployeeSQL\data\titles.csv' DELIMITER ',' CSV HEADER;


DROP VIEW if EXISTS task_1;
CREATE VIEW task_1 AS
SELECT emp.emp_no, last_name, first_name, gender, salary
FROM employees as emp
JOIN salaries as sal ON sal.emp_no = emp.emp_no
ORDER BY emp.emp_no ASC;
SELECT * FROM task_1;


DROP VIEW if EXISTS task_2; 
CREATE VIEW task_2 AS
SELECT last_name, first_name, hire_date
FROM employees 
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;
SELECT * FROM task_2;


DROP VIEW if EXISTS task_3; 
CREATE VIEW task_3 AS
SELECT man.emp_no, man.dept_no, dept_name, last_name, first_name, from_date, to_date
FROM dept_manager AS man
JOIN employees AS emp ON emp.emp_no = man.emp_no
JOIN departments AS dept ON dept.dept_no = man.dept_no
ORDER BY man.emp_no ASC;
SELECT * FROM task_3;


DROP VIEW if EXISTS task_4; 
CREATE VIEW task_4 AS
SELECT emp.emp_no, last_name, first_name, dept_name
FROM employees AS emp
JOIN dept_emp AS demp ON demp.emp_no = emp.emp_no
JOIN departments AS dept ON dept.dept_no = demp.dept_no
ORDER BY emp.emp_no ASC;
SELECT * FROM task_4;



DROP VIEW if EXISTS task_5; 
CREATE VIEW task_5 AS
SELECT last_name, first_name
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name ASC;
SELECT * FROM task_5;



DROP VIEW if EXISTS task_6;
CREATE VIEW task_6 AS
SELECT emp.emp_no, last_name, first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS demp ON demp.emp_no = emp.emp_no
JOIN departments AS dept ON dept.dept_no = demp.dept_no
WHERE dept_name = 'Sales'
ORDER BY emp.emp_no;



DROP VIEW if EXISTS task_7;
CREATE VIEW task_7 AS
SELECT emp.emp_no, last_name, first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS demp ON demp.emp_no = emp.emp_no
JOIN departments AS dept ON dept.dept_no = demp.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
ORDER BY emp.emp_no;
SELECT * FROM task_7;



DROP VIEW if EXISTS task_8;
CREATE VIEW task_8 AS
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;
SELECT * FROM task_8;