create database Sales_Data;
use Sales_Data;

select * from e_commerce_data;
													 -- Check Datatype --
select column_name, data_type from information_schema.columns
where table_name = "e_commerce_data";


                                                      -- QUERYS --
/*
1. Total Sales, Cost, Profit by Category
2. Top 10 Cities with Highest Profit
3. Loss-Making Cities (Negative Profit)
4. Average Delivery Days (Shipping Delay)
5. Most Used Shipping Mode
6. Customer Who Ordered the Most (Top 10 Customers by Orders)
7. Impact of Discount on Profit (Average Discount for Loss vs Profit)
8. Monthly Profit Trend (Year and Month wise)
9. Top 5 Most Sold Products by Quantity
10. Profit Margin by Category
11. Running Total of Profit by Region (Window function)
*/

                                                     -- SOLVE QUERYS -- 
                                                     -- SOLVE QUERRS -- 
                                                     -- SOLVE QUERYS --                                                      
-- Total Sales, Cost, Profit by Category
CREATE VIEW Total_Sales_Cost_Profit_by_Category AS
select Category,
	round(sum(Discounted_Sale), 3)as total_sale,
	round(sum(Cost), 2)as total_cost,
	round(sum(Profit),2)as total_profit
from e_commerce_data
group by Category;
SELECT * FROM Total_Sales_Cost_Profit_by_Category;


-- Top 10 Cities with Highest Profit
CREATE VIEW Highest_Profit_Cities AS
select City, round(sum(Profit), 3)as total_profit from e_commerce_data
group by City
order by total_profit desc
limit 10;
SELECT * FROM Highest_Profit_Cities;


-- Loss-Making Cities (Negative Profit)
CREATE VIEW Loss_Making_Cities AS
select City, round(sum(profit),2)as Loss from e_commerce_data
where Profit < 0
group by City
order by Loss;
SELECT * FROM Loss_Making_Cities;


-- Average Delivery Days (Shipping Delay)
CREATE VIEW Average_Delivery_Day AS
select avg(datediff(Ship_Date, Order_Date))as Avg_Delivery_Days from e_commerce_data;
SELECT * FROM Average_Delivery_Day;


-- Most Used Shipping Mode
CREATE VIEW Most_Used_Shipping_Mode AS
select Ship_Mode, count(*)as Ship_mode_count from e_commerce_data
group by Ship_Mode
order by Ship_mode_count desc
limit 1;
SELECT * FROM Most_Used_Shipping_Mode;


-- Customer Who Ordered the Most (Top 10 Customers by Orders)
CREATE VIEW Top_10_Customers AS
select Customer_Name, count(Order_ID) as order_count from e_commerce_data
group by Customer_Name
order by order_count desc
limit 10;
SELECT * FROM Top_10_Customers;


-- Impact of Discount on Profit (Average Discount for Loss vs Profit)
CREATE VIEW Discount_impact_on_profit AS
select case when Profit < 0 then "Loss" else "Profit" end as Status,
round(avg(Discount), 2) as avg_discount
from e_commerce_data
group by Status;
SELECT * FROM Discount_impact_on_profit;


-- Monthly Profit Trend (Year and Month wise)
CREATE VIEW Year_and_Month_Trend AS
select date_format(Order_Date, "%M")as month,
	   date_format(Order_Date, "%Y")as Year,
	   round(sum(Profit),2)as Monthly_profit
from e_commerce_data
group by Year, month
order by Year, month;
SELECT * FROM Year_and_Month_Trend;


-- Top 7 Most Sold Products by Quantity
CREATE VIEW Most_Sold_Products AS
select Product_Name, sum(Quantity)as sold_Quantity from e_commerce_data
group by Product_Name
order by sold_Quantity desc
limit 7;
SELECT * FROM Most_Sold_Products;


-- Profit Margin by Category
CREATE VIEW Profit_Margin_by_Category AS
select Category,
    round((sum(Profit) / sum(Actual_Sale)) * 100, 2) as Profit_Margin_Percent
from e_commerce_data
group by Category;
SELECT * FROM Profit_Margin_by_Category;


--  Running Total of Profit by Region (Window function)
CREATE VIEW Running_Total_of_Profit_by_Region AS
select Region, Order_Date,
  sum(Profit) over(partition by Region order by Order_Date rows between unbounded preceding and current row) as Running_Profit 
from e_commerce_data;
SELECT * FROM Running_Total_of_Profit_by_Region;


                                                         -- CREATE VIEW --
                                                         -- CREATE VIEW --
                                                         -- CREATE VIEW --


-- 1 Top 10 Cities with Highest Profit
SELECT * FROM Highest_Profit_Cities;

-- 2 Loss-Making Cities (Negative Profit)
SELECT * FROM Loss_Making_Cities;

-- 3 Average Delivery Days (Shipping Delay)
SELECT * FROM Average_Delivery_Day;

-- 4 Most Used Shipping Mode
SELECT * FROM Most_Used_Shipping_Mode;

-- 5 Customer Who Ordered the Most (Top 10 Customers by Orders)
SELECT * FROM Top_10_Customers;

-- 6 Impact of Discount on Profit (Average Discount for Loss vs Profit)
SELECT * FROM Discount_impact_on_profit;

-- 7 Monthly Profit Trend (Year and Month wise)
SELECT * FROM Year_and_Month_Trend;

-- 8 Top 5 Most Sold Products by Quantity
SELECT * FROM Most_Sold_Products;

-- 9 Profit Margin by Category
SELECT * FROM Profit_Margin_by_Category;

-- 10 Running Total of Profit by Region (Window function)
SELECT * FROM Running_Total_of_Profit_by_Region;    

-- 11 Total Sales, Cost, Profit by Category
SELECT * FROM Total_Sales_Cost_Profit_by_Category;                                                    