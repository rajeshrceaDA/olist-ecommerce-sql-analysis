/*
====================================================================
Project  : End-to-End Olist E-commerce Sales Analysis
Author   : Rajesh Kumar
Role     : Data Analyst
Database : MySQL

Module   : Exploratory Data Analysis

Description:
This file contains SQL queries used to understand the
dataset before business analysis.

====================================================================
*/

-- ================================================================
-- Query 1 : Dataset Overview
-- ================================================================

SELECT
(
SELECT COUNT(*) FROM customers
) AS Total_Customers,

(
SELECT COUNT(*) FROM sellers
) AS Total_Sellers,

(
SELECT COUNT(*) FROM products
) AS Total_Products,

(
SELECT COUNT(*) FROM orders_new
) AS Total_Orders;

/*
Result:
Customers : 99,441
Sellers   : 3,095
Products  : 32,340
Orders    : 99,441

Business Insight:
The dataset is sufficiently large for business analysis.
*/


-- ================================================================
-- Query 2 : Dataset Date Range
-- ================================================================

SELECT
MIN(order_purchase_timestamp) AS First_Order,
MAX(order_purchase_timestamp) AS Last_Order
FROM orders_new;

/*
Result:
First Order : 2016-09-04
Last Order  : 2018-10-17

Business Insight:
The dataset covers approximately two years of business operations.
*/


-- ================================================================
-- Query 3 : Order Status Distribution
-- ================================================================

SELECT
order_status,
COUNT(*) AS Total_Orders
FROM orders_new
GROUP BY order_status
ORDER BY Total_Orders DESC;

/*
Business Insight:
Most orders were successfully delivered, while only a small percentage
were canceled or unavailable.
*/
