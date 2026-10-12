#1. What are the total revenue, gross sales, profit, and overall profit margin of the business?

select sum(revenue) as total_revenue,sum(gross_sales) as total_gross_sales,
sum(profit) as total_profit,
round(sum(profit)/sum(revenue)*100,2) as profit_margin
from sales_data;

#2. How are revenue and profit changing month-over-month (MoM)?

with monthly as (
select order_month,
sum(revenue) as revenue,
sum(profit) as profit,
lag(sum(revenue))over(order by order_month) as previous_revenue,
lag(sum(profit))over(order by order_month) as previous_profit
from sales_data
group by order_month)

select 
order_month,revenue,profit, round((revenue - previous_revenue) / previous_revenue *100,2) as revenue_growth,
round((profit - previous_profit) / previous_profit *100,2) as profit_growth
from monthly
order by order_month;

#3. Which 10 products generate the highest total profit, and what are their revenue and profit margins?

with ranked as (
select product,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(sum(profit)/sum(revenue)*100,2) as profit_margin,
dense_rank()over(order by sum(profit) desc) as ranks
from sales_data
group by product
)

select product,total_revenue,
total_profit,profit_margin,ranks
from ranked
where ranks < 11;

#4. Which product categories are the most profitable, and does the category with the highest revenue also have the highest profit margin?

with cte as (
select product_category,
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(sum(profit)/sum(revenue) * 100,2) as profit_margin,
dense_rank()over(order by sum(profit) desc) as ranks
from sales_data
group by product_category),

ranked as (
select *,dense_rank()over( order by  total_profit desc) profit_rank,
dense_rank()over( order by  total_revenue desc) revenue_rank
from cte)

select product_category,total_orders,total_revenue,
total_profit,profit_margin,revenue_rank,profit_rank,
case when profit_rank = 1 & revenue_rank = 1
then "YES" else "NO" end as highest_revenue_and_margin
from ranked
order by revenue_rank
;

# 5. Who are the Top 10 customers generating the highest total revenue?

with ranked as (
select customer_id,
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(avg(revenue),2) as average_order_value,
dense_rank()over(order by sum(revenue) desc) as ranks
from sales_data 
group by customer_id)

select * from ranked where ranks <=10;

#6. How do New and Existing customers differ in business value?

select customer_type,count(distinct customer_id) as total_customers,
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
avg(revenue) as average_order_value,
round(sum(profit)/sum(revenue) * 100,2) as profit_margin
from sales_data
group by customer_type;


#7. Which customer segment—Consumer or Corporate—is more valuable to the business?

select customer_segment,
count(distinct customer_id),
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
avg(revenue) as average_order_value,
round(sum(profit)/sum(revenue) * 100,2) as profit_margin,
round(sum(revenue)/sum(sum(revenue)) over()* 100,2) as revenue_contribution
from sales_data
group by customer_segment;

#8. Which customer age group generates the highest revenue and profit?

select 
case when customer_age < 25 then "18_25"
when customer_age < 35 then '26_35'
when customer_age < 45 then "36_45"
when customer_age < 55 then "46_55"
else "56+" end as age_group,
count(distinct customer_id),
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
avg(revenue) as average_order_value,
round(sum(profit)/sum(revenue) * 100,2) as profit_margin
from sales_data
group by age_group;

# 9. Which acquisition channel performs best?

select acquisition_channel,
count(distinct customer_id),
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(avg(revenue),2) as average_order_value,
round(sum(profit)/sum(revenue) * 100,2) as profit_margin
from sales_data
group by acquisition_channel
order by total_profit desc;

#10. Acquisition Channel Efficiency

select acquisition_channel,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(avg(revenue),2) as average_order_value,
round(sum(profit)/sum(revenue) * 100,2) as profit_margin,
round(sum(revenue) / sum(sum(revenue))over()*100,2) as contribution
from sales_data
group by acquisition_channel
order by total_profit desc;


#11 For each acquisition_channel, find out how well it brings repeat customers.

with ranks as (select customer_id,
count(order_id) as order_count
from sales_data
group by customer_id
)

