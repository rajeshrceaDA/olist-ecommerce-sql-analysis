/*
====================================================================
Project  : End-to-End Olist E-commerce Sales Analysis
Author   : Rajesh Kumar
Role     : Data Analyst
Database : MySQL

Module   : Product Analysis

Description:
This file contains SQL queries to analyze product category
performance, order contribution, and pricing trends.

Business Objective:
To identify the best-performing product categories
based on revenue, order volume, and average selling price.

====================================================================
*/


-- ================================================================
-- Query 1 : Top Product Categories by Revenue
-- ================================================================

/*
Business Question:
Which product categories generate the highest revenue?
*/

SELECT
    p.product_category_name,
    ROUND(SUM(op.payment_value),2) AS Total_Revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN order_payments op
ON oi.order_id = op.order_id
GROUP BY p.product_category_name
ORDER BY Total_Revenue DESC
LIMIT 10;

/*
Result:

cama_mesa_banho         : 1,712,553.67 BRL
beleza_saude            : 1,657,373.12 BRL
informatica_acessorios  : 1,585,330.45 BRL

Business Insight:
Home & Living, Beauty & Health, and IT Accessories
generated the highest revenue, indicating
strong customer demand in these categories.
*/


-- ================================================================
-- Query 2 : Top Product Categories by Orders
-- ================================================================

/*
Business Question:
Which product categories received the highest number of orders?
*/

SELECT
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) AS Total_Orders
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Total_Orders DESC
LIMIT 10;

/*
Result:

cama_mesa_banho : 9,417 Orders
beleza_saude    : 8,836 Orders
esporte_lazer   : 7,720 Orders

Business Insight:
The categories with the highest revenue
also received a high number of customer orders,
showing consistent sales performance.
*/


-- ================================================================
-- Query 3 : Highest Average Product Price by Category
-- ================================================================

/*
Business Question:
Which product categories have the highest average selling price?
*/

SELECT
    p.product_category_name,
    ROUND(AVG(oi.price),2) AS Average_Price
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Average_Price DESC
LIMIT 10;

/*
Result:

pcs                              : 1,098.34 BRL
portateis_casa_forno_e_cafe      : 624.29 BRL
eletrodomesticos_2               : 476.12 BRL

Business Insight:
Some categories have a significantly higher
average selling price, indicating
premium-priced products.
*/


/*
====================================================================

Product Analysis Summary

• Home & Living generated the highest revenue.
• Beauty & Health remained one of the best-selling categories.
• Premium product categories showed
  significantly higher average prices.
• Revenue and order volume followed
  similar category trends.

Conclusion:

Product performance is concentrated in a few
high-demand categories.
These categories contribute a major share
of both revenue and customer orders.

====================================================================
*/
