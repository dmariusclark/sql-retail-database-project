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

select p.product_name, ot.quantity, p.product_price, o.order_id
from orders o
join order_items ot
on o.order_id = ot.order_id
join products p
on ot.product_id = p.product_id;

select c.first_name, c.last_name, o.order_id, o.order_date
from customers c 
join orders o
on c.customer_id = o.customer_id;
