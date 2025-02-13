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
