USE [Pizza DB]
-- Previewing the Data Set --
SELECT TOP 20 *
FROM pizza_sales;

-- Total Revenue --
SELECT SUM(total_price) as total_revenue
FROM pizza_sales;

-- Average Order Value --
SELECT CAST((SUM(total_price)/COUNT(DISTINCT order_id)) AS DECIMAL (10,2)) as avg_order_value
FROM pizza_sales;

-- Total Pizzas Sold --
SELECT SUM(quantity) as total_pizzas_sold
FROM pizza_sales;

-- Total Orders --
SELECT COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales;

-- Average Pizzas Per Order --
SELECT CAST(
	CAST(SUM(quantity) AS DECIMAL (10, 2))/
	CAST(COUNT(DISTINCT order_id) AS DECIMAL (10, 2))
	AS DECIMAL (10,2)) as avg_pizzas_per_order
FROM pizza_sales;

-- Hourly Trend for Total Orders --
SELECT DATEPART(HOUR, order_time) as hour_ordered, SUM(quantity) as pizzas_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);

-- Weekly Trend for Total Orders --
SELECT
	DATEPART(ISO_WEEK, order_date) as week_number,
	YEAR(order_date) as Year,
	COUNT(DISTINCT order_id) as total_orders
FROM
	pizza_sales
GROUP BY
	DATEPART(ISO_WEEK, order_date),
	YEAR(order_date)
ORDER BY
	Year, week_number;

-- Weekly Trend for Total Orders --
SELECT
	pizza_category,
	CAST(SUM(total_price) AS DECIMAL (10, 2)) AS total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10, 2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- Percentage of Sales by Pizza Size --
SELECT
	pizza_size,
	CAST(SUM(total_price) AS DECIMAL (10, 2)) AS total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10, 2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- Total Pizzas Sold by Pizza Category --
SELECT
	pizza_category,
	SUM(quantity) AS pizzas_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY pizzas_sold DESC;

-- Top 5 Sellers by Revenue --
SELECT TOP 5
	pizza_name,
	SUM(total_price) as total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;

-- Top 5 Sellers by Total Quantity --
SELECT TOP 5
	pizza_name,
	SUM(quantity) as total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC;

-- Top 5 Sellers by Total Orders --
SELECT TOP 5
	pizza_name,
	COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC;

-- Bottom 5 Sellers by Revenue --
SELECT TOP 5
	pizza_name,
	CAST(SUM(total_price) AS DECIMAL (10, 2)) as total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC;

-- Bottom 5 Sellers by Total Quantity --
SELECT TOP 5
	pizza_name,
	SUM(quantity) as total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold ASC;

-- Bottom 5 Sellers by Total Orders --
SELECT TOP 5
	pizza_name,
	COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC;
