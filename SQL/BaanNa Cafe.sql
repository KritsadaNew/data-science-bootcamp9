-- BaanNa Cafe
-- by Kritsada(New)

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  country VARCHAR(50)
  
);
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  order_date DATE
);
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  unit_price DECIMAL(10,2)
);

CREATE TABLE payments (
  payment_id INT PRIMARY KEY,
  order_id INT,
  payment_method VARCHAR(50)
);
INSERT INTO customers (customer_id, customer_name, country)
VALUES
  (1, 'John Doe', 'USA'),
  (2, 'Wataru Endo', 'Japan'),
  (3, 'Michael Johnson', 'Russia'),
  (4, 'Emily Davis', 'Russia'),
  (5, 'Arjun', 'India'),
  (6, 'Kabir', 'India'),
  (7, 'Do-yun', 'South Korea'),
  (8, 'Seo-yeon', 'South Korea'),
  (9, 'Jun Hao', 'China'),
  (10, 'Ming Wei', 'China'),
  (11, 'Li Mei', 'China'),
  (12, 'Ahmad Daniel','Malaysia'),
  (13, 'Umar Mukmin','Malaysia'),
  (14, 'Siti Sarah','Malaysia'),
  (15, 'Ainaa Sofia','Malaysia'),
  (16, 'Bammm', 'Thailand'),
  (17, 'New','Thailand'),
  (18, 'Wichai','Thailand'),
  (19, 'Mario','Thailand'),
  (20, 'Roberts', 'Thailand');

INSERT INTO products (product_id, product_name, unit_price)
  values
  (1,'Esspresso',50),
  (2,'Americano',60),
  (3,'Cappuccino',70),
  (4,'Latte',80),
  (5,'Jasmine tea',65),
  (6,'Green tea',55),
  (7,'Thai tea',45),
  (8,'Matcha Latte',75);

INSERT INTO orders (order_id, customer_id, product_id, order_date)
  values
  (1,1,1,'2023-01-01'),
  (2,2,1, '2023-01-02'),
  (3,3,2, '2023-01-03'),
  (4,4,3, '2023-01-03'),
  (5,5,7, '2023-01-04'),
  (6,6,4, '2023-01-04'),
  (7,7,5, '2023-01-04'),
  (8,8,6, '2023-01-05'),
  (9,9,7, '2023-01-06'),
  (10,10,8, '2023-01-06'),
  (11,11,2, '2023-01-06'),
  (12,12,7, '2023-01-07'),
  (13,13,6, '2023-01-08'),
  (14,14,7, '2023-01-09'),
  (15,15,5, '2023-01-10'),
  (16,16,1, '2023-01-11'),
  (17,17,4, '2023-01-11'),
  (18,18,2, '2023-01-12'),
  (19,19,8, '2023-01-12'),
  (20,20,3, '2023-01-13');
  
INSERT INTO payments (payment_id, order_id,payment_method)
  values
  (1,1,'Cash'),
  (2,2,'Cash'),
  (3,3,'Online Banking'),
  (4,4,'Visa'),
  (5,5,'Cash'),
  (6,6,'Mastercard'),
  (7,7,'Online Banking'),
  (8,8,'Cash'),
  (9,9,'Online Banking'),
  (10,10,'Online Banking'),
  (11,11,'Mastercard'),
  (12,12,'Visa'),
  (13,13, 'Mastercard'),
  (14,14,'Cash'),
  (15,15, 'Visa'),
  (16,16,'Cash'),
  (17,17,'Online Banking'),
  (18,18,'Online Banking'),
  (19,19,'Cash'),
  (20,20, 'Online Banking');
  

.print #######################
.print #### SQL Challenge ####
.print #######################

.print \n Customers table
.mode box
select * from customers limit 5;

.print \n Orders table
.mode box
select * from orders limit 5;

.print \n Payments table
.mode box
select * from payments limit 5;

.print \n Products table
.mode box
select * from products limit 5;

-- Top 3 country in Baanna Cafe
.print \n top 3 counrty in BaanNa Cafe
select country,count(country) as total_country 
from customers
where country != 'Thailand'
GROUP BY country
order by total_country desc limit 3;

-- Top 3 most popular product
.print \n Top 3 most popular product
select product_name,count(product_name) as top_product
from products
join orders on products.product_id = orders.product_id
group by product_name
order by top_product desc limit 3;

-- day of the week that has the most total price
.print \n Day of the week that has the most total price
select 
  case
   WHEN STRFTIME('%w',order_date) = '0' THEN 'Sunday'
  WHEN STRFTIME('%w',order_date) = '1' THEN 'Monday'
  WHEN STRFTIME('%w',order_date) = '2' THEN 'Tuesday'
  WHEN STRFTIME('%w',order_date) = '3' THEN 'Wendesday'
  WHEN STRFTIME('%w',order_date) = '4' THEN 'Thursday'
  WHEN STRFTIME('%w',order_date) = '5' THEN 'Friday'
  WHEN STRFTIME('%w',order_date) = '6' THEN 'Saturday'
  end
  as day_of_week,
  sum(unit_price) as total_price,
  count(product_name) as amount_product
from orders
join products on orders.product_id = products.product_id
group by day_of_week
order by total_price desc;

-- Top 5 countries with the highest spending
.print \n Top 5 countries with the highest spending
select country,sum(unit_price) total_price
from customers
join orders on customers.customer_id = orders.customer_id
join products on orders.product_id = products.product_id
group by country
order by total_price desc limit 5;

--
.print \n payment method
select payment_method,sum(unit_price) total_price
from payments
join orders on payments.order_id = orders.order_id
join products on orders.product_id = products.product_id
group by payment_method
order by total_price desc;