select s.acquisition_channel,
count(distinct s.customer_id) as total_customers,
count(distinct case when r.order_count > 1 then s.customer_id end) as repeat_customers,
round(count(case when r.order_count > 1 then r.customer_id end)
/count(distinct s.customer_id) * 100,2) as repeat_customer_rate
from sales_data s join ranks r on s.customer_id=r.customer_id
group by s.acquisition_channel;

#12 Discount Impact, Analyze discounts

select discount_category,
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(avg(revenue),2) as average_order_value,
round(sum(profit)/sum(revenue) * 100,2) as profit_margin
from sales_data
group by discount_category;

#13. compare customers/orders using a coupon vs no coupon

select case when coupon_code = 'No Coupon' then 'No Coupon' else 'Coupon' end as coupon_usage,
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(avg(revenue),2) as average_order_value,
round(sum(profit) / sum(revenue) * 100,2) as profit_margin
from sales_data
group by coupon_usage;

#14. Which product categories have the highest return rates, and how much revenue is associated with those returned orders?

select product_category,
count(order_id) as total_orders,
count(case when order_status = 'Returned' then order_id end) as return_orders,
round(count(case when order_status = 'Returned' then order_id end)/count(order_id)*100,2) as return_rate,
sum(case when order_status = 'Returned' then revenue end) as return_revenue,
sum(case when order_status = 'Returned' then profit end) as total_profit
from sales_data 
group by product_category;

#15. Does a higher number of support tickets relate to lower customer ratings and worse order outcomes?

select case when support_tickets < 1 then "0" 
when support_tickets <= 2 then "1-2"
when support_tickets <=5 then "3-5"
else "6+" end as support_ticket_group,
count(order_id) as total_orders,
round(avg(customer_rating),2) as average_rating,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
count(case when order_status = "Cancelled" then order_id end) as cancelled_orders,
count(case when order_status = "Returned" then order_id end) as returned_orders
from sales_data
group by support_ticket_group
order by support_ticket_group;

#16. Compare Standard vs Express vs other shipping types to determine whether faster shipping is worth the additional cost.

select shipping_type,
count(order_id) as total_orders,
round(avg(delivery_days),2) as avg_delivery_days,
sum(shipping_cost) as total_shipping_cost,
round(avg(shipping_cost),2) as avg_shipping_cost,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(sum(profit)/sum(revenue)*100,2) as profit_margin
from sales_data
group by shipping_type;

#17. Which payment methods perform best in terms of orders, revenue, profitability, and order value?

select payment_method,
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(avg(revenue),2) as average_order_value,
round(sum(profit)/sum(revenue)*100,2) as profit_margin,
count(case when order_status = "Cancelled" then order_id end) as cancelled_orders,
count(case when order_status = "Failed" then order_id end) as failed_orders
from sales_data
group by payment_method
order by profit_margin desc;


#18. Which cities generate the most revenue while also having slower delivery?

select city,
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(avg(delivery_days),2) as average_dd,
round(count(case when delivery_performance = "Delayed" then order_id end)/count(order_id)*100,2) as delay_rate,
count(case when delivery_performance = "Delayed" then order_id end) as delayed_orders
from sales_data
group by city
having count(order_id) >= 100
order by total_revenue desc;

#19.Order Size & Profitability

select quantity,
count(order_id) as total_orders,
sum(revenue) as total_revenue,
sum(profit) as total_profit,
round(avg(revenue),2) as average_order_value,
round(sum(profit)/sum(revenue)*100,2) as profit_margin
from sales_data
group by quantity
order by quantity;

#20. Do a Pareto analysis of customers

WITH ranks AS (
    SELECT
        customer_id,
        SUM(revenue) AS total_revenue,
        DENSE_RANK() OVER (
            ORDER BY SUM(revenue) DESC
        ) AS revenue_rank,
        SUM(SUM(revenue)) OVER () AS grand_total_revenue
    FROM sales_data
    GROUP BY customer_id
),
cum AS (
    SELECT
        *,
        SUM(total_revenue) OVER (
            ORDER BY revenue_rank
        ) AS cum_total
    FROM ranks
)
SELECT
    customer_id,
    total_revenue,
    revenue_rank,
    ROUND(total_revenue / grand_total_revenue * 100, 2) AS revenue_contribution_pct,
    cum_total,
    ROUND(cum_total / grand_total_revenue * 100, 2) AS cumulative_revenue_pct
FROM cum
ORDER BY revenue_rank;