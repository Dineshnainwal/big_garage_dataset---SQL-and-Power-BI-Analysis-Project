                                      -- EDA - Exploratory_data_analysis

                                            -- database exploration

                                                use Big_garage_db
-- branches
select * from gold_dim_branches;

select 
    column_name,
    data_type 
from INFORMATION_SCHEMA.columns
where table_name = 'gold_dim_branches'

-- customers
select * from gold_dim_customers;

select 
    column_name,
    data_type 
from INFORMATION_SCHEMA.columns
where table_name = 'gold_dim_customers'

-- employees
select * from gold_dim_employees;

select 
    column_name,
    data_type 
from INFORMATION_SCHEMA.columns
where table_name = 'gold_dim_employees';

-- vehicles
select * from gold_dim_vehicles;

select 
    column_name,
    data_type 
from INFORMATION_SCHEMA.columns
where table_name = 'gold_dim_vehicles';

-- part_inventory
select * from gold_fact_part_inventory;

select 
    column_name,
    data_type 
from INFORMATION_SCHEMA.columns
where table_name = 'gold_fact_part_inventory';

-- service_order_items
select * from gold_fact_service_order_items;

select 
    column_name,
    data_type 
from INFORMATION_SCHEMA.columns
where table_name = 'gold_fact_service_order_items';

-- service_orders
select * from gold_fact_service_orders;

select 
    column_name,
    data_type 
from INFORMATION_SCHEMA.columns
where table_name = 'gold_fact_service_orders';

                                               -- Dimension exploration

-- branches
select * from gold_dim_branches;

select 
    distinct city
from gold_dim_branches; -- 12 distinct cities

select 
    distinct state
from gold_dim_branches; -- 11 distinct states

select 
    distinct region 
from gold_dim_branches; -- 4 distinct regions

-- customers

select * from gold_dim_customers;

select 
    distinct city 
from gold_dim_customers; -- 2725 distinct cities

select 
    distinct state
from gold_dim_customers; -- 59 distinct states

select 
    distinct membership_tier
from gold_dim_customers; -- 4 tiers 

-- employees
select * from gold_dim_employees

select
    distinct role
from gold_dim_employees; -- 5 distinct roles 

-- vehicles
select * from gold_dim_vehicles;

select
    distinct make
from gold_dim_vehicles; -- 7 distinct maker

select 
    distinct fuel_type
from gold_dim_vehicles; -- 4 distinct fule_types

-- part_inventory
select * from gold_fact_part_inventory;

select 
    distinct part_name
from gold_fact_part_inventory; -- 15 distinct parts

-- service_order_items
select * from gold_fact_service_order_items;

select
    distinct service_name
from gold_fact_service_order_items; -- 14 distinct servies

select
    distinct category
from gold_fact_service_order_items; -- 3 distinct service category

 
select 
    distinct category,
    service_name
from gold_fact_service_order_items;


-- service_orders
select * from gold_fact_service_orders;

select 
    distinct status
from gold_fact_service_orders; -- 3 distinct status

select 
    distinct payment_method
from gold_fact_service_orders; -- 6 distinct payment methods

                                            
                                            
                                           -- measure/metric exploration

select * from gold_dim_branches;

select 
    count(branch_id) as total_branches
from gold_dim_branches;  -- 12 branches

--  customers
select * from gold_dim_customers;

select 
    count(customer_id) as total_customers
from gold_dim_customers; -- 3000 customers

-- employees
select * from gold_dim_employees;

    select count(employee_id) as total_employees
from gold_dim_employees; -- 180 employees

-- vehicles
select * from gold_dim_vehicles;

select
    count(distinct vehicle_id) as total_vehicels
from gold_dim_vehicles;  -- 3449 vehicles

-- part_inventory
select * from gold_fact_part_inventory;

select
    count(inventory_id) as total_inventory,
    sum(unit_cost) as total_unit_cost,
    sum(quantity_on_hand) as total_quantity
from gold_fact_part_inventory;  -- 180, 20597 and 13510

-- service_order_items
select * from gold_fact_service_order_items;

