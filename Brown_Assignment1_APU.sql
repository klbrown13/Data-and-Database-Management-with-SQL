--------------------------------------------------------------------------------
/*				                 Create Database         	 		          */
--------------------------------------------------------------------------------

CREATE DATABASE auto_parts_unlimited;

--------------------------------------------------------------------------------
/*				             Connect to Database        		  	          */
--------------------------------------------------------------------------------

-- **DO NOT DELETE OR ALTER THE CODE BELOW!**
-- **THIS IS NEEDED FOR CODEGRADE TO RUN YOUR ASSIGNMENT**

\connect auto_parts_unlimited;

--------------------------------------------------------------------------------
/*				          Create Table Statements              	    	      */
--------------------------------------------------------------------------------

CREATE TABLE customers(
cust_id bigserial,
first_name varchar(25),
last_name varchar(50),
phone_number char(14),
email varchar(255),
street_address varchar(255),
city varchar(25),
zip char(5),
state char(2)
);

CREATE TABLE employees(
employee_id bigserial,
first_name varchar(25),
last_name varchar(50),
phone_number char(14),
email varchar(50),
street_address varchar(255),
city varchar(25),
zip char(5),
state char(2),
hire_date date,
salary numeric(12,2), 
probation boolean
);

CREATE TABLE parts_inventory(
part_number varchar(50),
manufacturer varchar(255),
quantity integer,
price numeric(12, 2)
);

