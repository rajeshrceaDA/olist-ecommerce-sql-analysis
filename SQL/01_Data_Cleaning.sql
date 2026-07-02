/*
====================================================================
Project  : End-to-End Olist E-commerce Sales Analysis
Author   : Rajesh Kumar
Role     : Data Analyst
Database : MySQL

Module   : Data Cleaning

Description:
This file contains SQL queries used to validate data quality
before performing business analysis.

====================================================================
*/

-- ================================================================
-- Query 1 : Check Duplicate Customers
-- ================================================================

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

/*
Result:
No duplicate customer IDs found.

Business Insight:
Customer records are unique.
*/


-- ================================================================
-- Query 2 : Check Duplicate Orders
-- ================================================================

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders_new
GROUP BY order_id
HAVING COUNT(*) > 1;

/*
Result:
No duplicate order IDs found.

Business Insight:
Each order is uniquely stored.
*/


-- ================================================================
-- Query 3 : Check Missing Product References
-- ================================================================

SELECT
COUNT(DISTINCT oi.product_id) AS Missing_Products
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

/*
Result:
611 product IDs are missing.

Business Insight:
Some products exist in order_items but not in products.
*/


-- ================================================================
-- Query 4 : Check NULL Values
-- ================================================================

SELECT
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS Null_Customers,
SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS Null_Status,
SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS Null_Purchase_Date
FROM orders_new;

/*
Result:
No NULL values found.

Business Insight:
Important business columns are complete.
*/


-- ================================================================
-- Query 5 : Check Invalid Delivery Timeline
-- ================================================================

SELECT COUNT(*) AS Invalid_Orders
FROM orders_new
WHERE order_delivered_customer_date < order_purchase_timestamp;

/*
Result:
2965 invalid records found.

Business Insight:
These records should be excluded while calculating delivery KPIs.
*/