select
    count(item_id) as total_items,
    count(distinct order_id) as total_orders,
    sum(quantity) as total_quantity,
    sum(unit_price) as total_unit_price,
    sum(line_total) as total_revenue
from gold_fact_service_order_items; -- 19085	10074	20782	3109250.28	3136201.92


-- service_orders
select * from gold_fact_service_orders;
select 
    count(distinct order_id) as total_orders,
    count(distinct customer_id) as total_customers,
    count(distinct vehicle_id) As total_vehicles,
    count(distinct branch_id) As total_branches,
    count (distinct employee_id) as total_employees
from gold_fact_service_orders; --  12000	2028	3352	12	180



                                                -- date exploration

select * from gold_dim_branches;

select 
    min(open_date) As branch_earliest_open_date,
    max(open_date) as branch_latest_open_date,
    datediff(year, min(open_date), max(open_date)) as timespan
from gold_dim_branches;  -- earliest 2018-12-14 and	latest 2023-11-22 and the timespan is 5 years

-- customers
select 
* from gold_dim_customers;

select 
    min(signup_date) As earliest_customer_date,
    max(signup_date) as latest_latest_date
from gold_dim_customers;  -- earliest 2020-09-04 and latest 2026-09-03

-- Employees
select 
    min(hire_date) as earliest_hire_date,
    max(hire_date) as latest_hire_date
from gold_dim_employees;  -- earliest 2019-09-11 and latest 2026-08-25

--
select * from gold_fact_part_inventory;

select 
    min(last_restock_date) as earliest_restock,
    max(last_restock_date) as latest_restock
from gold_fact_part_inventory;  -- earliest 2026-06-07 and latest 2026-09-04

--
select * from gold_fact_service_orders;
select 
    min(order_date) as earliest_order,
    max(order_date) as latest_order
from gold_fact_service_orders;  -- earliest 2023-01-01 and latest 2025-12-31

                                                    -- magnitude exploration


-- Q1 which branch generated the highest revenue

select
    b.branch_name,
    sum(oi.unit_price * oi.quantity) as total_revenue
from gold_dim_branches as b
    left join gold_fact_service_orders as so
on b.branch_id = so.branch_id
    left join gold_fact_service_order_items as oi
on so.order_id = oi.order_id
group by b.branch_name
order by total_revenue desc;  -- BigGarage Minneapolis	281896.42

-- Q1 which region generated the highest revenue

select
    b.region,
    sum(oi.unit_price * oi.quantity) as total_revenue
from gold_dim_branches as b
    left join gold_fact_service_orders as so
on b.branch_id = so.branch_id
    left join gold_fact_service_order_items as oi
on so.order_id = oi.order_id
group by b.region
order by total_revenue desc; -- North	823070.69


-- customers
-- Q1 which state have highest customers
select * from gold_dim_customers;

select 
    state,
    count(*) as total_customers
from gold_dim_customers
group by state
order by total_customers desc;  -- SC state have highest customers

-- Q2 which tiers have highest customers
select 
    membership_tier,
    count(*) as total_customers
from gold_dim_customers
group by membership_tier
order by total_customers desc; -- standard tier have highest customers (Standard	1676)

-- Q3 which customers have the highest spennds
select 
    c.customer_id,
    c.customer_name,
    sum(oi.quantity * oi.unit_price) as customer_spends
from gold_dim_customers as c
    left join gold_fact_service_orders as so
on c.customer_id = so.customer_id
    left join gold_fact_service_order_items as oi
on so.order_id = oi.order_id
group by c.customer_id,c.customer_name
order by customer_spends desc; -- 1786	Jill Kemp	8466.81 most spending customers


-- employees
-- Q1 highest and lowest salary in each role
select * from gold_dim_employees;
select
    role ,
    max(salary) as highest_salary,
    min(salary) as lowest_salary
from gold_dim_employees
group by role
order by highest_salary desc; -- Branch manager have highest salary and apprentice have lowest salary

-- Q2 which role have highest number of customers
select 
    role as department,
    count(*) as total_customers
