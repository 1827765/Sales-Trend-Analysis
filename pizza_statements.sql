select * from pizza_sales

-- total Revenue
select SUM(total_price) as total_revenue
from ..pizza_sales

--total orders
select COUNT(distinct order_id) total_orders
from pizza_sales

-- avg order revenue
select sum(total_price) / COUNT(distinct order_id) avg_rev
from ..pizza_sales

--total pizza sold 

select SUM(quantity) as total_pizza_sold
from pizza_sales

-- Avg pizza Ordered

select cast(cast(SUM(quantity)as decimal(10,2)) / cast(COUNT(distinct order_id)as decimal(10,2))as decimal(10,2)) Avg_pizza_per_ord
from ..pizza_sales
-----------------------------------------------------------


select * from pizza_sales

-- daily trend

select DATENAME(DW, order_date) order_day,
COUNT(distinct order_id) total_ord
from ..pizza_sales
group by DATENAME(DW, order_date)
order by 2

-- Hourly Trend
select DATEPART(Hour, order_time) as Order_time, COUNT(distinct order_id) total_ord
from pizza_sales
group by DATEPART(Hour, order_time)
order by 2


-- sales by pizza category

select pizza_category,
SUM(total_price) as total_sales,
SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales where MONTH(order_date)= 1) as sales_ratio

from pizza_sales

where MONTH(order_date)= 1
group by pizza_category

--sales by pizza size

select pizza_size,
cast(SUM(total_price)as decimal(10,2)) as total_sales,
cast(SUM(total_price) as decimal(10,2)) * 100 / (select SUM(total_price) from pizza_sales where datepart(QUARTER, order_date)= 1) as sales_ratio

from pizza_sales

where datepart(QUARTER, order_date)= 1
group by pizza_size
order by 3 desc

-- total pize sold per category

select pizza_category, SUM(quantity) total_pizza_sold
from pizza_sales
group by pizza_category

-- top 5 pizza sellers


select top 5 pizza_name, SUM(quantity) total_pizza_sold
from pizza_sales
group by pizza_name
order by 2 desc

--bottom 5 pizza sellers

select top 5 pizza_name, SUM(quantity) total_pizza_sold
from pizza_sales
where MONTH(order_date) = 1
group by pizza_name
order by 2 asc


