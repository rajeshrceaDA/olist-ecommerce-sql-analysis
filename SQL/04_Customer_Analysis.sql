/*
====================================================================
Project  : End-to-End Olist E-commerce Sales Analysis
Author   : Rajesh Kumar
Role     : Data Analyst
Database : MySQL

Module   : Customer Analysis

Description:
This file contains SQL queries to analyze customer distribution,
revenue contribution, customer spending, and monthly customer growth.

Business Objective:
To understand customer behavior, identify high-value regions,
and analyze customer purchasing patterns.

====================================================================
*/


-- ================================================================
-- Query 1 : Customer Distribution by State
-- ================================================================

/*
Business Question:
Which states have the highest number of customers?
*/

SELECT
    customer_state,
    COUNT(DISTINCT customer_id) AS Total_Customers
FROM customers
GROUP BY customer_state
ORDER BY Total_Customers DESC;

/*
Result:

SP : 41,746
RJ : 12,852
MG : 11,635
RS : 5,466
PR : 5,045

Business Insight:
São Paulo (SP) has the highest number of customers,
followed by Rio de Janeiro (RJ) and Minas Gerais (MG).
Most customers are concentrated in a few major states.
*/



-- ================================================================
-- Query 2 : Top States by Revenue
-- ================================================================

/*
Business Question:
Which states generate the highest revenue?
*/

SELECT
    c.customer_state,
    ROUND(SUM(op.payment_value),2) AS Total_Revenue
FROM customers c
JOIN orders_new o
ON c.customer_id = o.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_state
ORDER BY Total_Revenue DESC
LIMIT 10;

/*
Result:

SP : 5,998,226.96 BRL
RJ : 2,144,379.69 BRL
MG : 1,872,257.26 BRL

Business Insight:
São Paulo generated the highest revenue,
followed by Rio de Janeiro and Minas Gerais.
The states with the largest customer base also
generated the highest revenue.
*/



-- ================================================================
-- Query 3 : Top 10 Customers by Spending
-- ================================================================

/*
Business Question:
Who are the top spending customers?
*/

SELECT
    o.customer_id,
    ROUND(SUM(op.payment_value),2) AS Total_Spending
FROM orders_new o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY o.customer_id
ORDER BY Total_Spending DESC
LIMIT 10;

/*
Result:

Highest Customer Spending : 13,664.08 BRL

Business Insight:
A small number of customers spent significantly
more than the average customer, indicating
the presence of high-value customers.
*/



-- ================================================================
-- Query 4 : Monthly Customer Acquisition
-- ================================================================

/*
Business Question:
How many customers placed orders each month?
*/

SELECT
    DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS Month,
    COUNT(DISTINCT customer_id) AS Total_Customers
FROM orders_new
GROUP BY Month
ORDER BY Month;

/*
Business Insight:

The number of customers increased steadily
throughout 2017 and early 2018, showing
continuous business growth.

The lower customer count in September and October 2018
is due to incomplete data available in the dataset.
*/



/*
====================================================================

Customer Analysis Summary

• São Paulo (SP) has the highest number of customers.
• São Paulo also contributes the highest revenue.
• A small group of customers contributes significantly
  higher spending than the average customer.
• Customer growth remained consistent during
  the analysis period.

Conclusion:

Customer activity is concentrated in a few major states,
especially São Paulo, Rio de Janeiro, and Minas Gerais.
The analysis also shows stable customer growth and
consistent purchasing behavior throughout the dataset.

====================================================================
*/
