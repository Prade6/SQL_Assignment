create database TechShop
--TASK 1 CREATING TABLES

--CREATING TABLE CUSTOMERS
create table Customers(
CustomerID int not null primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Email varchar(20) not null,
Phone bigint not null,
[Address] varchar(70) not null
)

--CREATING TABLE PRODUCTS
create table Products(
ProductID int identity(101,1) not null primary key,
ProductName varchar(40) not null,
[Description] varchar(200) not null,
Price decimal(10,2) not null
)

--CREATING ORDERS
create table Orders(
OrderID int not null primary key,
CustomerID int,
OrderDate datetime not null,
TotalAmount decimal(10,2) not null,
foreign key(CustomerID) references Customers(CustomerID) on delete cascade
)

--CREATING ORDERDETAILS
create table OrderDetails(
OrderDetailID int identity(1,1) not null primary key,
OrderID int,
ProductID int,
Quantity int not null,
foreign key(OrderID) references Orders(OrderID) on delete cascade,
foreign key(ProductID) references Products(ProductID) on delete cascade
)

--CREATING TABLE INVENTORY
create table Inventory(
InventoryID int identity(1,1) not null primary key,
ProductID int,
QuantityInStock int not null,
LastStockUpdate date not null,
foreign key(ProductID) references Products(ProductID) on delete cascade
)

insert into Customers values (1,'Pradeepa','S','prade123@gmail.com',9825676543,'Karur'), 
							 (2,'Saranya','M','saranya@gmail.com',9087564321,'Madurai'),
							 (3,'Sariba','A','saribs23@gmail.com',9234198564,'Banglore'),
							 (4,'Sanjai','S','sanjs24@gmail.com',9432575849,'Chennai'),
							 (5,'Nithish','C','nithish@gmail.com',9453678326,'Trichy'),
							 (6,'Sathish','T','sathish@gmail.com',9723408652,'Coimbatore'),
							 (7,'Sujith','P','sujithp@gmail.com',9567324967,'Karur'),
							 (8,'Nirmal','C','nirmal32@gmail.com',9753288594,'Mumbai'),
							 (9,'Santhosh','A','sandy@gmail.com',9755674439,'Karur'),
							 (10,'Kavin','P','kavin@gmail.com',9856443865,'Velur')

insert into Products values ('ASUS Vivobook Laptop','Intel core 12th Gen',45999),
							('Nothing 2 Phone','128GB with  longest lasting battery',34500),
							('Samsung Series 8 TV ','190cm Ultra HD',599900),
							('FUJIFILM Mini 11 Instant Camera','Real image finder, 0.37×, with target spot',6000),
							('Apple Airpods Pro Headphones','Active noise cancellation for immersive sound',25000),
							('Bose BASS Module Home theatre','thunderous bass in a compact, 25-cm cube with wireless connectivity',36600),
							('Apple Watch ',' Ultra + Titanium Case',90900),
							('REDMI Pad',' 6 GB RAM 128 ROM',14500),
							('Epson L6270 Printer','multifunction printer delivers fast printouts and borderless printing of up to A4 size',25400),
							('Valve Steam Deck','Gaming Console with Carring case, 1280 x 800 LCD Display',81999)

insert into orders values(1,1,'2023-04-12 12:30:30',36600),
						 (2,1,'2023-04-13 02:00:00',81999),
						 (3,4,'2023-05-24 15:25:45',45999),
						 (4,4,'2023-05-25 05:25:45',34500),
						 (5,4,'2023-05-30 15:15:40',90900),
						 (6,5,'2023-06-02 19:00:00',12000),
						 (7,9,'2023-06-22 12:00:00',25000),
						 (8,2,'2023-08-26 13:10:00',14500),
						 (9,2,'2023-09-21',599900),
						 (10,6,getdate(),90900)


insert into OrderDetails values(1,106,1),(2,110,1),(3,101,1),
							   (4,102,1),(5,107,1),(6,104,2),	
							   (7,105,1),(8,108,1),(9,103,1),
							   (10,107,1)


insert into Inventory values(101,20,getdate()),(102,30,getdate()),(103,10,getdate()),(104,5,getdate()),(105,12,getdate()),
							(106,5,getdate()),(107,9,getdate()),(108,14,getdate()),(109,5,9),(110,2,getdate())


select*from Customers
select*from Products
select*from orders
select*from orderdetails
select*from Inventory


--Tasks 2: Select, Where, Between, AND, LIKE:
--1. Write an SQL query to retrieve the names and emails of all customers. 

select concat(FirstName,' ',LastName) as Customer_name,Email from customers

--2. Write an SQL query to list all orders with their order dates and corresponding customer names.

select orderid,concat(FirstName,' ',LastName) as customer_name, OrderDate 
from Orders ,Customers 
where Orders.CustomerID = Customers.CustomerID

--3. Write an SQL query to insert a new customer record into the "Customers" table. Include 
--customer information such as name, email, and address.

insert into customers values(11,'Kumar','J','jkumar@gmail.com',9988654335,'Mumbai')

select*from Customers

--4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by 
--increasing them by 10%.

update products set price=(price*0.10)+Price

select*from Products

--5. Write an SQL query to delete a specific order and its associated order details from the 
--"Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter

select*from Orders

declare @userinput int
set @userinput=8

delete from Orders
where orderID=@userinput

select*from Orders
select*from OrderDetails

--6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, 
--order date, and any other necessary information.

insert into Orders values(11,11,getdate(),6000)
select*from Orders

--to update the order in orderdetails table
insert into OrderDetails values(11,104,1)
select*from OrderDetails

--7. Write an SQL query to update the contact information (e.g., email and address) of a specific 
--customer in the "Customers" table. Allow users to input the customer ID and new contact information.

declare @userid int
set @userid=5
declare @usermail varchar(20)
set @usermail='nithish123@gmail.com'
declare @userphone bigint
set @userphone=9877345783
declare @useradd varchar(50)
set @useradd='karur'

update Customers set Email=@usermail,Phone=@userphone,[Address]=@useradd
where CustomerID=@userid
select*from Customers

--8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" 
--table based on the prices and quantities in the "OrderDetails" table.

update Orders set TotalAmount=
							(select od.quantity*p.price
							from OrderDetails od
							join Products p
							on od.ProductID=p.ProductID
							where od.OrderID=orders.OrderID
							)
where orders.OrderID in(select OrderID from OrderDetails) 

--to display the update table
select*from Orders

--9. Write an SQL query to delete all orders and their associated order details for a specific 
--customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.

declare @user_input int
set @user_input=9

delete from Orders
where CustomerID=@user_input

--to display the updated record
select*from OrderDetails
select*from Orders

--10. Write an SQL query to insert a new electronic gadget product into the "Products" table, 
--including product name, category, price, and any other relevant details.

alter table products add category varchar(20)

insert into products values('Samsung','Convertible 5-in-1 Cooling 2024 Model 1.5',25400,'Air Conditioner')

select*from Products

--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from 
--"Pending" to "Shipped"). Allow users to input the order ID and the new status.

alter table orders add status varchar(10)
update orders set status='pending'--updating all orders to pending

declare @id int
set @id=5
declare @orderstatus varchar(10)
set @orderstatus='Shipped'

update Orders set status=@orderstatus
where OrderID=@id

select*from Orders

--12. Write an SQL query to calculate and update the number of orders placed by each customer 
--in the "Customers" table based on the data in the "Orders" table.

alter table customers add Total_Orders int

update Customers
set Total_Orders = (select count(orderid) from Orders
					where orders.CustomerID=customers.CustomerID
					)
			
--to display the updated table			
select*from Customers

--Task 3. Aggregate functions, Having, Order By, GroupBy and Joins:
--1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., 
-- customer name) for each order

select s.OrderID,concat(c.FirstName,' ',c.LastName) as customer_name,c.Phone
from Customers c
join Orders s
on c.CustomerID=s.CustomerID 

--2. Write an SQL query to find the total revenue generated by each electronic gadget product. 
--Include the product name and the total revenue

select p.ProductName,sum(o.TotalAmount) as Total_revenue
from Products p
join OrderDetails od
on p.ProductID=od.ProductID
join Orders o
on o.OrderID=od.OrderID
group by ProductName

--3.Write an SQL query to list all customers who have made at least one purchase. Include their 
--names and contact information.

select distinct concat(c.FirstName,' ',c.LastName) as Customer_name,c.Phone 
from Customers c
join Orders o
on c.CustomerID=o.CustomerID

--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest 
--total quantity ordered. Include the product name and the total quantity ordered.

select top 1 p.ProductName, sum(o.quantity) as Top_ordered 
from Products p
join OrderDetails o
on p.ProductID=o.ProductID
group by p.ProductName
order by top_ordered desc

--If more product has same number of quantity ordered

with cte(productid,total_order,total)
as (select productid,sum(quantity),
DENSE_RANK() over(order by sum(quantity) desc) as total
from OrderDetails  
group by ProductID)

select p.productname,ct.total_order
from products p
join cte ct
on p.ProductID=ct.productid
where total=1

--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding 
--categories.

--Updating category of each product

update Products set category='Laptop' where productname like '%Laptop%'
update Products set category='Phone' where productname like '%Phone%'
update Products set category='TV' where productname like '%TV%'
update Products set category='Camera' where productname like '%Camera%'
update Products set category='Headphones' where productname like '%Headphones%'
update Products set category='Home Theatres' where productname like '%Theatre%'
update Products set category='Smart Watches' where productname like '%Watch%'
update Products set category='Tablets' where productname like '%Pad%'
update Products set category='Printers' where productname like '%Printer%'
update Products set category='Gaming Console' where [description] like '%Gaming Console%'

select a.productname , b.category
from products a
join Products b
on a.ProductID=b.ProductID


--6. Write an SQL query to calculate the average order value for each customer. Include the 
--customer's name and their average order value.

select c.FirstName, avg(o.TotalAmount) as Avg_order_value
from Orders o
join Customers c
on o.CustomerID=c.CustomerID
group by c.FirstName

--7. Write an SQL query to find the order with the highest total revenue. Include the order ID, 
--customer information, and the total revenue.

