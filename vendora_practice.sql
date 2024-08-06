--What was the most often-bought product in 2020 in the APAC region?

select orders.product_name,
  count(orders.id) as order_count
from `vendora-431118.vendora.orders` orders
join `vendora-431118.vendora.customers`customers
  on orders.customer_id = customers.id
join `vendora-431118.vendora.geo_lookup` geo_lookup
  on geo_lookup.country = customers.country_code
where orders.purchase_ts between '2020-01-01' and '2020-12-31' and geo_lookup.region = 'APAC'
group by 1
order by 2 desc
limit 1;

==Apple Airpods Headphones with 2656 sales

--Return the top marketing channel, ranked by which channel brings in the most expensive orders. 

with top_marketing_channels as (
select customers.marketing_channel,
  avg(orders.usd_price) as aov
from `vendora-431118.vendora.customers` customers
join `vendora-431118.vendora.orders` orders
  on orders.customer_id = customers.id
group by 1
order by 2 desc)

select *,
  row_number() over (order by aov desc) as ranking
from top_marketing_channels
order by 2 desc

  
--Which month in 2019 had the highest total sales?
  
select date_trunc(purchase_ts,month),
  sum(usd_price) as total_sales
from `vendora-431118.vendora.orders` orders
where purchase_ts between '2019-01-01' and '2019-12-31'
group by 1
order by 2 desc;

--December with $458,353

--For each region, what’s the total number of orders and the total number of customers?

select count(distinct orders.customer_id) as num_customers,
  count(distinct orders.id) as num_orders,
  geo_lookup.region
from `vendora-431118.vendora.orders` orders
join `vendora-431118.vendora.customers` customers
  on orders.customer_id = customers.id
join `vendora-431118.vendora.geo_lookup` geo_lookup
  on customers.country_code = geo_lookup.country
group by 3
order by 3;

--Advanced: What’s the average time it takes for a customer to place their first order for customers in NA or APAC?

with time_to_purchase_days_cte as(
select date_diff(order_status.purchase_ts, customers.created_on, day) as time_to_purchase_days
from `vendora-431118.vendora.order_status` order_status
join `vendora-431118.vendora.orders` orders
  on order_status.order_id = orders.id
join `vendora-431118.vendora.customers` customers
  on orders.customer_id = customers.id
join `vendora-431118.vendora.geo_lookup` geo_lookup
  on geo_lookup.country = customers.country_code
where geo_lookup.region in ('NA', 'APAC'))

select avg(time_to_purchase_days) as avg_time_to_purchase_days, 
from time_to_purchase_days_cte

--Advanced: Of customers who bought an Apple product, how many of these orders were placed on the website?
  
select count(id) as num_count
from `vendora-431118.vendora.orders` orders 
where purchase_platform = 'website' 
  and lower(product_name) like '%apple%'

--46808 orders
