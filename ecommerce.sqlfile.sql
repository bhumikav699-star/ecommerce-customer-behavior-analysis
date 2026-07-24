-- DATABASE CREATION

CREATE DATABASE ecommerce_db;
USE ecommerce_db;
CREATE TABLE orders (
    Order_ID VARCHAR(20),
    Customer_ID VARCHAR(20),
    Order_Date DATE,
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50),
    Product_Category VARCHAR(50),
    Unit_Price DECIMAL(10,2),
    Quantity INT,
    Discount_Amount DECIMAL(10,2),
    Total_Amount DECIMAL(10,2),
    Payment_Method VARCHAR(30),
    Device_Type VARCHAR(20),
    Session_Duration_Minutes INT,
    Pages_Viewed INT,
    Is_Returning_Customer BOOLEAN,
    Delivery_Time_Days INT,
    Customer_Rating INT,
    Order_Month VARCHAR(10),
    Age_Group VARCHAR(10)
    );
    
-- BASIC KPI QUERIES

-- top 10 orders
    select * from orders limit 10;
-- total orders 
    select count(*) as total_orders from orders;
-- total revenue
    select sum(total_amount) as total_revenue from orders;
-- average order value
    select avg(total_amount) as average_order_value from orders;
-- unique customers
    select count(distinct customer_id) as unique_customers from orders;
-- first and last order date
    SELECT MIN(order_date) AS first_order,
	MAX(order_date) AS last_order FROM orders ;
-- total quantity sold
    select sum(quantity) as total_quantity_sold from orders;
-- avergae discount
    select avg(discount_amount) as avergae_discount from orders;
-- average customer rating
    select avg(customer_rating) as average_customer_rating from orders;
    
-- PRODUCT ANALYSIS

-- revenue by catergory
   Select Product_Category , SUM(Total_Amount) AS Revenue FROM orders
   GROUP BY Product_Category ORDER BY Revenue DESC;
-- quantity sold by category
   select product_category , sum(quantity) as Tquantity_sold from orders
   group by product_category order By Tquantity_sold desc ;
-- average rating by category
   select product_category ,  avg(customer_rating) as average_customer_rating from orders
   group by product_category order by average_customer_rating desc;
   
-- CITY ANALYSIS

-- revenue by city
   Select city , SUM(Total_Amount) AS Revenue FROM orders
   GROUP BY city ORDER BY Revenue DESC;
-- orders by city
   select city , count(*) as orders from orders
   group by city order by orders desc;
-- average delivery time by city
   select city , round(avg(delivery_time_days),2) as avg_delivery_time from orders
   group by city order by avg_delivery_time desc;
   
--  CUSTOMER ANALYSIS

-- returning vs new customers
   select  Is_Returning_Customer , count(*) as customers from orders
   group by  Is_Returning_Customer ;
-- revenue by customer type
   SELECT Is_Returning_Customer,SUM(Total_Amount) AS Revenue FROM orders
   GROUP BY Is_Returning_Customer;
-- revenue by age group
   select age_group , sum(total_amount) as revenue from orders
   group by age_group order by revenue desc;
-- revenue by gender
   select gender ,sum(total_amount) as revenue from orders
   group by gender order by revenue desc;
 -- top 10 customers by spending
   select customer_id, sum(total_amount) as total_spent from orders
   group by customer_id  order by total_spent desc limit 10; 

-- PAYMENT ANALYSIS   
   
-- most used payment method
   select payment_method ,count(*) as orders from orders
   group by payment_method order by orders desc;
-- revenue by payment method
  SELECT Payment_Method, SUM(Total_Amount) AS Revenue FROM orders
  GROUP BY Payment_Method ORDER BY Revenue DESC;
  
-- SALES ANALYSIS
  
-- top selling category by quantity
   select product_category , sum(Quantity) as top_selling from orders
   group by product_category order by top_selling desc;
-- top 10 product category by revenue
   select product_category , round(sum(total_Amount),-2) as revenue from orders
   group by product_category order by revenue desc;
    
-- ADVANCED QUERIES

