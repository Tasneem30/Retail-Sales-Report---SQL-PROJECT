-- SQL Retail Sales Analysis - p1


CREATE TABLE Retail_Sales
(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(20),
age INT,
category VARCHAR(20),	
quantiy	INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
-- DATA CLEANING
SELECT * FROM Retail_Sales
LIMIT 10

SELECT COUNT (*) FROM Retail_Sales

SELECT * FROM Retail_Sales
WHERE transactions_id IS NULL
OR
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id	IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

DELETE FROM Retail_Sales
WHERE transactions_id IS NULL
OR
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id	IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- DATA EXPLOITATION

-- HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS total_sale FROM Retail_Sales

--HOW MANY UNIQUE CUSTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id  ) AS total_sale  FROM Retail_Sales

-- HOW MANY UNIQUE CATEGORIES WE HAVE?
SELECT COUNT(DISTINCT category) AS total_sale  FROM Retail_Sales

--CATEGORY NAMES
SELECT DISTINCT category FROM Retail_Sales

--BUSSINESS KEY PROBLEMS & SOLUTION
--Q1. Write a SQL Querry to retrive all colums for sales made on '2022-11-5'
	
SELECT * FROM Retail_Sales
WHERE sale_date = '2022-11-5';

--Q2. Write a SQL query to retrive all transaction where the category is clothing and the quantity sold is more than 4 in the month of nov -2022
SELECT * FROM Retail_Sales
WHERE category ='Clothing' 
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy>=4

--Q3. Write a SQL querry to find total sale of each category?
SELECT category, SUM(total_sale) AS Total_Sale, COUNT(*) AS Total_Order FROM Retail_Sales
GROUP BY category

--Q4. Write a SQL query to find the average age of customer who purchased items from the 'Beauty' category?
SELECT ROUND (AVG(age),2) AS Average_Age FROM Retail_Sales
WHERE category ='Beauty' 

--Q5. Write a SQL querry to find all transactions where total sale is greater than 1000.
SELECT * FROM Retail_Sales
WHERE total_sale >=1000

--Q6. Write a SQL querry to find the total numaber of transaction (transaction_id) made by each gender in each category?
SELECT Category, gender, COUNT(*) AS TOTAL_TRANSACTION FROM Retail_Sales
GROUP BY Category, gender
ORDER BY Category

--Q7. Write a SQL querry to calculate the average sale for each month. Find out the best selling year?
SELECT
	YEAR,
	MONTH,
	AVG_SALE
FROM	
	(
	SELECT 
EXTRACT(YEAR FROM sale_date) AS YEAR,
EXTRACT(MONTH FROM sale_date)AS MONTH,
AVG(total_sale),2 AS AVG_SALE,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)AS RANK
	FROM Retail_Sales  
GROUP BY YEAR,MONTH
)AS t1
WHERE RANK = 1
--Q8. Write a SQL query to find top 5 customers based on the heights total sale?
SELECT customer_id, SUM(total_sale) AS Total_Sale FROM Retail_Sales 
GROUP BY customer_id
	ORDER BY Total_Sale DESC
LIMIT 5
--Q9. Write a SQL query to find number of unique customers who purchased items from each category?
SELECT 
Category,
COUNT (DISTINCT customer_id) FROM Retail_Sales  
GROUP BY Category

--Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift