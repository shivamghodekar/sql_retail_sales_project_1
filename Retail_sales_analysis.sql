-- SQL Retail sales analysis

-- CREATE TABLE

CREATE TABLE retail_sales (
transactions_id INT PRIMARY KEY,	
sale_date DATE,	
sale_time TIME,
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category VARCHAR(15),	
quantiy INT,	
price_per_unit FLOAT,
cogs FLOAT,	
total_sale FLOAT
);


SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT(*) FROM retail_sales

-- To check the null values in your dataset

SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE customer_id IS NULL

SELECT * FROM retail_sales
WHERE gender IS NULL

SELECT * FROM retail_sales
WHERE age IS NULL

SELECT * FROM retail_sales
WHERE 
      category IS NULL
	  OR
	  quantiy IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;

-- Data cleaning - DELETE THE ALL NULL ROWS 

DELETE FROM retail_sales
WHERE 
      category IS NULL
	  OR
	  quantiy IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;

DELETE FROM retail_sales
WHERE age IS NULL

-- Data exploaration

-- How many sales we have?

SELECT COUNT(*) AS total_sale FROM retail_sales

-- How many unique customer we have

SELECT COUNT(DISTINCT customer_id) AS total_sale 
FROM retail_sales

-- How many categary we have

SELECT DISTINCT category
FROM retail_sales

-- Data analysis & Business key problem & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 10 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing' 
AND TO_CHAR(sale_date, 'yyyy-mm') = '2022-11'
AND quantiy >=4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, sum(total_sale) as total_sales
FROM retail_sales
GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT Category, ROUND(AVG(age),0) as average_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category, gender, COUNT(transactions_id) as total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT EXTRACT (YEAR FROM sale_date ) AS year, 
       EXTRACT (MONTH FROM sale_date ) AS month,
	   AVG(total_sale) AS avg_sales
FROM retail_sales
GROUP BY 1,2
ORDER BY avg_sales DESC
LIMIT 2

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id, 
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH Hourly_sales
AS
(
SELECT *,
    CASE
	   WHEN EXTRACT( HOUR FROM sale_time ) < 12 THEN 'morning'
	   WHEN EXTRACT( HOUR FROM sale_time ) BETWEEN 12 AND 17 THEN 'afternoon'
	   ELSE 'evening'
	END AS shift   	   
FROM retail_sales
)
SELECT shift, count(*) AS total_orders
FROM Hourly_sales
GROUP BY shift

-- End of project





















