select top 1 o.OrderID,c.CustomerID,concat(c.FirstName,' ',c.lastname) as Customer_name,o.TotalAmount 
from Orders o
join Customers c
on o.customerid=c.customerid
order by o.TotalAmount desc

--If more order has same total revenue as highest

with cte(customerid,orderid,total_amount,total)
as (select customerid,orderid, TotalAmount,
DENSE_RANK() over(order by TotalAmount desc) as total
from Orders o )

select ct.orderid,ct.customerid,firstname,ct.Total_amount
from Customers c
join cte ct
on c.CustomerID=ct.customerid
where total=1

--8. Write an SQL query to list electronic gadgets and the number of times each product has been 
--ordered.

select p.ProductName,count(o.ProductID) as Total_count
from products p
left join OrderDetails o
on o.ProductID=p.ProductID
group by p.ProductName


--9. Write an SQL query to find customers who have purchased a specific electronic gadget product. 
--Allow users to input the product name as a parameter.

declare @productinput varchar(20)
set @productinput='ASUS Vivobook Laptop'

select concat(c.FirstName,' ',c.lastname) as Customer_name
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails od
on o.OrderID=od.OrderID
join Products p
on p.ProductID=od.ProductID
where @productinput=p.ProductName

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a 
--specific time period. Allow users to input the start and end dates as parameters.

declare @sdate datetime
set @sdate='2023-01-01'
declare @edate datetime
set @edate='2023-07-24'

select sum(o.TotalAmount) as total_revenue
from Orders o
where o.OrderDate between @sdate and @edate

--Task 4. Subquery and its type:
--1. Write an SQL query to find out which customers have not placed any orders.

select concat(FirstName,' ',LastName) as Customer_name 
from Customers
where CustomerID <>all (
						select c.CustomerID from Customers c
						join orders o
						on o.CustomerID=c.CustomerID
					  )

--2. Write an SQL query to find the total number of products available for sale. 

select Total_product_for_sale 
from(select count(QuantityInStock) as Total_product_for_sale
from Inventory
where QuantityInStock>0)Total_stock


--3. Write an SQL query to calculate the total revenue generated by TechShop. 

select Total_revenue
from (select sum(TotalAmount) as Total_revenue
from Orders) as Total

--4. Write an SQL query to calculate the average quantity ordered for products in a specific category. 
--Allow users to input the category name as a parameter.

declare @category varchar(20)
set @category='Camera'

select avg(od.quantity) as Avg_ordered_quantity
from OrderDetails od
where od.ProductID =(select ProductID
                     from Products
					 where Category=@category)

--5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users 
--to input the customer ID as a parameter.

declare @customer_id int
set @customer_id=4

select sum(totalamount) as customer_revenue
from Orders
where CustomerID in (select distinct CustomerID 
				  from Orders
				  where CustomerID=@customer_id
				  )

--6. Write an SQL query to find the customers who have placed the most orders. List their names 
--and the number of orders they've placed.


select concat(FirstName,' ',LastName) as Customer_name,Total_Orders
from Customers
where Total_Orders=(select max(Total_Orders)
				    from Customers) 


--7. Write an SQL query to find the most popular product category, which is the one with the highest 
--total quantity ordered across all orders.

select Category,Total
from(
	select top 1 p.Category,sum(o.quantity) as Total
	from Products p
	join OrderDetails o
	on p.ProductID=o.ProductID
	group by p.Category
	order by total desc
	) as Total_quantity_ordered


--If any category tied

with cte(productid,total_order,total)
as (select o.productid, sum(quantity) as total_order,
DENSE_RANK() over(order by sum(quantity) desc) as total
from OrderDetails o
join Products p
on o.ProductID=p.ProductID
group by o.ProductID)

select p.category,total_order
from Products p
join cte c
on c.productid=p.ProductID
where total=1									

--8. Write an SQL query to find the customer who has spent the most money (highest total revenue) 
--on electronic gadgets. List their name and total spending.

select firstname,Highest_revenue
from(
	select top 1 c.firstname, sum(o.TotalAmount) as Highest_revenue
	from Orders o
	join Customers c
	on o.CustomerID=c.CustomerID
	group by c.FirstName
	order by Highest_revenue desc
	) as Customer_revenue

--If the total revenue of customers tied

with cte(customer_id,Highest_revenue,total)
as (select CustomerID, sum(TotalAmount) as total_revenue,
DENSE_RANK() over(order by sum(TotalAmount) desc) as total
from Orders
group by CustomerID)

select firstname,Highest_revenue
from Customers c
join cte ct
on c.CustomerID=ct.customer_id
where total=1


--9. Write an SQL query to calculate the average order value (total revenue divided by the number of 
--orders) for all customers.

select firstname,Avg_order_value
from (select c.firstname, avg(o.TotalAmount) as Avg_order_value
	from Orders o
	join Customers c
	on o.CustomerID=c.CustomerID
	group by c.FirstName
	) as Average_order

--10. Write an SQL query to find the total number of orders placed by each customer and list their 
--names along with the order count

select concat(FirstName, ' ', LastName) AS CustomerName, Total_Orders
from Customers

