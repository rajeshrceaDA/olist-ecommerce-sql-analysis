/*
====================================================================
Project  : End-to-End Olist E-commerce Sales Analysis
Author   : Rajesh Kumar
Role     : Data Analyst
Database : MySQL

Module   : Data Cleaning

Description:
This file contains SQL queries used to validate and clean
the Olist E-commerce dataset before business analysis.

====================================================================
*/

/*====================================================================
Query 1 : Check Duplicate Customers

Business Question:
Does the customers table contain duplicate customer IDs?

Purpose:
To ensure every customer is uniquely identified.
====================================================================*/

SELECT
customer_id,
COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

/*
Result:
No duplicate customer_id found.

Business Insight:
The customers table maintains unique customer records.
*/


