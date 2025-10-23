/*
    Name: Kurt Brown
    DTSC660: Data and Database Managment with SQL
    Assignment 5 - PART 1
*/

--------------------------------------------------------------------------------
/*				                 Query 1            		  		          */
--------------------------------------------------------------------------------

SELECT c.cust_id, a.account_number, l.loan_number 
FROM customer c
JOIN depositor a ON c.cust_id = a.cust_id
JOIN borrower l ON c.cust_id = l.cust_id
ORDER BY c.cust_id;

--------------------------------------------------------------------------------
/*				                  Query 2           		  		          */
--------------------------------------------------------------------------------

SELECT c.cust_id, c.customer_city, b.branch_name, b.branch_city, a.account_number 
FROM customer c
JOIN depositor d ON c.cust_id = d.cust_id
JOIN account a ON d.account_number = a.account_number
JOIN branch b ON a.branch_name = b.branch_name
WHERE c.customer_city = b.branch_city;

--------------------------------------------------------------------------------
/*				                  Query 3           		  		          */
--------------------------------------------------------------------------------

SELECT c.cust_id, c.customer_name 
FROM customer c
WHERE c.cust_id IN (
	  SELECT cust_id 
	  FROM borrower
	  EXCEPT 
	  SELECT cust_id 
	  FROM depositor
	  )
ORDER BY c.cust_id;
   
--------------------------------------------------------------------------------
/*				                  Query 4           		  		          */
--------------------------------------------------------------------------------

SELECT DISTINCT b.branch_name 
FROM customer c
JOIN depositor d ON c.cust_id = d.cust_id
JOIN account a ON d.account_number = a.account_number
JOIN branch b ON a.branch_name = b.branch_name
WHERE c.customer_city = 'Harrison'
ORDER BY b.branch_name;

--------------------------------------------------------------------------------
/*				                  Query 5           		  		          */
--------------------------------------------------------------------------------

SELECT cust_id, customer_name 
FROM customer
WHERE (customer_Street, customer_city) IN (
	SELECT customer_street, customer_city
	FROM customer
	where cust_id = '12345'
)
INTERSECT
SELECT cust_id, customer_name FROM customer
WHERE cust_id <> '12345'
ORDER BY cust_id;
    
--------------------------------------------------------------------------------
/*				                  Query 6           		  		          */
--------------------------------------------------------------------------------

SELECT c.cust_id, c.customer_name 
FROM customer c
JOIN depositor d ON c.cust_id = d.cust_id
JOIN account a on d.account_number = a.account_number
JOIN branch b ON a.branch_name = b.branch_name
WHERE b.branch_city = 'Brooklyn'
GROUP BY c.cust_id, c.customer_name
HAVING COUNT(DISTINCT b.branch_name) = 
	(SELECT COUNT(*) FROM branch
	WHERE branch_city = 'Brooklyn')
ORDER BY c.cust_id;

--------------------------------------------------------------------------------
/*				                  Query 7           		  		          */
--------------------------------------------------------------------------------

SELECT l.loan_number, c.customer_name, l.branch_name 
FROM loan l
JOIN borrower b ON l.loan_number = b.loan_number
JOIN customer c ON b.cust_id = c.cust_id
WHERE l.branch_name = 'Yonkahs Bankahs'
	AND CAST(l.amount AS NUMERIC) > 
	(SELECT CAST(AVG(CAST(amount AS NUMERIC)) AS NUMERIC) 
	FROM loan
	WHERE branch_name = 'Yonkahs Bankahs');

  