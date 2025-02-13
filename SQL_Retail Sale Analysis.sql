-- Creating Retail Sales Analysis DataBase
CREATE DATABASE sql_project;

-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY NOT NULL,	
                sale_date DATE NOT NULL,	 
                sale_time TIME NOT NULL,	
                customer_id	INT NOT NULL,
                gender	VARCHAR(45) NOT NULL,
                age	INT NOT NULL,
                category VARCHAR(45) NOT NULL,	
                quantity	INT NOT NULL,
                price_per_unit FLOAT NOT NULL,	
                cogs	FLOAT NOT NULL,
                total_sale FLOAT NOT NULL
	);

-- Import the data form the excel file
-- Top 100 rows
SELECT * FROM retail_sales
LIMIT 100;

-- No.of transaction in the rerail sales data 
SELECT 
	COUNT(*) 
FROM retail_sales;

-- Data Cleaning

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Data Exploration

-- How many sales we have?

SELECT COUNT(*) AS Total_Sales FROM retail_sales;

-- how many unique customers we have?

SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;

-- unique category we have?

SELECT DISTINCT category AS unique_category FROM retail_sales;


-- Data Analysis & Business Key Problems & Answers

-- 1. All the sales made on '2022-11-05'

SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

SELECT COUNT(*) 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. All the transactions where category is 'clothing' and quantity is more then equal to 3 in the month of nov-2022

SELECT * 
FROM retail_sales
WHERE 
	category = 'Clothing'
	AND
	MONTH(sale_date) = 11
	AND 
	YEAR(sale_date) = 2022
	AND 
	quantity>=3;
    
    
-- 3. Total Sales for each Category.

SELECT 
	category,
	sum(total_sale) AS net_sale,
	COUNT(*) AS Total_Orders
FROM retail_sales
GROUP BY category;


-- 4. The average age of customers who purchased items from the 'Beauty' category.

SELECT 
    AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
    
-- All the transactions where total sales is greter then 1000.

SELECT *
FROM retail_sales	
WHERE total_sale > 1000;
    
SELECT 
	COUNT(*)
FROM retail_sales
WHERE total_sale > 1000;


-- The Total no.of transactions made by each gender in each category.

SELECT 
	category,
	gender,
	COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY 
    category,
    gender
ORDER BY category;

-- the avg sales for each month. find out best salling month in the year
SELECT 
	year,
	month,
	avg_monthly_sales
FROM (
	SELECT 
		YEAR(sale_date) AS year,
		MONTH(sale_date) AS month,
		ROUND(AVG(total_sale),2) AS avg_monthly_sales,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranks
	FROM retail_sales
	GROUP BY
		year,
		month
) AS t1
WHERE top = 1;

-- Top 5 customers based on the highest total sales

SELECT 
	customer_id,
	SUM(total_sale) AS sum_total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY sum_total_sales DESC
LIMIT 5;


-- find the no.of customers who perchased intem from each category?

SELECT
	category,
	COUNT(DISTINCT customer_id) AS count_unique_customers
FROM retail_sales
GROUP BY category;

-- Write a sql query to create each shift and no.of orders (ex: Morning <= 12, afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
	WHEN HOUR(sale_time)<12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evining'
	END AS shift 
FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) AS Total_Orders
FROM hourly_sale
GROUP BY shift;
