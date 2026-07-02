/*
====================================================================
Project  : End-to-End Olist E-commerce Sales Analysis
Author   : Rajesh Kumar
Role     : Data Analyst
Database : MySQL

Module   : Sales Analysis

Description:
This file contains SQL queries to analyze sales performance,
order fulfillment, payment methods, and delivery efficiency.

Business Objective:
To understand sales operations, identify top-performing
sales periods, evaluate payment preferences,
and measure delivery performance.

====================================================================
*/


-- ================================================================
-- Query 1 : Top 10 Revenue Months
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

November 2017 generated the highest revenue,
followed by April and March 2018,
indicating strong sales performance during these months.
*/



-- ================================================================
-- Query 2 : Payment Method Analysis
-- ================================================================

/*
Business Question:
Which payment methods are used most frequently?
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

Credit Card is the most commonly used payment method
and contributes the largest share of total revenue.
*/



-- ================================================================
-- Query 3 : Order Status Analysis
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

Most orders were successfully delivered,
while only a small percentage remained
in processing, canceled, or unavailable status.
*/



-- ================================================================
-- Query 4 : Average Delivery Time
-- ================================================================

/*
Business Question:
What is the average number of days required
to deliver an order?
*/

SELECT
ROUND(
AVG(
DATEDIFF(
order_delivered_customer_date,
order_purchase_timestamp
)
),2) AS Avg_Delivery_Days
FROM orders_new
WHERE order_delivered_customer_date IS NOT NULL;

/*
Run this query and update the result.

Business Insight:

The average delivery time helps evaluate
overall logistics performance and customer service efficiency.
*/



/*
====================================================================

Sales Analysis Summary

• November 2017 recorded the highest monthly revenue.
• Credit Card was the most preferred payment method.
• Most customer orders were successfully delivered.
• Delivery time is an important indicator
  of logistics performance.

Conclusion:

Sales performance remained strong throughout the analysis period,
supported by successful order fulfillment and
a high share of Credit Card transactions.

====================================================================
*/

