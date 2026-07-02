/*
====================================================================
Project  : End-to-End Olist E-commerce Sales Analysis
Author   : Rajesh Kumar
Role     : Data Analyst
Database : MySQL

Module   : Exploratory Data Analysis (EDA)

Description:
This file contains SQL queries used to understand the
structure, coverage, and distribution of the dataset
before performing business analysis.

Business Objective:
To explore the Olist dataset by analyzing its size,
time period, geographical coverage, product coverage,
and order status distribution.

====================================================================
*/


-- ================================================================
-- Query 1 : Dataset Overview
-- ================================================================

/*
Business Question:
What is the overall size of the Olist e-commerce dataset?
*/

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
Total Customers : 99,441
Total Sellers   : 3,095
Total Products  : 32,340
Total Orders    : 99,441

Business Insight:
The dataset contains more than 99K orders, 32K products,
and over 3K sellers, making it suitable for
large-scale e-commerce analysis.
*/


-- ================================================================
-- Query 2 : Dataset Time Range
-- ================================================================

/*
Business Question:
What is the available transaction period in the dataset?
*/

SELECT
MIN(order_purchase_timestamp) AS First_Order,
MAX(order_purchase_timestamp) AS Last_Order
FROM orders_new;

/*
Result:
First Order : 2016-09-04 21:15:19
Last Order  : 2018-10-17 17:30:18

Business Insight:
The dataset covers approximately two years of
e-commerce transactions, enabling trend analysis
across different time periods.
*/


-- ================================================================
-- Query 3 : Order Status Distribution
-- ================================================================

/*
Business Question:
How are orders distributed across different order statuses?
*/

SELECT
order_status,
COUNT(*) AS Total_Orders
FROM orders_new
GROUP BY order_status
ORDER BY Total_Orders DESC;

/*
Result:

Delivered   : 96,478
Shipped     : 1,107
Canceled    : 625
Unavailable : 609
Invoiced    : 314
Processing  : 301
Created     : 5
Approved    : 2

Business Insight:
Approximately 97% of all orders were successfully delivered,
indicating a strong order fulfillment process.
Only a small percentage of orders were canceled
or remained in intermediate processing stages.
*/


-- ================================================================
-- Query 4 : Customer Geographic Coverage
-- ================================================================

/*
Business Question:
How many unique cities and states are covered
in the customer dataset?
*/

SELECT
COUNT(DISTINCT customer_city) AS Total_Cities,
COUNT(DISTINCT customer_state) AS Total_States
FROM customers;

/*
Result:
Total Cities : 4,119
Total States : 27

Business Insight:
Customers are distributed across 4,119 cities
and all 27 Brazilian states,
providing nationwide geographical coverage
for business analysis.
*/


-- ================================================================
-- Query 5 : Product Category Coverage
-- ================================================================

/*
Business Question:
How many unique product categories are available?
*/

SELECT
COUNT(DISTINCT product_category_name) AS Total_Product_Categories
FROM products;

/*
Result:
Total Product Categories : 73

Business Insight:
The marketplace offers products across 73 categories,
allowing detailed category-wise sales and performance analysis.
*/


/*
====================================================================

EDA Summary

• Dataset contains 99,441 orders and customers.
• Products belong to 73 unique categories.
• Customers are spread across 4,119 cities and 27 states.
• Dataset covers transactions from September 2016 to October 2018.
• Around 97% of all orders were successfully delivered.

Conclusion:
The dataset is comprehensive, geographically diverse,
and sufficiently clean for advanced business analysis
and dashboard development.

====================================================================
*/
