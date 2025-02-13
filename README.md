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
where 
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    category is null
    or
    quantity is null
    or
    price_per_unit is null
    or 
    cogs is null
    or
    total_sale is null;

DELETE FROM retail_sales
WHERE 
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    category is null
    or
    quantity is null
    or
    price_per_unit is null
    or 
    cogs is null
    or
    total_sale is null;
```
