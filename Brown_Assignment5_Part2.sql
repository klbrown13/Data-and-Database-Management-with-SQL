/*
    Name: Kurt Brown
    DTSC660: Data and Database Managment with SQL
    Assignment 5 - PART 2
*/

--------------------------------------------------------------------------------
/*				                 Query 8            		  		          */
--------------------------------------------------------------------------------

SELECT course_id 
FROM course
EXCEPT 
SELECT course_id 
FROM prereq
ORDER BY course_id;

--------------------------------------------------------------------------------
/*				                  Query 9           		  		          */
--------------------------------------------------------------------------------

SELECT dept_name 
FROM department
INTERSECT
SELECT dept_name 
FROM instructor
ORDER BY dept_name;

--------------------------------------------------------------------------------
/*				                  Query 10           		  		          */
--------------------------------------------------------------------------------
   
SELECT dept_name 
FROM department
WHERE budget < 50000
UNION
SELECT dept_name FROM department
WHERE dept_name IN (
	SELECT DISTINCT dept_name
	FROM instructor
	WHERE salary > 100000
)
UNION
SELECT dept_name 
FROM department
WHERE dept_name IN (
	SELECT DISTINCT dept_name FROM student
	WHERE tot_cred = (
		SELECT MAX(tot_cred) FROM student))
ORDER BY dept_name;
   
--------------------------------------------------------------------------------
/*				                  Query 11           		  		          */
--------------------------------------------------------------------------------

SELECT c.course_id, c.title AS course_name, c2.course_id AS prereq_id, c2.title AS prereq_name 
FROM course c
JOIN prereq pr ON c.course_id = pr.course_id
JOIN course c2 ON pr.prereq_id = c2.course_id
ORDER BY c.course_id, c2.course_id;

--------------------------------------------------------------------------------
/*				                  Query 12           		  		          */
--------------------------------------------------------------------------------

SELECT st.ID 
FROM student st
LEFT OUTER JOIN takes t ON st.ID = t.ID
WHERE t.course_id IS NULL;
    



  