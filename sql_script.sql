--Checking duplicates.
Select id, count(*)
From sales
Group by id
Having count(*) > 1

--Checking null values

Select *
From sales 
Where
  id is null or
  order_date is null or
  customer_name is null or
  state is null or
  category is null or
  sub_category is null or
  product_name is null or
  sales is null or
  quantity is null or
  profit is null 

-- Calculate the profit margin percentage for each sale (Profit divided by Sales).


  
  
  
  
  
  
  
  




-- Business Problems
  
-- Q.1 Find total sales for each category ?

Select category, Sum(sales)
From sales
Group by category;

-- Q.2 Find out top 5 customers who made the highest profits?

Select customer_name, sum(profits) as tot_profits
From sales
Group by customer_name
order by tot_profits desc
Limit 5;

--Or

Select customer_name, tot_profit
From(
    Select customer_name, sum(profits) as tot_profit 
        row_number() over( order by sum(profits) desc) as rnk
    From sales
    Group by customer_name) a
Where rnk < 6



-- Q.3 Find out average qty ordered per category 

Select category, avg(quantity) as avg_qty_ordered
From sales
Group by category
Order by avg_qty_ordered desc;


-- Q.4 Top 5 products that has generated highest revenue 

Select category, sum(sales) as tot_revenue
From sales
Group by category
order by tot_revenue desc
Limit 5;

-- Q.5 Top 5 products whose revenue has decreased in comparison to previous year?
With revenue23 as (
            Select product_name, sum(sales) as tot_revenue_2023
            From sales
            Where Extract(Year from order_date) = 2023
            Group by product_name),
  
revenue22 as (
          Select product_name, sum(sales) as tot_revenue_2022
          From sales
          Where Extract(Year from order_date) = 2022
          Group by product_name)

Select 
    r1.product_name, 
    tot_revenue_2022 - tot_revenue_2023 as difference,
    ROund((tot_revenue_2023 - tot_revenue_2022)::numeric / tot_revenue_2022:: numeric * 100,2) ||'%' as perc
From revenue23 r1
Join revenue22 r2 
      On r1.product_name = r2.product_name 
      and  tot_revenue_2023 < tot_revenue_2022

-- Q.6 Highest profitable sub category ?

Select sub_category, sum(profits) as tot_profit
From sales
Group by sub_category
Order by tot_profit desc
Limit 1;

-- Q.7 Find out states with highest total orders?

Select state, count(*) as tot_orders
From sales
Group by state
Order by tot_orders desc
Limit 1;

-- Q.8 Determine the month with the highest number of orders.

Select 
  Extract(month from order_date) as mnt, 
  Extract(Year from order_date) as yr,
  count(*) as tot_orders
From sales
Group by
  mnt,
  yr
Order by
  tot_orders desc
Limit 1



-- 10 Calculate the percentage contribution of each sub-category to 
-- the total sales amount for the year 2023.

  
With cte as (
          Select 
            sub_category,
            sum(sales) as sub_cat_revenue
          From sales
          WHere extract(Year from order_date) = 2023
)

Select
  sub_category, 
  Round(sub_cat_revenue / (Select sum(sales) From sales where extract(Year from order_date = 2023)) * 100,2) || '%' as contr_perc
From cte




















