create database superstore;
use superstore;

show tables;
select* from store;

-- 1. Count the total number of orders in the dataset.
select count(*) as "Total_orders" from store;

-- 2. List all unique product categories available in the store.
select distinct (ProductCategory) from store;

-- 3. Find the total sales for each region.
select region , round(sum(sales), 2) as "Total_Sales" from store 
group by Region;

-- 4. Identify the top 5 customers by the total amount spent.
select CustomerName , round(sum(sales), 2) as "Total_Sales" 
from store
group by CustomerName
order by CustomerName
LIMIT 5;

-- 5. Calculate the average shipping cost for each shipping mode.
select shipmode, round(avg(ShippingCost), 2) as "Average shipping cost" 
from store 
group by shipmode; 

-- 6. List all orders where the discount is greater than 20%.
select* from store
where discount> 0.20;

-- 7. Count the number of orders placed in each state.
select state_province , count(*) as "No. of Orders"
from store
group by state_province;

-- 8. Find the minimum, maximum, and average unit price of products.
select min(UnitPrice) as "Minimum_UnitPrice", 
max(UnitPrice) as "Maximum_UnitPrice", 
avg(UnitPrice) as "Average_UnitPrice"
from store;

-- 9. Find all orders where the Product Name contains the word 'Desk'.
select * from store 
where productname like "%Desk%"; 

-- 10. Find all orders where the shipping cost is more than 10 % of the sales price.
select* from store 
where shippingcost > 0.10* sales;

-- 11. List the top 5 cities with the highest number of orders.
select city , count(*) as "TotalOrders"
from store 
group by city 
order by TotalOrders desc
LIMIT 5;

-- 12. Find the most profitable product sub-category in each region.
select region, ProductCategory, round(sum(profit), 2) as "Total_Profit"
from store 
group by region, ProductCategory 
order by region, Total_Profit;

-- 13. Identify the top 3 customers who have made the most purchases by quantity. 
select CustomerName, sum(Quantity_ordered_new) as Total_Quantity
from store 
group by CustomerName
order by Total_Quantity desc
limit 3;

-- 14. Identify the months with the highest total sales.
select date_format(str_to_date(orderdate, '%m/%d/%Y'), '%Y-%m') as Order_month, 
round(sum(sales), 2) as "Total_Sales"
from store 
group by order_month
order by Total_Sales desc;

-- 15. Group the orders by Product Name and Region, then find the total sales for each combination. 
select ProductName, region, sum(sales) as "Total_sales"
from store
group by ProductName, region;

-- 16. Find the categories where the total number of orders is more than 500.
select productCategory, count(*) as "Total_Orders"
from store
group by ProductCategory 
having count(*) > 500;

-- 17. Find the total number of orders for customers who are from the "Corporate" segment
select count(*) as "Total_orders"
from store
where customerid in (
select distinct CustomerID 
from store 
where customersegment= "Corporate");

-- 18. Analyze the impact of discount on profit by comparing orders with and without discounts.
select CASE WHEN discount> 0 then "With discount" else "No discount" end "discount_type" , 
round(sum(profit), 2) as "Total_profit"
from store 
group by discount_type;

-- 19. Use a window function to rank the Orders within each region based on the total Sales.
select orderid, region, sales, rank() over(partition by region order by sales desc) as sales_rank
from store;

-- 20. Find the top 5 products that have the highest total sales but only include products
--  where the average discount given is less than 10%.

select productname, round(sum(sales), 2) as "Total_Sales", round(avg(discount), 2) as "Avg_Discount"
from store
group by productname
having avg(discount) < 0.10
order by Total_Sales desc
limit 5;

















