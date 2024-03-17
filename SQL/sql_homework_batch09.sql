create table customers (
  customer_id int,
  customer_name varchar(50)
  
);
create table orders (
  order_id int,
  customer_id int,
  menu_id int,
  order_date date,
  total_price real
  
);
create table pizza_menu (
  menu_id int,
  menu_name varchar(50),
  price real
);
insert into customers values
(1, 'New'),
(2, 'Bamm'),
(3, 'John'),
(4, 'Nunez'),
(5, 'Sarah'),
(6, 'Endo'),
(7, 'Van Dijk'),
(8, 'Diaz'),
(9, 'Gakpo'),
(10, 'Mac Allister'),
(11, 'Elliott'),
(12, 'Robertson'),
(13, 'Alisson Becker'),
(14, 'Kelleher'),
(15, 'Trent Alexander-Arnold');

insert into orders values
(01, 1, 001, '2023-01-01', 399),
(02, 2, 003, '2023-01-01', 389),
(03, 10, 002,'2023-01-01', 420),
(04, 4, 001, '2023-01-02', 399),
(05, 8, 004, '2023-01-02', 490),
(06, 6, 005, '2023-01-02', 590),
(07, 5, 004, '2023-01-03', 490),
(08, 8, 006, '2023-01-03', 399),
(09, 3, 004, '2023-01-03', 490),
(10, 11, 004, '2023-01-04', 490),
(11, 15, 002, '2023-01-04', 420),
(12, 13,004, '2023-01-04', 490),
(13, 12, 006, '2023-01-04', 399),
(14, 2,005, '2023-01-05', 590),
(15, 4,001, '2023-01-05', 399),
(16, 7, 003, '2023-01-05', 389),
(17, 9, 004, '2023-01-05', 490),
(18, 14, 005, '2023-01-06', 590),
(19, 12, 002, '2023-01-06', 420),
(20, 10, 002, '2023-01-07',420);

insert into pizza_menu values
(001, 'Margherita', 399),
(002, 'Tripple Mushroom', 420),
(003, 'Vegetarian', 389),
(004, 'Pepperoni', 490),
(005, 'Some Like It', 590),
(006, 'Hawaiian', 399);


.mode box
.print \n table_customers 
select * from customers;
.print \n table_orders
select * from orders;
.print \n table_pizza_menu
select * from pizza_menu;

-- Query 1:
-- Find the total price of each order
.print \n 1.Find the total price of_each_order
select sum(total_price) as total_price, order_date
from orders
group by order_date
order by total_price desc;

-- Query 2:
-- Find the total price of each order by customer
.print \n 2.Find the total price of_each_order_by customer
select customer_name, sum(total_price) as total_price, order_date
from orders
join customers on orders.customer_id = customers.customer_id
group by customer_name
order by total_price desc;

-- Query 3:
-- Find the total price of each order by menu
.print \n 3.Find the total price of_each order_by menu
select menu_name, sum(total_price) as total_price
from orders
join pizza_menu on orders.menu_id = pizza_menu.menu_id
group by menu_name
order by total_price desc;

-- Query 4:
-- Find the total price more than 400 of each order by customer and menu
-- subquery
.print \n 4.Find the total price more than 400 each order by customer and menu
select customer_name, menu_name, total_price from
  (select customer_name, menu_name, sum(total_price) as total_price, order_date
from orders
join pizza_menu on orders.menu_id = pizza_menu.menu_id
join customers on orders.customer_id = customers.customer_id
group by customer_name, menu_name
order by total_price desc)
where total_price > 400; 



--select * from orders;
--select * from pizza_menu;
--select * from customers;

-- Query 5:
-- strftime
select customer_name, menu_name, sum(total_price) as total_price, order_date
from orders
join pizza_menu on orders.menu_id = pizza_menu.menu_id
join customers on orders.customer_id = customers.customer_id
where STRFTIME('%Y-%m-%d',order_date) = '2023-01-02'
group by customer_name, menu_name;

-- Query 6:
-- วันใด (อา.-จ.) ที่มีคำสั่งซื้อเยอะที่สุดและยอดเท่าใด
.print \n วัน (อา.-จ.) ที่มีคำสั่งซื้อเยอะที่สุดและยอดขายเท่าใด
select 
CASE 
WHEN STRFTIME('%w', order_date) = '0' THEN 'Sunday'
WHEN STRFTIME('%w', order_date) = '1' THEN 'Monday'
WHEN STRFTIME('%w', order_date) = '2' THEN 'Tuesday'
WHEN STRFTIME('%w', order_date) = '3' THEN 'Wednesday'
WHEN STRFTIME('%w', order_date) = '4' THEN 'Thursday'
WHEN STRFTIME('%w', order_date) = '5' THEN 'Friday'
WHEN STRFTIME('%w', order_date) = '6' THEN 'Saturday'
END as day_of_week,
COUNT(*) AS order_count, sum(total_price) as total
FROM orders
group by day_of_week
order by order_count desc, total desc;



