
use Big_garage_db;
                                                         -- Advanced analysis
-- Change over time
-- Q1 How business metrics/measures evolved over the time
select
    year(so.order_date) as years,
    month(so.order_date) as months,
    count(distinct so.order_id) as total_orders,
    count(distinct so.customer_id) as total_customers,
    count(distinct so.employee_id) as total_employees,
    sum(oi.line_total) as net_revenue,
    avg(oi.line_total) as avg_revenue,
    sum(oi.quantity) as total_quantity
from gold_fact_service_orders as so
    left join gold_fact_service_order_items as oi
on so.order_id = oi.order_id
group by 
    month(so.order_date),
    year(order_date)
order by 
    years,months;


-- Q2 how category genetrated revenue over years
with cat_reve as
(
select 
    year(so.order_date) as order_year,
    oi.category,
    sum(oi.line_total) as net_revenue,
    lag(sum(oi.line_total)) over (partition by oi.category order by year(so.order_date)) as previous_year_revenue
from gold_fact_service_order_items as oi
    left join gold_fact_service_orders as so
on so.order_id = oi.order_id
group by year(so.order_date),oi.category
)
select 
    order_year,
    category,
    net_revenue,
    previous_year_revenue,
    net_revenue - previous_year_revenue as diff
from cat_reve;

-- cumulative analysis
-- Q1 How our business growing
select 
    order_year,
    order_month,
    revenue,
    average,
    sum(revenue) over (partition by order_year order by order_year,order_month) as running_total,
    avg(average) over (partition by order_year order by order_year,order_month) as moving_average
from
(
select 
    year(so.order_date) as order_year,
    month(so.order_date) as order_month,
    sum(oi.line_total) as revenue,
    avg(oi.line_total) as average
from gold_fact_service_orders as so
    left join gold_fact_service_order_items as oi
on so.order_id = oi.order_id
group by 
    year(so.order_date),
    month(so.order_date)
) x;


-- performance analysis
-- Q1 How revneue performing and how much each years contributes
select 
    years,
    net_revenue,
    previous_year_revenue,
    net_revenue - previous_year_revenue as revenue_change
from
(
select 
    years,
    net_revenue,
    lag(net_revenue) over (order by years) as previous_year_revenue
from
(
select 
    year(so.order_date) as years,
    sum(oi.line_total) as net_revenue
from gold_fact_service_orders as so
    left join gold_fact_service_order_items as oi
on so.order_id = oi.order_id
group by 
    year(order_date)
) t
    ) x;

-- part to whole analysis
-- Q1 how much category contributes in revenue

select 
category,
net_revenue,
round(sum(net_revenue) over (),2) as running,
concat(round(net_revenue / round(sum(net_revenue) over (),2) * 100, 2),'%') as perc
from
(
select 
oi.category,
sum(oi.unit_price * oi.quantity) as net_revenue
from gold_fact_service_order_items as oi
group by oi.category) x;

-- Data segmentation
-- Q1 create  categories for customers according to the spending 

with customers_spending as 
(
select 
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    c.city,
    c.state,
    sum(oi.quantity * oi.unit_price) as spending 
from gold_dim_customers as c
    left join gold_fact_service_orders as so
on c.customer_id = so.customer_id
    left join gold_fact_service_order_items as oi
on so.order_id = oi.order_id
group by 
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    c.city,
    c.state
having sum(oi.quantity * oi.unit_price) is not null),

segmentation as 
( 
select 
    customer_id,
    customer_name,
    email,
    phone,
    city,
    state,
    spending,
    case when spending >= 5000 then 'VIP Customers'
         when spending >= 3000 then 'Standrad Customers'
         else 'Regular Customers'
    end as segments
from customers_spending)

select 
*
from segmentation
where segments = 'VIP Customers';




























