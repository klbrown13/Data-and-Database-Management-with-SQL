/*
    Name: Kurt Brown
    DTSC660: Data and Database Management with SQL
    Assignment 6
*/

--------------------------------------------------------------------------------
/*				                   Part 1   		  		                  */
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				    Chosen Data Set and Reason for Selecting		          */
--------------------------------------------------------------------------------

/* I chose the Data Science Dataset because this is a career goal of mine. 
   It's a good idea to get a look at salaries and cities in case I would need
   to relocate for a job. */

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Select Statement      		  		          */
--------------------------------------------------------------------------------

SELECT * FROM salaries;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                   Backup Table     		  		          */
--------------------------------------------------------------------------------

CREATE TABLE salaries_backup AS
SELECT * FROM salaries;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Duplicate Column      		  		          */
--------------------------------------------------------------------------------

ALTER TABLE salaries
ADD COLUMN company_duplicate VARCHAR(255);

UPDATE salaries
SET company_duplicate = company;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                   PART 2           		  		          */
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*		              Question 1 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT tag, COUNT(tag)
FROM salaries
WHERE LOWER(TRIM(tag)) IN ('na', 'n.a', 'n/a')
GROUP BY tag;

--------------------------------------------------------------------------------
/*				          Question 1 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET tag = NULL
WHERE tag IN ('N.A', 'n/a','N/A','na','Na','NA');

--------------------------------------------------------------------------------
/*				        Question 1 - Validation query                         */
--------------------------------------------------------------------------------

SELECT tag, COUNT(*) AS null_count
FROM salaries
WHERE tag is NULL
GROUP BY tag;

--------------------------------------------------------------------------------
/*				        Question 1 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* The tag column had a total of 862 NA's (in upper and lower case). 
   It is best to replace all of these with nulls to better represent missing data. (1a) */
    
--------------------------------------------------------------------------------
/*		              Question 2 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT gender, COUNT(gender) FROM salaries
GROUP BY gender;

--------------------------------------------------------------------------------
/*				          Question 2 - Update query                           */
--------------------------------------------------------------------------------

DELETE FROM salaries
WHERE gender = 'Title: Senior Software Engineer';

--------------------------------------------------------------------------------
/*				        Question 2 - Validation query                         */
--------------------------------------------------------------------------------

SELECT gender, COUNT(gender) FROM salaries
GROUP BY gender;

--------------------------------------------------------------------------------
/*				        Question 2 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* It looks like in the gender column, someone accidently typed in their job title. 
There is one Title: Senior Software Engineer.
We can't use this row, because it is not in the normal options of gender and can mess up the rest of the data. 2c */
    
--------------------------------------------------------------------------------
/*		              Question 3 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT company, COUNT(company)
FROM salaries 
WHERE company ILIKE '%jp%morgan%'
GROUP BY company;

--------------------------------------------------------------------------------
/*				          Question 3 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET company = 'JPMorganChase'
WHERE company ILIKE '%jp%morgan%';

--------------------------------------------------------------------------------
/*				        Question 3 - Validation query                         */
--------------------------------------------------------------------------------

SELECT company, Count(company) AS JPMC_Count
FROM salaries
WHERE company = 'JPMorganChase'
GROUP BY company;

--------------------------------------------------------------------------------
/*				        Question 3 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* The proper spelling and spacing that the business uses is JPMorganChase. 
This means that all other spellings and spacings need to be changed. 
There are 577 total JPMorganChase after the update. */
    
--------------------------------------------------------------------------------
/*		              Question 4 - Indentification query                      */
--------------------------------------------------------------------------------

--Run this code on line 148 first
SELECT location FROM salaries;

--Then run the code below
ALTER TABLE salaries
ADD COLUMN city text,
ADD COLUMN state text;

--------------------------------------------------------------------------------
/*				          Question 4 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET city = SPLIT_PART(location, ',', 1),
state = TRIM(SPLIT_PART(location, ',', 2));

--------------------------------------------------------------------------------
/*				        Question 4 - Validation query                         */
--------------------------------------------------------------------------------

SELECT city, state FROM salaries;

--------------------------------------------------------------------------------
/*				        Question 4 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* Seperating city and state helps with filtering and grouping. 
It's also easier if you want to go further with the data such as visualizing the data. */

--------------------------------------------------------------------------------