from gold_dim_employees
group by role
order by total_customers desc;  -- Mechanic	role have highest amount of employees

-- vehicles
select * from gold_dim_vehicles;
-- Q1 which company have the highest number of vehicles
select 
make,
    count(*) as total_vehicels
from gold_dim_vehicles
group by make
order by total_vehicels desc;  -- Nissan	510

-- Q2 which car brand give the highest mileage
select
    make,
    fuel_type,
    max(mileage) as highest_mileage
from gold_dim_vehicles
group by make,fuel_type
order by highest_mileage desc; -- chevrolet Hybrid	179998


-- fact_part_inventory

select * from 
(
select top 1
    part_name,
    unit_cost as max_cost
from gold_fact_part_inventory
order by unit_cost desc) as max_part
union all
select * from 
(
select top 1
    part_name,
    unit_cost as min_cost
from gold_fact_part_inventory                                   
order by unit_cost asc) as min_part;   --Oil Filter	219.41    Car Battery	9.72


--  highest reorder level and minimum reorders
select
    part_name,
    max(reorder_level) as maximium_orders_items,
    min(reorder_level) as miniuin_reorder_level
from gold_fact_part_inventory
group by part_name;

-- service_order_items
-- Q1 maximum service discount
select 
    max(discount_pct) as maximum_discount,
    min(discount_pct) as minimum_discount
from gold_fact_service_order_items;  -- max is 15 and min is 0

-- Q2 maximum labor hour 
select 
    max(labor_hour)
from gold_fact_service_order_items;  -- 3.0

-- Q3 total detucted amount 
select 
    sum(line_total) as net_revenue,
    sum(quantity * unit_price) as gross_revenue,
    sum(quantity * unit_price) - sum(line_total) as deducted_amount
from gold_fact_service_order_items;

-- Q4 which service categoty generated the highest revenue
select
    service_name,
    sum(line_total) as total_revenue
from gold_fact_service_order_items
group by service_name
order by total_revenue desc; -- Tire Replacement (set of 4)	877665.04 generated the highest revenue


-- service orders
select * from gold_fact_service_orders;
-- Q1 which payment method customers most used
select 
    payment_method,
    count(*) as total_customers
from gold_fact_service_orders
group by payment_method
order by total_customers desc;  -- insurance have the highest amount

-- Q2 how many customers status are in proggress or completed
select
    status,
    count(customer_id) as total_customers
from gold_fact_service_orders 
group by status;                              -- Cancelled	1926
                                                -- Completed	8089
                                                    -- In Progress	1985


                                                    -- Ranking Exploration
-- Q1 rank order items category by revenue
select 
    category,
    sum(line_total) as net_revenue,
    row_number() over (order by sum(line_total) desc) as ranks
from gold_fact_service_order_items
group by category;



-- Q2 Rank branch by employees and customers
select 
    b.branch_name,
    b.region,
    count(distinct so.customer_id) as total_customers,
    count(distinct so.employee_id) as total_employees,
    dense_rank() over (order by count(distinct so.customer_id) desc) as rank_customers,
    dense_rank() over (order by count(distinct so.employee_id) desc) as rank_employee
from gold_dim_branches as b
     left join gold_fact_service_orders as so
on b.branch_id = so.branch_id
group by b.branch_name,b.region;

-- Q3 top 10 customers by spending
with customer_spending as 
(
    select
    c.customer_id,
    c.customer_name,
    sum(oi.line_total) as customer_spending,
    row_number() over (order by sum(line_total) desc) as ranks
from gold_dim_customers as c
    left join gold_fact_service_orders as so
on c.customer_id = so.customer_id
    left join gold_fact_service_order_items as oi
on so.order_id = oi.order_id
group by 
    c.customer_id,
    c.customer_name
)
select 
* 
from customer_spending
where ranks <= 10;


-- Q4 rank top 5 part name by cost
select 
top 5
    part_name,
    unit_cost,
    row_number () over (order by unit_cost desc) as ranks
from gold_fact_part_inventory;






