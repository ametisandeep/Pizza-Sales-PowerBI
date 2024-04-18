SELECT * FROM pizza_sales

--Total Revenue of all Pizza Orders

SELECT ROUND(SUM(total_price),0) AS total_revenue
FROM pizza_sales

--Average Order Value

WITH cte_aov AS (
SELECT order_id, SUM(total_price) AS total_price
FROM pizza_sales
GROUP BY order_id
)
SELECT ROUND(SUM(total_price)/COUNT(order_id),2) AS average_order_Value FROM cte_aov

--Total Pizzas Sold

SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales

--Total Orders

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales

--Average Pizzas per Order

SELECT * FROM pizza_sales

WITH cte_appo AS (
SELECT order_id, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY order_id)
SELECT CAST(CAST(SUM(total_quantity) AS DECIMAL(10,2))/
CAST(COUNT(order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS avg_pizzas_per_order FROM cte_appo

--Daily trend for orders

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--Monthly trend for orders

SELECT DATENAME(MONTH, order_date) AS order_month, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)

--Percentage of sales by pizza category

WITH cte_pc AS (
SELECT pizza_category, SUM(total_price) AS price_category
FROM pizza_sales
GROUP BY pizza_category)
SELECT pizza_category, ROUND(price_category * 100 / (SELECT SUM(price_category) FROM cte_pc), 2)
AS percentage_of_sales FROM cte_cpc

--Percentage of sales by pizza size

WITH cte_ps AS (
SELECT pizza_size, SUM(total_price) AS price_category
FROM pizza_sales
GROUP BY pizza_size)
SELECT pizza_size, ROUND(price_category * 100 / (SELECT SUM(price_category) FROM cte_ps), 2)
AS percentage_of_sales FROM cte_ps

--Top5 Best Sellers by Revenue

SELECT TOP 5 pizza_name, SUM(total_price) AS pizza_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_revenue DESC

--Bottom 5 Pizzas by Revenue

SELECT TOP 5 pizza_name, SUM(total_price) AS pizza_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_revenue

--Top 5 Pizzas by Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY quantity DESC

--Bottom 5 Pizzas by Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY quantity

--Top 5 Pizzas by total orders

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC

--Bottom 5 Pizzas by total_orders

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders