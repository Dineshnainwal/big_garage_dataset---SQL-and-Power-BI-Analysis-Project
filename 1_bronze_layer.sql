--created a database 

create database Big_garage_db;
use Big_garage_db;


                                      -- designing the bronze layer table schema

drop table bronze_branches
create table bronze_branches
(
    branch_id int,
    branch_name nvarchar(50),
    city nvarchar(50),
    stage nvarchar(50),
    region nvarchar(50),
    open_date date,
    manager_name nvarchar(50),
    bay_count int
);

drop table bronze_customers
create table bronze_customers
(
    customer_id int,
    customer_name nvarchar(50),
    email nvarchar(50),
    phone nvarchar(50),
    city nvarchar(50),
    state nvarchar(50),
    signup_date date,
    membership_tier nvarchar(50),
    marketing_opt_in nvarchar(50)
);

drop table bronze_employees
create table bronze_employees
(
    employee_id int,
    employee_name nvarchar(50),
    branch_id int,
    role nvarchar(50),
    hire_date date,
    salary float,
    email nvarchar(50),
    phone nvarchar(50)
);


drop table bronze_part_inventory
create table bronze_part_inventory
(
    inventory_id int,
    branch_id int,
    part_name nvarchar(50),
    unit_cost decimal(10,2),
    quantity_on_hand int,
    reorder_level int,
    last_restock_date date
);


drop table bronze_service_order_items
create table bronze_service_order_items
(
    item_id int,
    order_id int,
    service_name nvarchar(50),
    category nvarchar(50),
    quantity int,
    unit_price decimal(10,2),
    labor_hour decimal(5,1),
    discount_pct int,
    line_total decimal(10,2)
);



drop table bronze_service_orders
create table bronze_service_orders
(
    order_id int,
    customer_id int,
    vehicle_id int,
    branch_id int,
    employee_id int,
    order_date date,
    status nvarchar(50),
    payment_method nvarchar(50),
    customer_rating decimal(10,2)
);


drop table bronze_vehicles
create table bronze_vehicles
(
    vehicle_id int,
    customer_id int,
    make nvarchar(50),
    model nvarchar(50),
    year int,
    vin nvarchar(50),
    mileage int,
    fuel_type nvarchar(50)
);

-- Bulk inserting
truncate table bronze_branches
BULK INSERT bronze_branches
FROM 'D:\MAVEN DATESETS\branches.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

truncate table bronze_customers
bulk insert bronze_customers
from 'D:\MAVEN DATESETS\customers.csv'
with
(
firstrow = 2,
fieldterminator = ',',
rowterminator = '0x0a',
tablock
);

truncate table bronze_employees
bulk insert bronze_employees
from 'D:\MAVEN DATESETS\employees.csv'
with 
(
firstrow = 2,
fieldterminator = ',',
rowterminator = '0x0a',
tablock
);


truncate table bronze_part_inventory
bulk insert bronze_part_inventory
from 'D:\MAVEN DATESETS\parts_inventory.csv'
with
(
firstrow = 2,
fieldterminator = ',',
rowterminator = '0x0a',
tablock
);

truncate table bronze_service_order_items
bulk insert bronze_service_order_items
from 'D:\MAVEN DATESETS\service_order_items.csv'
with
(
firstrow = 2,
fieldterminator = ',',
rowterminator = '0x0a',
tablock
);

truncate table bronze_service_orders
bulk insert bronze_service_orders
from 'D:\MAVEN DATESETS\service_orders.csv'
with
(
firstrow = 2,
fieldterminator = ',',
rowterminator = '0x0a',
tablock
);

truncate table bronze_vehicles
bulk insert bronze_vehicles
from 'D:\MAVEN DATESETS\vehicles.csv' 
with
(
firstrow = 2,
fieldterminator = ',',
rowterminator = '0x0a',
tablock
);



 
