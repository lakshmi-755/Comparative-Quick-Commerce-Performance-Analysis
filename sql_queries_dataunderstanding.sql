-- Total number of rows in the table
SELECT COUNT(*) AS total_rows
FROM power_bi_analytics;

-- Total revenue
SELECT SUM(`Order Value (INR)`) AS total_revenue
FROM power_bi_analytics;


-- customer review text count
select `Customer Feedback` , count(*) as count_review
from power_bi_analytics 
group by `Customer Feedback`


-- share order percentage
SELECT 
    Platform,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS Order_Share_Percent
FROM power_bi_analytics
GROUP BY Platform;

--  count of orders per customer value
SELECT  `Customer Segment`, COUNT(*) AS Orders
FROM power_bi_analytics
GROUP BY  `Customer Segment`;

-- revenue of orders per customer segment
SELECT  
    `Customer Segment`,
    SUM(`Order Value (INR)`) AS Revenue
FROM power_bi_analytics
GROUP BY `Customer Segment`
ORDER BY Revenue DESC;



-- Revenue by platform 
SELECT Platform,
       COUNT(*) AS total_orders,
       SUM(`Order Value (INR)`) AS revenue
FROM power_bi_analytics
GROUP BY Platform
ORDER BY revenue DESC;

-- Average delivery time by platform
SELECT Platform,
       AVG(`Delivery Time (Minutes)`) AS avg_delivery_time
FROM power_bi_analytics
GROUP BY Platform
ORDER BY avg_delivery_time;

-- Refund rate by platform
SELECT Platform,
       SUM(CASE WHEN `Refund Requested` = TRUE THEN 1 ELSE 0 END) AS refund_count,
       COUNT(*) AS total_orders,
       ROUND(100.0 * SUM(CASE WHEN `Refund Requested` = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS refund_rate_pct
FROM power_bi_analytics
GROUP BY Platform
ORDER BY refund_rate_pct DESC;

-- delivary delay
SELECT Platform,
       SUM(CASE WHEN `Delivery Delay` = TRUE THEN 1 ELSE 0 END) AS delayed_orders,
       COUNT(*) AS total_orders,
       ROUND(100.0 * SUM(CASE WHEN `Delivery Delay` = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS delay_percentage
FROM power_bi_analytics
GROUP BY Platform
ORDER BY delay_percentage DESC;


-- top 5 categeries by revenue 

SELECT `Product Category`,
       SUM(`Order Value (INR)`) AS revenue
FROM power_bi_analytics
GROUP BY `Product Category`
ORDER BY revenue DESC
LIMIT 5;

-- customer segment revenue 
SELECT `Customer Segment`,
       COUNT(*) AS total_orders,
       SUM(`Order Value (INR)`) AS revenue,
       AVG(`Order Value (INR)`) AS avg_spend
FROM power_bi_analytics
GROUP BY `Customer Segment`
ORDER BY revenue DESC;

-- Delivery time category distribution
SELECT `Delivery Time Category`,
       COUNT(*) AS total_orders
FROM power_bi_analytics
GROUP BY `Delivery Time Category`
ORDER BY total_orders DESC;

-- What kind of customers request the most refunds?
SELECT `Customer Segment`,
       COUNT(*) AS total_orders,
       SUM(CASE WHEN `Refund Requested` = TRUE THEN 1 ELSE 0 END) AS refunds,
       ROUND(100.0 * SUM(CASE WHEN `Refund Requested` = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS refund_rate_pct
FROM power_bi_analytics
GROUP BY `Customer Segment`
ORDER BY refund_rate_pct DESC;

-- problem orders slow + refund 
SELECT count(*)
FROM power_bi_analytics
WHERE `Delivery Time (Minutes)` > 40
  AND `Refund Requested` = TRUE
ORDER BY `Delivery Time (Minutes)` DESC;


-- top feedback 
SELECT count(*)
FROM power_bi_analytics
WHERE `Customer Feedback` LIKE '%missing%'
   OR `Customer Feedback` LIKE '%late%'
   OR `Customer Feedback` LIKE '%problem%'
   
   -- average rating by product category 

SELECT `Product Category`,AVG(`Service Rating`) AS avg_rating
FROM power_bi_analytics
GROUP BY `Product Category`
ORDER BY avg_rating DESC;

-- revenue by time
SELECT `Delivery Time Category`,
       SUM(`Order Value (INR)`) AS total_revenue
FROM power_bi_analytics
GROUP BY `Delivery Time Category`
ORDER BY total_revenue DESC;


-- total number of orders per customer
SELECT 
    `Customer ID`,
    COUNT(`Order ID`) AS Total_Orders
FROM 
    power_bi_analytics
GROUP BY 
    `Customer ID`
ORDER BY 
    Total_Orders DESC;

-- total number of refunds per customer
SELECT 
    `Customer ID`,
    SUM(
        CASE 
            WHEN `Refund Requested` = 'TRUE' THEN 1 
            ELSE 0 
        END
    ) AS Total_Refunds
FROM power_bi_analytics
GROUP BY `Customer ID`
ORDER BY Total_Refunds DESC;
-- most frequently bought category overall
SELECT 
    `Product Category`,
    COUNT(*) AS Total_Orders
FROM power_bi_analytics
GROUP BY `Product Category`
ORDER BY Total_Orders DESC;

-- platform based analytics

-- total ordersper platform 
SELECT 
    Platform,
    COUNT(*) AS Total_Orders
FROM power_bi_analytics
GROUP BY Platform
order by Total_Orders DESC;

-- Total Revenue per Platform
SELECT 
    Platform,
    SUM(`Order Value (INR)`) AS Total_Revenue
FROM power_bi_analytics
GROUP BY Platform
order by Total_Revenue DESC;

-- Average Order Value per Platform
SELECT 
    Platform,
    AVG(`Order Value (INR)`) AS Avg_Order_Value
FROM power_bi_analytics
GROUP BY Platform;

-- Refund Count per Platform
SELECT 
    Platform,
    SUM(CASE WHEN `Refund Requested` = 'TRUE' THEN 1 ELSE 0 END) AS Total_Refunds
FROM power_bi_analytics
GROUP BY Platform
order by Total_Refunds DESC



  -- 2. Most Frequently Bought Category (Mode) 
SELECT 
    Platform,
    `Product Category` AS Most_Frequent_Category
FROM (
    SELECT 
        Platform,
        `Product Category`,
        COUNT(*) AS cnt,
        ROW_NUMBER() OVER (
            PARTITION BY Platform 
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM power_bi_analytics
    GROUP BY Platform, `Product Category`
) t
WHERE rn = 1;

-- 3)  average service rating per platform
select Platform ,AVG(`Service Rating`) as avg_service_rating 
From power_bi_analytics
group by Platform

-- 4) delivary delay probability
SELECT 
    Platform,
    COUNT(CASE WHEN `Delivery Delay` = 'TRUE' THEN 1 END) 
    / COUNT(*) AS Delivery_Delay_Probability
FROM power_bi_analytics
GROUP BY Platform;

-- 5) Refund Request Probability
SELECT 
    Platform,
    COUNT(CASE WHEN `Refund Requested` = 'TRUE' THEN 1 END) 
    / COUNT(*) AS Refund_Request_Probability
FROM power_bi_analytics
GROUP BY Platform;

select *
from power_bi_analytics 
where `Customer ID`= 'CUST2824'	



