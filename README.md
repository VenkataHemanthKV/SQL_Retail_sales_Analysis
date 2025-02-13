# SQL_Retail_sales_Analysis

## Project Overview

**Project Title**:Retail Sales Anlalysis

The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

  1. **Set up a retail sales database**:Create and populate a retail sales database with the provided sales data.
  2. **Data Cleaning**: Identify and remove any records with missing or null values.
  3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
  4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup
- **Database Creation**: The project starts by creating a database named `sql_project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.


```sql
CREATE DATABASE sql_project;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY NOT NULL,
    sale_date DATE NOT NULL,	
    sale_time TIME NOT NULL,
    customer_id INT NOT NULL,	
    gender VARCHAR(45) NOT NULL,
    age INT NOT NULL,
    category VARCHAR(45) NOT NULL,
    quantity INT NOT NULL,
    price_per_unit FLOAT NOT NULL,	
    cogs FLOAT NOT NULL,
    total_sale FLOAT NOT NULL
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT * FROM retail_sales
limit 100;

SELECT 
	count(*) 
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
SELECT COUNT( DISTINCT customer_id) AS total_customers FROM retail_sales;

-- unique category we have?
SELECT DISTINCT category AS unique_category FROM retail_sales;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Retrieve all columns for sales made on '2022-11-05**:
   
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

SELECT COUNT(*) 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:

```sql
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
```

3. **Calculate the total sales for each category.**:

```sql
SELECT 
	category,
	sum(total_sale) AS net_sale,
	COUNT(*) AS Total_Orders
FROM retail_sales
GROUP BY category;
```

4. **Find the average age of customers who purchased items from the 'Beauty' category.**:

```sql
SELECT 
    AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

5. **Find all transactions where the total_sale is greater than 1000.**:

```sql
SELECT *
FROM retail_sales	
WHERE total_sale > 1000;
    
SELECT 
	COUNT(*)
FROM retail_sales
WHERE total_sale > 1000;
```

6. **Find the total number of transactions made by each gender in each category.**:

```sql
SELECT 
	category,
	gender,
	COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY 
    category,
    gender
ORDER BY category;
```

7. **Calculate the average sale for each month. Find out best selling month in each year**:

```sql
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
```

8. **Find the top 5 customers based on the highest total sales **:

```sql
SELECT 
	customer_id,
	SUM(total_sale) AS sum_total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY sum_total_sales DESC
LIMIT 5;
```

9. **Find the number of unique customers who purchased items from each category.**:

```sql
SELECT
	category,
	COUNT(DISTINCT customer_id) AS count_unique_customers
FROM retail_sales
GROUP BY category;
```

10. **Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql
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
```
## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.








