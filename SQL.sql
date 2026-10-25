create database new_projects;
use new_projects;
CREATE TABLE Restaurants (
    restaurant_id   INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    location        VARCHAR(150),
    cuisine         VARCHAR(50)
);

CREATE TABLE Menu (
    menu_id         INT PRIMARY KEY,
    restaurant_id   INT,
    item_name       VARCHAR(100),
    price           DECIMAL(8,2),
    availability    varchar(50),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);


CREATE TABLE Customers (
    customer_id     INT PRIMARY KEY,
    customer_name   VARCHAR(100),
    phone           VARCHAR(15),
    city            VARCHAR(50)
);

CREATE TABLE Orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT,
    menu_id         INT,
    quantity        INT,
    order_date      DATE,
    order_status    VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (menu_id) REFERENCES Menu(menu_id)
);

CREATE TABLE Payments (
    payment_id      INT PRIMARY KEY,
    order_id        INT,
    payment_method  VARCHAR(30),
    amount          DECIMAL(10,2),
    payment_status  VARCHAR(20),
    payment_date    DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Restaurants VALUES
(101,'Spicy Kitchen', 'Hyderabad', 'Indian'),
(102,'Pizza Hub', 'Bengaluru', 'Italian'),
(103,'Dragon Bowl', 'Chennai', 'Chinese'),
(104,'Burger World', 'Vijayawada', 'Fast Food'),
(105,'Ocean Grill', 'Visakhapatnam', 'Seafood');
INSERT INTO menu VALUES
(201,101,'Chicken Biryani',250,'Available'), (202,101,'Paneer Curry',180,'Available'),
(203,102,'Veg Pizza',350,'Available'), (204,102,'Cheese Pasta',280,'Available'),
(205,103,'Noodles',220,'Available'), (206,103,'Fried Rice',240,'Unavailable'),(207,104,'Chicken
Burger',180,'Available'), (208,104,'French Fries',120,'Available'), (209,105,'Grilled
Fish',450,'Available'), (210,105,'Prawn Curry',500,'Available');
INSERT INTO Customers VALUES
(301,'Aarav','9876500001','Hyderabad'),(302,'Bhavya','9876500002','Vijayawada'),
(303,'Charan','9876500003','Vizag'), (304,'Divya','9876500004','Bengaluru'),
(305,'Esha','9876500005','Chennai'), (306,'Farhan','9876500006','Mumbai'),
(307,'Gopi','9876500007','Warangal'), (308,'Harini','9876500008','Guntur'),
(309,'Ishaan','9876500009','Pune'), (310,'John','9876500010','Kochi');
INSERT INTO Orders VALUES
(401,301,201,2,'2026-07-01','Delivered'), (402,302,203,1,'2026-07-02','Delivered'),
(403,303,205,3,'2026-07-03','Preparing'), (404,304,207,2,'2026-07-04','Delivered'),
(405,305,210,1,'2026-07-05','Cancelled'), (406,306,202,2,'2026-07-06','Delivered'),
(407,307,208,4,'2026-07-07','Delivered'), (408,308,209,1,'2026-07-08','Preparing'),
(409,309,204,2,'2026-07-09','Delivered'), (410,310,201,1,'2026-07-10','Delivered'),
(411,301,210,2,'2026-07-11','Preparing'), (412,303,203,1,'2026-07-12','Delivered');
INSERT INTO Payments VALUES
(501,401,'UPI',500,'Paid','2026-07-01'),
(502,402,'Card',350,'Paid','2026-07-02'),
(503,403,'UPI',660,'Paid','2026-07-03'),
(504,404,'Cash',360,'Paid','2026-07-04'),
(505,405,'Card',500,'Refunded','2026-07-05'),
(506,406,'UPI',360,'Paid','2026-07-06'),
(507,407,'Cash',480,'Paid','2026-07-07'),
(508,408,'UPI',450,'Pending','2026-07-08'),
(509,409,'Card',560,'Paid','2026-07-09'),
(510,410,'UPI',250,'Paid','2026-07-10'),
(511,411,'Card',1000,'Pending','2026-07-11'),
(512,412,'Cash',350,'Paid','2026-07-12');
select *from Restaurants;#restaurant_id,restaurant_name,location,cuision
select *from Menu;#menu_id,restaurant_id,item_name,price,availability
select *from Customers;#customer_id,customer_name,phone,city
select *from Orders;#order_id,customer_id,menu_id,quantity,order_date,order_status
select *from Payments;#payment_id,order_id,payment_method,amount,payment_status,payment_date
##Display all restaurants and their cuisine types.
select restaurant_name ,cuisine from restaurants;
#Update the order status from Preparing to Delivered.
update orders set order_status='preparing' where order_status='delivered';
set sql_safe_updates=0;
update orders set order_status='item not available' where customer_id=301;
#Update the order status from Preparing to Delivered.
update orders set order_status='delivered' where order_status='preparing';
#Increase the price of all food items in a specific restaurant by 10%.
update menu set price =price*1.10 where restaurant_id=101;
update menu set price =price*1.10 where menu_id=201;
#?????????????Delete a cancelled order.
delete from orders where order_status='cancelled';
set sql_safe_updates=0;
#Display all restaurant names in uppercase
select upper(restaurant_name) from restaurants;
#Display all menu item names in lowercase.
select lower(item_name) from menu;
#Display the first five characters of each menu item.
select substring(item_name,1,5) from menu;
select substring(restaurant_name,1,5)from restaurants;
#Concatenate the customer name and city.
select concat(customer_name,' ',city) from customers;
#Replace the word Chicken with Grilled in product names.
update menu set item_name=replace(item_name,'chicken','grilled') where item_name like '%chicken%';
#Display last week orders
SELECT *
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 7 DAY
  AND order_date <= CURDATE();

#Display the day name for every order date.
select dayname(order_date) from orders;
#Create a trigger on the Orders table.
## 37 status, order_id, and change date in an Order_Status_History table.
CREATE TABLE Order_Status_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    change_date DATETIME
);
INSERT INTO Order_Status_History (order_id, old_status, new_status, change_date) VALUES
(401, 'Preparing', 'Delivered', '2026-07-01 14:30:00'),
(402, 'Preparing', 'Delivered', '2026-07-02 12:15:00'),
(404, 'Preparing', 'Delivered', '2026-07-04 19:00:00'),
(405, 'Preparing', 'Cancelled', '2026-07-05 10:45:00'),
(406, 'Preparing', 'Delivered', '2026-07-06 13:20:00');
select * from Order_Status_History;
UPDATE Orders 
SET order_status = 'Delivered' 
WHERE order_id = 403;
# 29. Display restaurants that have never received an order
SELECT r.restaurant_name, m.item_name
FROM Menu m
JOIN Restaurants r ON r.restaurant_id = m.restaurant_id
LEFT JOIN Orders o ON o.menu_id = m.menu_id
WHERE o.order_id IS NULL;
#30 Create a view named Customer_Order_History displaying customer name,restaurant name, menu item, quantity, and order status.
select *from Restaurants;#restaurant_id,restaurant_name,location,cuision
select *from Menu;#menu_id,restaurant_id,item_name,price,availability
select *from Customers;#customer_id,customer_name,phone,city
select *from Orders;#order_id,customer_id,menu_id,quantity,order_date,order_status
select *from Payments;#payment_id,order_id,payment_method,amount,payment_status,payment_date

create view customer_order_history as select customers.customer_name,restaurants.restaurant_name,menu.item_name,orders.quantity,orders.order_status from customers join 
orders on customers.customer_id=orders.customer_id join menu on orders.menu_id=menu.menu_id join restaurants on restaurants.restaurant_id=menu.restaurant_id;
select *from customer_order_history;
# 31Create a view named Restaurant_Revenue displaying restaurant name, total orders, and total revenue.
create view restaurant_revenue as select restaurants.restaurant_name,count(order_id) as total_orders,sum(menu.price*orders.quantity) as total_revenue from restaurants join 
menu on restaurants.restaurant_id=menu.restaurant_id join orders on menu.menu_id=orders.menu_id group by restaurants.restaurant_id,restaurants.restaurant_name;
select *from restaurant_revenue;
#32 Retrieve records from both views.
select *from customer_order_history;
select *from restaurant_revenue;
#33 Start a transaction. Update theprice of a menu item. Create a SAVEPOINT. Then update the payment status of an order. Roll back to the savepoint. Commit the transaction.
#14 Display the month and year of each payment.
select month(payment_date) as payment_month,year(payment_date) as payment_year from payments;
#12. Find the number of days since each order was placed.
select order_id,customer_id,menu_id, datediff(curdate(),order_date) as diff_date from orders;
#13. Display the payment date in DD-Monday-YYYY format.
select payment_id,payment_date,date_format(payment_date,'%D-%M-%Y') as format_date from payments;
#15. Count the total number of menu items available in each restaurant.
SELECT r.restaurant_id,
       r.restaurant_name,
       COUNT(m.menu_id) AS available_items
FROM Restaurants r
LEFT JOIN Menu m
       ON m.restaurant_id = r.restaurant_id
      AND m.availability = 'Available'
GROUP BY r.restaurant_id, r.restaurant_name;
select restaurant_id,count(item_name) from menu where availability='available' group by restaurant_id;
#16. Display the average product of menu items for every restaurant.
select restaurant_id, round(avg(price),2) from menu group by restaurant_id;
#33. Start a transaction. Update theprice of a menu item. Create a SAVEPOINT. Then update the payment status of an order. Roll back to the savepoint. Commit the transaction.
start transaction;
update menu set price=price*1.10 where item_name is not null;
savepoint pr1;
update payments set payment_status='paid' where order_id=408;
rollback to savepoint pr1;
commit;
rollback;
select *from menu;
select *from payments;
#34.Create a stored procedure to display all orders placed by a particular customer.
#• Input: customer_id
#• Display: order_id, menu item, quantity, order date, and order status.