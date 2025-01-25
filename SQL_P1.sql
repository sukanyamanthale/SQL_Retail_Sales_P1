-- SQL Retail Sales Analysis

-- Create Table
DROP TABLE IF EXISTS Retail_Sales;
create table Retail_Sales
        (
         transactions_id INT PRIMARY KEY, 
         sale_date DATE,
         sale_time TIME,
         customer_id INT,
         gender	VARCHAR(15),
         age INT,
         category VARCHAR(25),
         quantity INT,
         price_per_unit FLOAT,
         cogs FLOAT,
         total_sale FLOAT
        );


Select * from Retail_Sales
ORDER BY transactions_id ASC LIMIT 10;

-- Data Cleaning 

select count(*)from Retail_Sales;


select * from Retail_Sales
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 age is null
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



delete from Retail_Sales
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 age is null
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


select count(*) from Retail_Sales;


-- Data Exploration

-- How many Sales we have?
select Count(*) as total_sale from Retail_sales;

-- How Many unique Customers we have ?
select count(distinct customer_id)as  total_customers from Retail_sales;

--How many unique category we have in table ?
select distinct category from Retail_sales;





-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from Retail_sales
limit 10;

select * from Retail_sales
where sale_date = '2022-11-05';





--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 10 in the month of Nov-2022

Select
* 
from Retail_sales
where
     category = 'Clothing'
	 and quantity>=4
     and TO_CHAR(sale_date , 'yyyy-mm') = '2022-11';





-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.


select category , sum(total_sale) as Total_sales from retail_sales
group by category





-- Q.4 Write a SQL query to find the average age of
-- customers who purchased items from the 'Beauty' category.


select ROUND(AVG(age),2) as Avg_age from retail_sales
where category = 'Beauty' ;





-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

Select * from retail_sales
where total_sale> 1000;





-- Q.6 Write a SQL query to find the total number of transactions (transaction_id)
-- made by each gender in each category.


select gender,category, Count(*)as total_transactions from retail_sales
group by gender,category 
order by category;




-- Q.7 Write a SQL query to calculate the average sale for each month. 
-- Find out best selling month in each year

Select * from retail_sales
limit 5 ;

select year,month,avg_sale
from(
select 
      extract(year from sale_date)as year,
	  extract(month from sale_date)as month,
	  avg(total_sale)as avg_sale,
	  rank()over(partition by extract(year from sale_date)order by avg(total_sale)desc) as Rank
	  from retail_sales
group by 1,2) t1
where Rank =1





-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

Select * from retail_sales
limit 5 ;

select customer_id ,sum(total_sale)as total_sales from retail_sales
group by customer_id
order by total_sales desc
limit 5; 





-- Q.9 Write a SQL query to find the number of unique customers
--who purchased items from each category.

Select * from retail_sales
limit 5 ;

select count(distinct(customer_id))as Dis_customer,category from retail_sales
group by category





-- Q.10 Write a SQL query to create each shift and number
--of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with cte
as
(
select *,
     case
	   when extract(hour from sale_time) <=12 then 'Morning'
	   when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	   else 'Evening'
     end as Shift
from retail_sales
)
select shift,count(*)as total_orders
from cte
group by Shift;




--END
















































	 
	 

