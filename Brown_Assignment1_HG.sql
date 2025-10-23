--------------------------------------------------------------------------------
/*				                 Create Database         	 		          */
--------------------------------------------------------------------------------

CREATE DATABASE holy_grounds;

--------------------------------------------------------------------------------
/*				             Connect to Database        		  	          */
--------------------------------------------------------------------------------

-- **DO NOT DELETE OR ALTER THE CODE BELOW!**
-- **THIS IS NEEDED FOR CODEGRADE TO RUN YOUR ASSIGNMENT**

\connect holy_grounds;

--------------------------------------------------------------------------------
/*				          Create Table Statements              	    	      */
--------------------------------------------------------------------------------

CREATE TABLE coffee_inventory(
sku varchar(50),
name varchar(50),
roast_type varchar(15),
lbs_on_hand numeric(12, 2),
organic boolean,
price_per_lb numeric(12, 2)
);

CREATE TABLE sales_transactions(
receipt_id bigserial,
sale_amount numeric(12, 2),
sale_type varchar(10),
transaction_date timestamp
);

CREATE TABLE stores(
store_id bigserial,
store_manager varchar(255),
store_phone char(14),
store_address varchar(255),
city varchar(25),
zip char(5),
state char(2)
);
