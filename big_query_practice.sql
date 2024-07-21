--What is the earliest year of purchase?
SELECT min(year) as earliest_year
FROM analytics-accel.prework.sales;

--What is the average customer age per year? Order the years in ascending order.
SELECT year, AVG(customer_age)
FROM analytics-accel.prework.sales
GROUP BY year
ORDER BY year;

--Return all clothing purchases from September 2015 where the cost was at least $70.
SELECT *
FROM analytics-accel.prework.sales
WHERE product_category = 'Clothing' 
  AND month = 'September' 
  AND year = 2015 
  AND cost >= 70
ORDER BY date;


--What are all the different types of product categories that were sold from 2014 to 2016 in France?
SELECT *
FROM analytics-accel.prework.sales
WHERE country = 'France' 
  AND year BETWEEN 2014 AND 2016;
//Clothing - Caps

--Within each product category and age group (combined), what is the average order quantity and total profit?
SELECT product_category, 
  age_group, 
  AVG(order_quantity) as avg_oq, 
  sum(profit) as total_profit
FROM analytics-accel.prework.sales
GROUP BY 1, 2;

--Which product category has the highest number of orders among 31-year olds? Return only the top product category.
SELECT product_category, 
  sum(order_quantity) as total_quantity
FROM analytics-accel.prework.sales
WHERE customer_age = 31
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--Of female customers in the U.S. who purchased bike-related products in 2015, what was the average revenue?
SELECT AVG(revenue) as avg_revenue
FROM analytics-accel.prework.sales
WHERE customer_gender = 'F' 
  AND product_category LIKE '%Bike%'
	AND country = 'United States' 
  AND year = 2015;

--Categorize all purchases into bike vs. non-bike related purchases. How many purchases were there in each group among male customers in 2016?
select case when product like '%Bike%' then 'biker'
  else 'non-biker' end as biker_nonbiker,
  count(*) as count
from analytics-accel.prework.sales
where year = 2016
and customer_gender = 'M'
group by 1;

--Among people who purchased socks or caps (use `sub_category`), what was the average profit earned per country per year, ordered by highest average profit to lowest average profit?
SELECT year, country, 
  AVG(profit) AS avg_prof
FROM analytics-accel.prework.sales
WHERE sub_category in ('Caps','Socks')
GROUP BY 1, 2
ORDER BY 3 DESC;

--For male customers who purchased the AWC Logo Cap (use `product`), use a window function to order the purchase dates from oldest to most recent within each year.\
select *, 
	row_number() over (partition by customer_gender order by date asc ) as date_rank
from prework.sales
where customer_gender = 'M' and product = 'AWC Logo Cap';
