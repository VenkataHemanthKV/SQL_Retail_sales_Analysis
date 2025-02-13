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
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;

-- unique category we have?
SELECT DISTINCT category AS unique_category FROM retail_sales;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. 
