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
limit 100;

-- No.of transaction in the rerail sales data 
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
    
-- Data Exploration

-- How many sales we have?

SELECT count(*) as Total_Sales from retail_sales;

-- how many unique customers we have?

select count(distinct customer_id) as total_customers from retail_sales;

-- unique category we have?

select distinct category as unique_category from retail_sales;


-- Data Analysis & Business Key Problems & Answers

-- 1. All the sales made on '2022-11-05'

select * 
from retail_sales
where sale_date = '2022-11-05';

select count(*) 
from retail_sales
where sale_date = '2022-11-05';

-- 2. All the transactions where category is 'clothing' and quantity is more then equal to 3 in the month of nov-2022

select * 
from retail_sales
where 
	category = 'Clothing'
	and
    MONTH(sale_date) = 11
    AND 
    YEAR(sale_date) = 2022
    AND 
    quantity>=3;
    
    
-- 3. Total Sales for each Category.

select 
	category,
	sum(total_sale) as net_sale,
	count(*) as Total_Orders
from retail_sales
group by category;


-- 4. The average age of customers who purchased items from the 'Beauty' category.

select 
    avg(age) as avg_age
from retail_sales
where category = 'Beauty';
    
-- All the transactions where total sales is greter then 1000.

select *
from retail_sales	
where total_sale > 1000;
    
select 
	count(*)
from retail_sales
where total_sale > 1000;


-- The Total no.of transactions made by each gender in each category.

select 
	category,
	gender,
	count(*) as total_transaction
from retail_sales
group by 
    category,
    gender
order by category;

-- the avg sales for each month. find out best salling month in the year
select 
	year,
	month,
	avg_monthly_sales
from (
	select 
		year(sale_date) as year,
		month(sale_date) as month,
		round(avg(total_sale),2) as avg_monthly_sales,
		rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranks
	from retail_sales
	group by
		year,
		month
) as t1
where top = 1;

-- Top 5 customers based on the highest total sales

select 
	customer_id,
	sum(total_sale) as sum_total_sales
from retail_sales
group by customer_id
order by sum_total_sales desc
limit 5;


-- find the no.of customers who perchased intem from each category?

select
	category,
	count(distinct customer_id) as count_unique_customers
from retail_sales
group by category;

-- Write a sql query to create each shift and no.of orders (ex: Morning <= 12, afternoon Between 12 & 17, Evening >17)

with hourly_sale
as
(
select *,
    case
	when hour(sale_time)<12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evining'
	end as shift 
from retail_sales
)
select 
	shift,
	count(*) as Total_Orders
from hourly_sale
group by shift;
