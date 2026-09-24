use Big_garage_db

create view gold_dim_branches as 
	select 
	branch_id, 
	branch_name,
	city,
	stage as state,
	region,
	open_date,
	manager_name,
	bay_count
from silver_branches;


create view gold_dim_customers as 
select 
	customer_id,
	customer_name,
	email,
	phone,
	city,
	state,
	signup_date,
	membership_tier,
	marketing_opt_in
from silver_customers


create view gold_dim_employees as 
select 
	employee_id,
	employee_name,
	branch_id,
	role,
	hire_date,
	salary,
	email,
	phone
from silver_employees


create view gold_dim_vehicles as 
select 
	vehicle_id,
	customer_id,
	make,
	year,
	vin,
	mileage,
	fuel_type
from silver_vehicles;


create view gold_fact_service_orders as 
	select 
	order_id,
	customer_id,
	vehicle_id,
	branch_id,
	employee_id,
	order_date,
	status,
	payment_method,
	customer_rating
from silver_service_orders;


create view gold_fact_service_order_items as 
select 
	item_id,
	order_id,
	service_name,
	category,
	quantity,
	unit_price,
	labor_hour,
	discount_pct,
	line_total
from silver_service_order_items;


create view gold_fact_part_inventory as
select 
	inventory_id,
	branch_id,
	part_name,
	unit_cost,
	quantity_on_hand,
	reorder_level,
	last_restock_date
from silver_part_inventory;


