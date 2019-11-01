-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "department" (
    "department_id" VARCHAR   NOT NULL,
    "name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "department_id"
     )
);

CREATE TABLE "department_manager" (
    "department_id" VARCHAR   NOT NULL,
    "employee_number" INT   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "department_employee" (
    "employee_number" INT   NOT NULL,
    "department_id" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "employees" (
    "employee_number" INT   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "employee_number"
     )
);

CREATE TABLE "salaries" (
    "employee_number" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "position" (
    "employee_umber" INT   NOT NULL,
    "position" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

ALTER TABLE "department_manager" ADD CONSTRAINT "fk_department_manager_department_id" FOREIGN KEY("department_id")
REFERENCES "department" ("department_id");

ALTER TABLE "department_manager" ADD CONSTRAINT "fk_department_manager_employee_number" FOREIGN KEY("employee_number")
REFERENCES "employees" ("employee_number");

ALTER TABLE "department_employee" ADD CONSTRAINT "fk_department_employee_employee_number" FOREIGN KEY("employee_number")
REFERENCES "employees" ("employee_number");

ALTER TABLE "department_employee" ADD CONSTRAINT "fk_department_employee_department_id" FOREIGN KEY("department_id")
REFERENCES "department" ("department_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_employee_number" FOREIGN KEY("employee_number")
REFERENCES "employees" ("employee_number");

ALTER TABLE "position" ADD CONSTRAINT "fk_position_employee_umber" FOREIGN KEY("employee_umber")
REFERENCES "employees" ("employee_number");

-- List the following details of each employee:
-- employee number, last name, first name, gender, and salary
SELECT e.employee_number, e.first_name, e.last_name, e.gender, s.salary
FROM employees AS e
JOIN salaries AS s
ON e.employee_number = s.employee_number;

-- List employees who were hired in 1986.
SELECT first_name, last_name, hire_date FROM employees
WHERE employees.hire_date LIKE '1986%';

-- List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.department_id, d.name, dm.from_date, dm.to_date, e.employee_number, e.first_name, e.last_name
FROM department_manager AS dm
JOIN department AS d
ON d.department_id = dm.department_id
JOIN employees AS e
ON dm.employee_number = e.employee_number;

-- List the department of each employee with the following information: employee number, last name, first name, 
-- and department name.
SELECT e.employee_number, e.last_name, e.first_name, d.name
FROM employees AS e
JOIN department_employee AS de
ON e.employee_number = de.employee_number
JOIN department AS d
ON de.department_id = d.department_id;

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, 
-- and department name.
SELECT e.employee_number, e.first_name, e.last_name, d.name 
FROM employees AS e
JOIN department_employee AS de
ON e.employee_number = de.employee_number
JOIN department AS d
ON de.department_id = d.department_id
WHERE name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, 
-- first name, and department name.
SELECT e.employee_number, e.first_name, e.last_name, d.name 
FROM employees AS e
JOIN department_employee AS de
ON e.employee_number = de.employee_number
JOIN department AS d
ON de.department_id = d.department_id
WHERE name = 'Sales' OR name = 'Development';

-- In descending order, list the frequency count of employee last names, i.e., 
-- how many employees share each last name.
SELECT 
	last_name,
	COUNT(last_name)
FROM employees
GROUP BY(last_name)
ORDER BY COUNT(last_name) DESC;