-- rank customers by total spending
   SELECT Customer_ID, SUM(Total_Amount) AS Total_Spent, RANK()
   OVER(ORDER BY SUM(Total_Amount) DESC) AS Customer_Rank FROM orders 
   GROUP BY Customer_ID;
 -- Row Number for Every Order 
  SELECT Order_ID, Customer_ID, Total_Amount, ROW_NUMBER() 
  OVER(ORDER BY Total_Amount DESC) AS Row_Num FROM orders;
-- Running Revenue
  SELECT Order_Date, Total_Amount, SUM(Total_Amount)
  OVER(ORDER BY Order_Date) AS Running_Revenue FROM orders;
-- Revenue Contribution (%) by Product Category  
   SELECT Product_Category, SUM(Total_Amount) AS Revenue, ROUND(SUM(Total_Amount)*100/
   SUM(SUM(Total_Amount)) OVER(),2) AS Revenue_Percentage FROM orders
   GROUP BY Product_Category;
-- Customer Segmentation
   SELECT Customer_ID, SUM(Total_Amount) AS Total_Spent,
   CASE WHEN SUM(Total_Amount)>=5000 THEN 'Premium'
   WHEN SUM(Total_Amount)>=3000 THEN 'Gold'
   WHEN SUM(Total_Amount)>=1500 THEN 'Silver'
   ELSE 'Regular' END AS Customer_Type FROM orders
   GROUP BY Customer_ID;
-- Revenue by Age Category
SELECT CASE
WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
ELSE '46+' END AS Age_Category, 
SUM(Total_Amount) AS Revenue FROM orders
GROUP BY Age_Category ;
-- Customers Spending Above Average
SELECT Customer_ID, SUM(Total_Amount) AS Spending FROM orders
GROUP BY Customer_ID HAVING Spending > (SELECT AVG(Total) FROM
(SELECT SUM(Total_Amount) AS Total FROM orders GROUP BY Customer_ID) x
);
-- Top Product Category in Every City
WITH CitySales AS ( SELECT City, Product_Category, 
SUM(Total_Amount) AS Revenue FROM orders
GROUP BY City, Product_Category),
Ranked AS(SELECT *, RANK() OVER(PARTITION BY City ORDER BY Revenue DESC) rk
FROM CitySales)
SELECT * FROM Ranked WHERE rk=1;
-- Highest Revenue Customer in Every City
WITH CustomerRevenue AS( SELECT City, Customer_ID,
SUM(Total_Amount) AS Revenue FROM orders
GROUP BY City,Customer_ID), Ranked AS
(SELECT *, RANK() OVER(PARTITION BY City ORDER BY Revenue DESC) rk FROM CustomerRevenue)
SELECT * FROM Ranked WHERE rk=1;
--  Previous Order Amount
SELECT Customer_ID, Order_Date, Total_Amount, LAG(Total_Amount) 
OVER(PARTITION BY Customer_ID ORDER BY Order_Date) AS Previous_Order FROM orders;
-- Next Order Amount    
SELECT Customer_ID, Order_Date, Total_Amount, LEAD(Total_Amount)
OVER(PARTITION BY Customer_ID ORDER BY Order_Date)
AS Next_Order FROM orders;
-- Average Revenue by Device Type
SELECT Device_Type,
ROUND(AVG(Total_Amount),2) AS Avg_Revenue FROM orders
GROUP BY Device_Type ORDER BY Avg_Revenue DESC;
-- Best Performing Payment Method
WITH PaymentRevenue AS (SELECT Payment_Method,
SUM(Total_Amount) AS Revenue FROM orders
GROUP BY Payment_Method)
SELECT * FROM PaymentRevenue 
ORDER BY Revenue DESC;
-- Monthly Revenue Ranking
SELECT Order_Month,
SUM(Total_Amount) AS Revenue, RANK() OVER(
ORDER BY SUM(Total_Amount) DESC
) AS Revenue_Rank FROM orders
GROUP BY Order_Month;
-- 	Customer Spending Percentile
SELECT Customer_ID, SUM(Total_Amount) AS Spending,
NTILE(4) OVER(ORDER BY SUM(Total_Amount) DESC)
AS Customer_Quartile FROM orders
GROUP BY Customer_ID;   