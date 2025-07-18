create database KMS_DB


-------TABLE
create table orders (
row_id INT,
order_id VARCHAR (20),
order_date DATE,
ship_date DATE,
order_priority VARCHAR (20),
order_quantity INT,
sales DECIMAL (10,2),
discount DECIMAL (5, 2),
ship_mode VARCHAR (50),
profit DECIMAL (10,2),
unit_price DECIMAL (10,2),
shipping_cost DECIMAL (10,2),
customer_name VARCHAR (100),
province VARCHAR (50),
region VARCHAR (50),
customer_segment VARCHAR (50),
product_category VARCHAR (50),
product_sub_category VARCHAR (50),
product_name VARCHAR (100),
product_container VARCHAR (50),
product_base_margin DECIMAL (5,2)
);

SELECT * FROM ORDERS

 
------IMPORT CSV FILES INTO DB------
----KMS.CSV


---------SELECT * FROM KMS------

-----------SELECT * FROM Order_status

-------join-----
SELECT KMS.order_id,
	   KMS.order_quantity,
	   KMS.customer_name,
	   KMS.customer_segment,
	   order_status.order_id,
	   order_status.status
FROM KMS
join order_status
on order_status.order_id = KMS.order_id

 
 -------- Which product category had the highest sales? ------
 
 SELECT
     product_category,
	 SUM (sales) AS total_sales
FROM
    KMS
GROUP BY
    product_category
ORDER BY
    total_sales DESC

	---------What are the Top 3 and Bottom 3 regions in terms of sales? ----------

 SELECT
    product_category,
	SUM (sales) AS total_sales
FROM 
	KMS
GROUP BY
	product_category
ORDER BY
	total_sales ASC

SELECT
	product_category,
	SUM (sales) AS total_sales
FROM
	KMS
GROUP BY
	product_category
ORDER BY
	total_sales DESC
	
 ---------   What were the total sales of appliances in Ontario? -----------

 SELECT
	SUM (sales) AS total_appliances_sales
FROM
	KMS
WHERE
	product_sub_category = 'Appliances' AND province = 'Ontario';


--------Advise the management of KMS on what to do to increase the revenue from the bottom 
10 customers -------------

SELECT 
	customer_name,
	SUM (sales) AS total_sales
FROM
	KMS
GROUP BY
	customer_name
ORDER BY
	total_sales

----recommendation------
1, Offering personalised discount or coupons they shown interest.
2, Reaching out through emails or account managers to understand their needs.
3, Conducting a short customer satisfaction survey to find obstacles.
4, Setting monthly revenue targets for thses customers.
5, Monitor progress with a dashboard and adjusting strategy

---------. KMS incurred the most shipping cost using which shipping method?------

SELECT
	ship_mode,
	SUM (shipping_cost) AS total_shipping_cost
FROM
	KMS
GROUP BY
	ship_mode
ORDER BY
	total_shipping_cost DESC

-------Who are the most valuable customers, and what products or services do they typically 
purchase? --------


SELECT
	customer_name,
	SUM (sales) AS total_sales
FROM
	KMS
GROUP BY
	customer_name
ORDER BY
	total_sales DESC

--------To get their preferred products-------

SELECT
	product_name, 
	SUM(sales) AS total_sales
FROM 
	KMS
WHERE
	customer_name = 'most valuable customer name'
GROUP BY
	product_name
ORDER BY
	total_sales DESC


--------- Which small business customer had the highest sales?---------

SELECT
	customer_name,
	SUM (sales) AS total_sales
FROM
	KMS
WHERE
	customer_segment = 'small business'
GROUP BY
	customer_name
ORDER BY
	total_sales DESC

------ Which Corporate Customer placed the most number of orders in 2009 – 2012? ----------

SELECT
	customer_name,
	COUNT ([order_id]) AS number_of_orders
FROM
	KMS
WHERE
	customer_segment = 'corporate'
	AND YEAR([order_date]) BETWEEN 2009 AND 2012
GROUP BY
	customer_name
ORDER BY
	number_of_orders DESC

-------- Which consumer customer was the most profitable one? ---------

SELECT
	customer_name,
	SUM (profit) AS total_profit
FROM
	KMS
GROUP BY
	customer_name
ORDER BY
	total_profit DESC

----------- Which customer returned items, and what segment do they belong to? ------

SELECT DISTINCT customer_name, 
		customer_segment
FROM
	KMS
WHERE 
order_status = 'Returned';

------If the delivery truck is the most economical but the slowest shipping method and 
Express Air is the fastest but the most expensive one, do you think the company 
appropriately spent shipping costs based on the Order Priority?---------

SELECT
	Order_priority, Ship_mode, COUNT(*) AS Num_Orders
FROM 
	KMS
GROUP BY 
	Order_priority, ship_mode,
ORDER BY
	Order_Priority, NUM_Orders DESC;