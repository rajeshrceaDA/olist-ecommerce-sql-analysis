/*
====================================================================
Project  : End-to-End Olist E-commerce Sales Analysis
Author   : Rajesh Kumar
Role     : Data Analyst
Database : MySQL

Module   : Sales Analysis

Description:
This file contains SQL queries to analyze sales trends,
monthly revenue, top-performing months, and payment methods.

Business Objective:
To evaluate sales performance over time and identify
key sales patterns using transactional data.

====================================================================
*/


-- ================================================================
-- Query 1 : Monthly Order Trend
-- ================================================================

/*
Business Question:
How many orders were placed each month?
*/

SELECT
    DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS Month,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM orders_new
GROUP BY Month
ORDER BY Month;

/*
Business Insight:

Order volume increased steadily throughout 2017
and reached its peak during 2018.

The lower order count in September and October 2018
is due to incomplete data in the dataset.
*/



-- ================================================================
-- Query 2 : Monthly Revenue Trend
-- ================================================================

/*
Business Question:
How did monthly revenue change over time?
*/

SELECT
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS Month,
    ROUND(SUM(op.payment_value),2) AS Revenue
FROM orders_new o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY Month
ORDER BY Month;

/*
Business Insight:

Revenue followed a steady upward trend
from 2017 through the first half of 2018.

The decline in the final months is caused
by incomplete records rather than lower sales.
*/



-- ================================================================
-- Query 3 : Top 10 Revenue Months
-- ================================================================

/*
Business Question:
Which months generated the highest revenue?
*/

SELECT
    DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS Month,
    ROUND(SUM(op.payment_value),2) AS Revenue
FROM orders_new o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY Month
ORDER BY Revenue DESC
LIMIT 10;

/*
Result:

2017-11 : 1,194,882.80 BRL
2018-04 : 1,160,785.48 BRL
2018-03 : 1,159,652.12 BRL

Business Insight:

November 2017 recorded the highest monthly revenue,
followed by April and March 2018.

These months represent the strongest
sales performance during the analysis period.
*/



-- ================================================================
-- Query 4 : Payment Method Analysis
-- ================================================================

/*
Business Question:
Which payment methods are most frequently used?
*/

SELECT
    payment_type,
    COUNT(*) AS Total_Payments,
    ROUND(SUM(payment_value),2) AS Total_Revenue
FROM order_payments
GROUP BY payment_type
ORDER BY Total_Revenue DESC;

/*
Result:

Credit Card : 76,795 Payments
Boleto      : 19,784 Payments
Voucher     : 5,775 Payments
Debit Card  : 1,529 Payments

Business Insight:

Credit Card is the most preferred payment method,
contributing the highest number of transactions
and the largest share of total revenue.
*/


/*
====================================================================

Sales Analysis Summary

• Sales increased consistently during the analysis period.
• Revenue showed strong growth throughout 2017 and 2018.
• November 2017 recorded the highest monthly revenue.
• Credit Card was the most widely used payment method.

Conclusion:

The sales trend indicates steady business growth,
supported by increasing order volume and revenue.
Credit Card remained the dominant payment option
throughout the dataset.

====================================================================
*/
