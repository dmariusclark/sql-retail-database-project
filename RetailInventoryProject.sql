-- Retail Inventory and Order Management Database --

Create Database retail_db;
Use retail_db;

Create Table CUSTOMERS (
customer_id	int	primary key Auto_increment,
first_name	varchar(50) not null,
last_name	varchar(50) not null,
email_address	varchar(50) not null,
created_at	DATETIME	Default Current_Timestamp);

Create Table PRODUCTS (
product_id	int	primary key	auto_increment,
product_name	varchar(50)	not null,
product_category	varchar(50)	not null,
product_price	decimal(10,2) not null);

Create Table ORDERS (
order_id	int	primary Key auto_increment,
customer_id	int,
order_date	datetime default current_timestamp,
foreign key (customer_id) references customers (customer_id));

Create Table OrderItems (
Order_Item_ID	int	primary key	auto_increment,
Order_ID	int,
Product_id	int,
quantity	int,
foreign key (order_id)	references orders (order_id),
foreign key (product_id) references products (product_id));

Create Table Inventory (
Product_id	int primary key,
store_quantity	int,
foreign key (product_id) references products (product_id));

Create Table Suppliers (
Supplier_ID	int	primary key auto_increment,
supplier_name	varchar(50) not null,
supplier_email	varchar(50)	not null);

Show Tables;
describe customers;

rename table PRODUCTS to products;
rename table ORDERS to orders;
rename table OrderItems to order_items;
rename table Inventory to inventory;
rename table Suppliers to suppliers;

drop database retail_db;
create database retail_db;
USE retail_db;

Create Table customers (
customer_id	int	primary key not null Auto_increment,
first_name	varchar(50) not null,
last_name	varchar(50) not null,
email_address	varchar(100) not null unique,
created_at	DATETIME not null	Default Current_Timestamp);

Create Table products (
product_id	int	primary key	not null auto_increment,
product_name	varchar(50)	not null,
product_category	varchar(50)	not null,
product_price	decimal(10,2) not null);

Create Table orders (
order_id	int	primary Key not null auto_increment,
customer_id	int not null,
order_date	datetime not null default current_timestamp,
foreign key (customer_id) references customers (customer_id)
on delete cascade);

Create Table order_items (
order_item_id	int	primary key not null	auto_increment,
order_id	int not null,
product_id	int not null,
quantity	int not null check (quantity >0),
foreign key (order_id)	references orders (order_id) on delete cascade,
foreign key (product_id) references products (product_id));

Create Table inventory (
product_id	int primary key not null,
stock_quantity	int not null check (stock_quantity >=0),
foreign key (product_id) references products (product_id));

Create Table suppliers (
supplier_id	int	primary key not null auto_increment,
supplier_name	varchar(50) not null,
supplier_email	varchar(100)	not null unique);

insert into customers (first_name, last_name, email_address)
values
('Trey', 'Jones', 'treyjones1@gmail.com'),
('Mike', 'Lowry', 'lowrymike22@gmail.com'),
('Mary', 'Alice', 'alice17mary@outlook.com'),
('Paul', 'Wright', 'bigshowpaulwright@gmail.com'),
('Sam', 'Richardson', 'samrichardson62@gmail.com');

insert into products (product_name, product_category, product_price)
values
('The Shock Vac', 'Household Appliances', 32.99),
('Deer Sculpture', 'Decor', 5.99),
('Blaket', 'Bedding', 15.99),
('Floor Lamp', 'Lighting', 17.99),
('Lawn Chair', 'Outdoor Seating', 10.99);

select * 
from products;

insert into orders (customer_id)
values
(1),
(2),
(3),
(4),
(5);

insert into order_items (order_id, product_id, quantity)
values
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 5, 2),
(3, 3, 2),
(4, 4, 1),
(5, 5, 1);

insert into inventory (product_id, stock_quantity)
values
(1, 15),
(2, 5),
(3, 103),
(4, 62),
(5, 0);

alter table products
add supplier_id int not null;

insert into suppliers (supplier_name, supplier_email)
values
('TechSource Inc', 'contact@techsource.com'),
('FreshFoods Co', 'info@freshfoods.com'),
('HomeGoods Supply', 'sales@homegoods.com'),
('ElectroWorld', 'support@electroworld.com'),
('OfficePlus', 'sales@officeplus.com');

UPDATE products SET supplier_id = 1 WHERE product_id = 1;
UPDATE products SET supplier_id = 2 WHERE product_id = 2;
UPDATE products SET supplier_id = 3 WHERE product_id = 3;
UPDATE products SET supplier_id = 4 WHERE product_id = 4;
UPDATE products SET supplier_id = 5 WHERE product_id = 5;

alter table products
add constraint fk_products_suppliers
foreign key (supplier_id) references suppliers(supplier_id);

update products
set product_name = 'Blanket'
where product_id = 3;

insert into order_items (order_id, product_id, quantity)
values
(2,4,2),
(4,1,1),
(5,2,3);

alter table products
modify supplier_id Int not null;

-- Join customers to orders using customer_id (1-to-many relationship)
select c.first_name, c.last_name, o.order_id, o.order_date
from customers c 
join orders o
on c.customer_id = o.customer_id;

-- orders to order_items to products to get item level details
select p.product_name, ot.quantity, p.product_price, o.order_id
from orders o
join order_items ot
on o.order_id = ot.order_id
join products p
on ot.product_id = p.product_id;

alter table order_items
add column item_price decimal(10,2);

select *
from order_items;

select *
from products;

update order_items oi
join products p
on oi.product_id = p.product_id
set oi.item_price = p.product_price;

alter table order_items
modify item_price decimal(10,2) not null;

select ot.order_id, p.product_name, ot.quantity, ot.item_price, ot.order_item_id
from order_items ot
join products p
on ot.product_id = p.product_id;

select ot.order_id, sum(ot.item_price*ot.quantity) as total_order_value
from order_items ot
group by ot.order_id;

select p.product_name, i.stock_quantity, s.supplier_name
from products p
join inventory i
on p.product_id = i.product_id
join suppliers s
on p.supplier_id = s.supplier_id;

select c.first_name, c.last_name, count(o.order_id) as number_of_orders
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) >1