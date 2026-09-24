	
										--designing the table schema of silver layer

use Big_garage_db;

create table silver_branches
(
    branch_id int,
    branch_name nvarchar(50),
    city nvarchar(50),
    stage nvarchar(50),
    region nvarchar(50),
    open_date date,
    manager_name nvarchar(50),
    bay_count int, 
    create_date datetime2 default getdate()  -- Creating a metadata column
);

--
create table silver_customers
(
    customer_id int,
    customer_name nvarchar(50),
    email nvarchar(50),
    phone nvarchar(50),
    city nvarchar(50),
    state nvarchar(50),
    signup_date date,
    membership_tier nvarchar(50),
    marketing_opt_in nvarchar(50),
    create_date datetime2 default getdate()  -- Creating a metadata column
);


create table silver_employees
(
    employee_id int,
    employee_name nvarchar(50),
    branch_id int,
    role nvarchar(50),
    hire_date date,
    salary float,
    email nvarchar(50),
    phone nvarchar(50), 
    create_date datetime2 default getdate()    -- Creating a metadata column
);



create table silver_part_inventory
(
    inventory_id int,
    branch_id int,
    part_name nvarchar(50),
    unit_cost decimal(10,2),
    quantity_on_hand int,
    reorder_level int,
    last_restock_date date,
    create_date datetime2 default getdate()   -- Creating a metadata column
);



create table silver_service_order_items
(
    item_id int,
    order_id int,
    service_name nvarchar(50),
    category nvarchar(50),
    quantity int,
    unit_price decimal(10,2),
    labor_hour decimal(5,1),
    discount_pct int,
    line_total decimal(10,2),
    create_date datetime2 default getdate()   -- Creating a metadata column
);




create table silver_service_orders
(
    order_id int,
    customer_id int,
    vehicle_id int,
    branch_id int,
    employee_id int,
    order_date date,
    status nvarchar(50),
    payment_method nvarchar(50),
    customer_rating decimal(10,2),
    create_date datetime2 default getdate()   -- Creating a metadata column
);



create table silver_vehicles
(
    vehicle_id int,
    customer_id int,
    make nvarchar(50),
    model nvarchar(50),
    year int,
    vin nvarchar(50),
    mileage int,
    fuel_type nvarchar(50),
    create_date datetime2 default getdate()   -- Creating a metadata column
);


-- cleanization the table 



use Big_garage_db;

truncate table silver_branches
insert into silver_branches
(
	branch_id,
	branch_name,
	city,
	stage,
	region,
	open_date,
	manager_name,
	bay_count
)

select
	branch_id,
	trim(branch_name) as branches,
	trim(city) as city,
	trim(stage),
	trim(region) as region,
	open_date,
	trim(manager_name) as manager_name,
	bay_count
from bronze_branches;

--
truncate table silver_customers
insert into silver_customers
(
	customer_id,
	customer_name,
	email,
	phone,
	city,
	state,
	signup_date,
	membership_tier,
	marketing_opt_in
)
select
	customer_id,
	(trim(customer_name)) as customer_name,
	case when trim(email) is null or trim(email) = '' then 'n/a'
		 else trim(email)
	end as email,
	phone,
	trim(city) as city,
	trim(state) as state,
	signup_date,
	trim(membership_tier) as membership_tier,
	case when upper(trim(marketing_opt_in)) in ('F','FALSE') then 'False'
		 when upper(trim(marketing_opt_in)) in ('T','TRUE') then 'True'
		 else 'n/a'
	end as marketing_opt_in
from
(
select 
	*,
	row_number() over (partition by customer_id order by signup_date desc) as row_num
from bronze_customers) x
where row_num = 1;

--
truncate table silver_employees
insert into silver_employees
(
	employee_id,
	employee_name,
	branch_id,
	role,
	hire_date,
	salary,
	email,
	phone
)

select 
	employee_id,
	trim(employee_name) as employee_name,
	branch_id,
	trim(role) as role,
	hire_date,
	salary,
	trim(email) as email,
	phone
from bronze_employees;

-- 
truncate table silver_part_inventory
insert into silver_part_inventory
(
	inventory_id,
	branch_id,
	part_name,
	unit_cost,
	quantity_on_hand,
	reorder_level,
	last_restock_date
)

select
	inventory_id,
	branch_id,
	trim(part_name) as part_name,
	unit_cost,
	quantity_on_hand,
	reorder_level,
	last_restock_date
from bronze_part_inventory;

--
truncate table silver_service_order_items
insert into silver_service_order_items
(
	item_id,
	order_id,
	service_name,
	category,
	quantity,
	unit_price,
	labor_hour,
	discount_pct,
	line_total
)

select 
	item_id,
	order_id,
	trim(service_name) as service_name,
	trim(category) as category,
	quantity,
	unit_price,
	labor_hour,
	discount_pct,
	line_total
from bronze_service_order_items;

-- 
truncate table silver_service_orders
insert into silver_service_orders
(
	order_id,
	customer_id,
	vehicle_id,
	branch_id,
	employee_id,
	order_date,
	status,
	payment_method,
	customer_rating
)

select 
	order_id,
	customer_id,
	vehicle_id,
	branch_id,
	employee_id,
	order_date,
	status,
	case when trim(payment_method) is null then 'n/a'
		 else trim(payment_method)
	end as payment_method,
	customer_rating
from bronze_service_orders;

-- 
truncate table silver_vehicles
insert into silver_vehicles
(
	vehicle_id,
	customer_id,
	make,
	model,
	year,
	vin,
	mileage,
	fuel_type
)

select
	vehicle_id,
	customer_id,
	trim(make) as make,
	model,
	year,
	vin,
	mileage,
	trim(fuel_type) as fule_type
from bronze_vehicles;


