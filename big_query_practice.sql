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
SELECT 
  product_category, 
  age_group, 
  AVG(order_quantity) as avg_oq, 
  sum(profit) as total_profit
FROM analytics-accel.prework.sales
GROUP BY 1, 2;
