# SQL_Retail_Sales_P1
Project Title: Retail Sales Analysis Using SQL

Description:
This project was created to showcase my SQL skills and techniques commonly employed by data analysts for exploring, cleaning, and analyzing retail sales data.

The project involves:
                    Setting up a comprehensive retail sales database.
                    Performing Exploratory Data Analysis (EDA) to uncover trends and patterns.
                    Answering key business questions through advanced SQL queries, including data aggregation and filtering.


## Objectives :   
1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.


## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_Project_1`.
- **Table Creation**: A table named `Retail_Sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

**Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select count(*)from Retail_Sales;
select count(distinct customer_id) from retail_sales;
select distinct category from  retail_sales;

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

```


### 3. Data Analysis & Findings

Bussiness Questions

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from Retail_sales
where sale_date = '2022-11-05';
```


2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
   ```sql
   Select
   * 
   from Retail_sales
   where
     category = 'Clothing'
	 and quantity>=4
     and TO_CHAR(sale_date , 'yyyy-mm') = '2022-11';
 ```

3.**Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category , sum(total_sale) as Total_sales from retail_sales
group by category;
 ```


4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
   ```sql
   select ROUND(AVG(age),2) as Avg_age from retail_sales
   where category = 'Beauty' ;
   ```


5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
 ```sql
Select * from retail_sales
where total_sale> 1000;
 ```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select gender,category, Count(*)as total_transactions from retail_sales
group by gender,category 
order by category;
```



7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select customer_id ,sum(total_sale)as total_sales from retail_sales
group by customer_id
order by total_sales desc
limit 5; 
```


9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select count(distinct(customer_id))as Dis_customer,category from retail_sales
group by category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```












