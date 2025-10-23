/*
    Name: Kurt Brown
    DTSC660: Data and Database Managment with SQL
    Assignment 7
*/

--------------------------------------------------------------------------------
/*				                 Query 1          		  		          */
--------------------------------------------------------------------------------

WITH dept_salaries AS (
	SELECT dp.department_id, dp.department_name,
	SUM(e.salary) AS total_salary 
	FROM departments dp
	JOIN employees e ON dp.department_id = e.department_id
	GROUP BY dp.department_id, dp.department_name
),

avg_salary AS (
	SELECT AVG(total_salary) AS avg_dept_salary
	FROM dept_salaries
)

SELECT d.department_name, d.total_salary
FROM dept_salaries d
CROSS JOIN avg_salary av
WHERE d.total_salary > av.avg_dept_salary;
--------------------------------------------------------------------------------
/*				                  Query 2           		  		          */
--------------------------------------------------------------------------------

WITH max_hours AS (
	SELECT project_id, 
	MAX(hours_worked) AS max_worked
	FROM employee_projects
	GROUP BY project_id
)

SELECT pr.project_name, mw.max_worked AS max_hours_worked, n.name AS employee
FROM max_hours mw
JOIN employee_projects ep
ON mw.project_id = ep.project_id AND mw.max_worked = ep.hours_worked
JOIN employees n ON ep.employee_id = n.employee_id
JOIN projects pr ON ep.project_id = pr.project_id;

--------------------------------------------------------------------------------
/*				                  Query 3           		  		          */
--------------------------------------------------------------------------------

WITH manager_id_cte AS (
	SELECT employee_id AS manager_id
	FROM employees
	WHERE name = 'Alex Johnson'
)

SELECT mn.name AS manager_name, en.name AS employee_name
FROM employees en
JOIN manager_id_cte mcte ON en.manager_id = mcte.manager_id
JOIN employees mn ON en.manager_id = mn.employee_id;
   
--------------------------------------------------------------------------------
/*				                  Query 4           		  		          */
--------------------------------------------------------------------------------

WITH emp_proj_counts AS (
	SELECT em.employee_id, em.department_id,
	COUNT(DISTINCT emp.project_id) AS project_count
	FROM employees em
	JOIN employee_projects emp ON em.employee_id = emp.employee_id
	GROUP BY em.employee_id, em.department_id
),

qualified_employees AS (
	SELECT department_id,
	COUNT(*) AS qualified_employee_count
	FROM emp_proj_counts
	WHERE project_count >= 2
	GROUP BY department_id
)
SELECT d.department_name, qe.qualified_employee_count
FROM qualified_employees qe
JOIN departments d ON qe.department_id = d.department_id
WHERE qe.qualified_employee_count >= 3;

--------------------------------------------------------------------------------
/*				                  Query 5           		  		          */
--------------------------------------------------------------------------------

WITH salary_diff AS (
	SELECT emp.name AS employee_name, 
	emp.salary AS employee_salary,
	mn.name AS manager_name, 
	mn.salary AS manager_salary,
	emp.salary - mn.salary AS salary_difference
	FROM employees emp
	JOIN employees mn ON emp.manager_id = mn.employee_id
)
SELECT *
FROM salary_diff
WHERE manager_salary > 100000;
	
    
