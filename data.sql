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

update products
set product_name = 'Blanket'
where product_id = 3;

insert into order_items (order_id, product_id, quantity)
values
(2,4,2),
(4,1,1),
(5,2,3);

update order_items oi
join products p
on oi.product_id = p.product_id
set oi.item_price = p.product_price;

