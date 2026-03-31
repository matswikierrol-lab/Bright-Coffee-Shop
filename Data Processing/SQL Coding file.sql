select * from `workspace`.`default`.`bright_coffee_shop` limit 100;



-- Total transactions recorded

SELECT COUNT(transaction_id) AS total_transactions
FROM `workspace`.`default`.`bright_coffee_shop`;


-- Days with the highest number of transactions

SELECT transaction_date,
       COUNT(transaction_id) AS num_transactions
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY transaction_date
ORDER BY num_transactions DESC;



-- 2. DATE ANALYSIS (transaction_date)


-- Dates with highest and lowest revenue

SELECT transaction_date,
       ROUND(SUM(unit_price * transaction_qty), 2) AS daily_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY transaction_date
ORDER BY daily_revenue DESC;



-- Weekends vs Weekdays

SELECT CASE WHEN DAYOFWEEK(transaction_date) IN (1, 7) THEN 'Weekend'
            ELSE 'Weekday'
       END AS day_type,
       COUNT(transaction_id) AS total_transactions,
       ROUND(SUM(unit_price * transaction_qty), 2) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY day_type;


--IS REVENUE GROWING OR DECLINING EACH MONTH?

SELECT (transaction_date) AS month,
       COUNT(transaction_id) AS total_transactions,
       ROUND(SUM(unit_price * transaction_qty), 2) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY month
ORDER BY month;


--WHICH HOURS OF THE DAY ARE THE BUSIEST?

SELECT HOUR(transaction_time) AS hour_of_day,
       COUNT(transaction_id) AS total_transactions,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY hour_of_day
ORDER BY total_transactions DESC;


--WHICH HOURS ARE THE QUIETEST?

SELECT HOUR(transaction_time) AS hour_of_day,
       COUNT(transaction_id) AS total_transactions
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY hour_of_day
ORDER BY total_transactions ASC;

--HOW DO SALES COMPARE: MORNING, AFTERNOON, EVENING?

SELECT CASE WHEN HOUR(transaction_time) BETWEEN 5  AND 11 THEN 'Morning (5am - 11am)'
            WHEN HOUR(transaction_time) BETWEEN 12 AND 17 THEN 'Afternoon (12pm - 5pm)'
            WHEN HOUR(transaction_time) BETWEEN 18 AND 21 THEN 'Evening (6pm - 9pm)'
            ELSE 'Off-Hours'
       END AS time_of_day,
       COUNT(transaction_id) AS total_transactions,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY time_of_day
ORDER BY total_revenue DESC;

--WHAT IS THE AVERAGE NUMBER OF ITEMS BOUGHT PER TRANSACTION?

SELECT AVG(transaction_qty) AS avg_items_per_transaction
FROM `workspace`.`default`.`bright_coffee_shop`;


--ARE CUSTOMERS BUYING 1 ITEM OR MANY?

SELECT CASE WHEN transaction_qty = 1 THEN 'Single Item'
            WHEN transaction_qty BETWEEN 2 AND 3 THEN '2 to 3 Items'
            ELSE '4 or More Items'
       END AS purchase_size,
       COUNT(transaction_id) AS num_transactions
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY purchase_size
ORDER BY num_transactions DESC;

--WHICH STORE HAS THE MOST TRANSACTIONS AND REVENUE?

SELECT store_id,
       store_location,
       COUNT(transaction_id) AS total_transactions,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY store_id, store_location
ORDER BY total_revenue DESC;

 --WHICH STORE LOCATION PERFORMS THE BEST?

SELECT store_location,
       COUNT(transaction_id) AS total_transactions,
       SUM(unit_price * transaction_qty) AS total_revenue,
       AVG(unit_price * transaction_qty) AS avg_transaction_value
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY store_location
ORDER BY total_revenue DESC;

--WHICH INDIVIDUAL PRODUCTS GENERATE THE MOST SALES?

SELECT product_id,
       product_detail,
       SUM(transaction_qty) AS total_qty_sold,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY product_id, product_detail
ORDER BY total_revenue DESC;

--WHAT ARE THE TOP 5 BEST-SELLING PRODUCTS?

SELECT product_detail,
       SUM(transaction_qty) AS total_qty_sold,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY product_detail
ORDER BY total_revenue DESC
LIMIT 5;


--WHAT ARE THE BOTTOM 5 WORST-SELLING PRODUCTS?

SELECT product_detail,
       SUM(transaction_qty) AS total_qty_sold,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY product_detail
ORDER BY total_revenue ASC
LIMIT 5;

--DO CHEAPER OR MORE EXPENSIVE PRODUCTS SELL MORE?

SELECT CASE WHEN unit_price < 3 THEN 'Cheap (under R3)'
            WHEN unit_price < 5 THEN 'Medium (R3 to R4.99)'
            WHEN unit_price < 7 THEN 'Pricey (R5 to R6.99)'
            ELSE 'Expensive (R7 and above)'
       END AS price_group,
       COUNT(transaction_id) AS total_transactions,
       SUM(transaction_qty) AS total_qty_sold,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY price_group
ORDER BY total_qty_sold DESC;

--WHICH PRODUCT CATEGORY MAKES THE MOST MONEY?

SELECT product_category,
       COUNT(transaction_id) AS total_transactions,
       SUM(transaction_qty) AS total_qty_sold,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY product_category
ORDER BY total_revenue DESC;


--WHICH PRODUCT TYPE IS THE MOST POPULAR?

SELECT product_type,
       COUNT(transaction_id) AS total_transactions,
       SUM(transaction_qty) AS total_qty_sold,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY product_type
ORDER BY total_transactions DESC;


--WHICH PRODUCT TYPES ARE UNDERPERFORMING?

SELECT product_type,
       COUNT(transaction_id) AS total_transactions,
       SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY product_type
ORDER BY total_revenue ASC
LIMIT 5;
