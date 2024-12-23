

create database bankdb;
 
use  bankdb;
 
create table customers(
customerid int auto_increment  primary key,
firstname varchar(20),
lastname varchar(20),
email varchar(60),
phone varchar(20),
address varchar(200));
 
create table Accounts(
accountid int auto_increment primary key,
customerid int,
accounttype varchar(20),
balance decimal(10,2),
createdate date,
foreign key(customerid) references customers(customerid));
 
create table transactions(
transactionid int auto_increment primary key,
accountid int,
transactiontype varchar(20),
amount decimal(10,2),
transactiondate datetime,
foreign key(accountid) references accounts(accountid)
);
 
 
create table branches (
branchid int auto_increment primary key,
branchname varchar(20),
location varchar(30));
 
 
create table employees(
employeeid int auto_increment primary key,
branchid int,
firstname varchar(30),
lastname varchar(30),
role varchar(20),
salary decimal(10,2),
foreign key(branchid)references branches(branchid));
 
 
insert into customers(firstname,lastname,email,phone,address)
values('john','doe','john.doe@example.com','1234567890','123 Elm St'),
('jane','smith','jane.smith@example.com','9876543210','456 Oak St'),
('michael','brown','michael.brown@example.com','5678901234','789 Pine St');
 
 
use bankdb;
insert into accounts(customerid,accounttype,balance,createdate)
values(1,'savings',5000.00,'2023-01-15'),
(1,'checking',2000.00,'2023-02-10'),
(2,'savings',10000.00,'2023-03-05'),
(3,'savings',7000.00,'2023-04-05');
 
insert into transactions(accountid,transactiontype,amount,transactiondate)
values(1,'deposit',1000.00,'2023-01-20 10:00:00'),
(1,'withdrawal',500.00,'2023-01-25 14:30:00'),
(2,'deposit',2000.00,'2023-02-15 09:15:00'),
(3,'withdrawal',1000.00,'2023-04-25 16:45:00');

 
insert into branches(branchname,location)
values('sbi','pune'),
('hdfc','andhra'),
('icic','mumbai'),
('sbi','chennai');
 
 
insert into employees(branchid,firstname,lastname,role,salary)
values(1,'alce','johnson','manager',75000.00),
(1,'bob','williams','teler',40000.00),
(2,'charlie','davis','manager',70000.00),
(2,'diana','evans','teler',42000.00);
 
 
 
select  c.firstname,c.lastname,a.accountid,a.accounttype
from customers c 
join accounts a
on c.customerid=a.customerid;       
 
 
use bankdb;
select e.firstname,e.lastname,e.salary,b.branchname
from employees e
join branches b
on e.branchid=b.branchid
where e.salary>(select avg(salary)
from employees);
 
 
use bankdb;
select c.firstname,c.lastname,sum(a.balance) as totalbalance,rank() over (order by sum(a.balance) desc) as ranki
from customers c
join accounts a 
on c.customerid=a.customerid
group by c.customerid,c.firstname,c.lastname
 
 
use bankdb;
select c.firstname,c.lastname
from customers c
join accounts a
on c.customerid=a.customerid
left join transactions t
on a.accountid=t.accountid
where t.transactionid is null
 
 
use bankdb;
select c1.firstname as customer1,c2.firstname as customer2,a1.accounttype
from accounts a1
join accounts a2 on  a1.accounttype=a2.accounttype
join customers c1 on a1.customerid=c1.customerid
join customers c2 on a2.customerid=c2.customerid
where c1.customerid<c2.customerid;
 
 