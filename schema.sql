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

alter table products
add supplier_id int not null;

alter table products
add constraint fk_products_suppliers
foreign key (supplier_id) references suppliers(supplier_id);

alter table products
modify supplier_id Int not null;

alter table order_items
add column item_price decimal(10,2);

alter table order_items
modify item_price decimal(10,2) not null;
