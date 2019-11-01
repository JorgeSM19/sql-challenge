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