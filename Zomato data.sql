 
create database if not exists Zomato;

use Zomato;
drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'2017-09-22'),
(3,'2017-04-21');

drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-11-03',2),
(1,'2016-11-03',1),
(3,'2016-10-11',1),
(3,'2017-07-12',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

-- 1. What is the total amount spend by each customer?
select s.userid, sum(p.price)
from sales s 
join product p
on s.product_id = p.product_id
group by s.userid;

-- How many days has each customer visited zomzto?

select userid, count(distinct(created_date))
from sales 
group by userid;

-- 3. what was the first purchase by each customer? 

select * FROM
(SELECT *, rank() over(partition by userid order by created_date)
rnk from sales)
a where rnk = 1;

-- what was the most purchased item in the menu and how many times it was purchased by all customers?

select userid, count(product_id) from sales where product_id =(select  product_id  as sales_count
from sales
group by product_id
order by count(product_id) desc
limit 1
 )
group by userid
;

-- which item was most popular for all users?

select * from
(select *, rank() over(partition by userid order by cnt desc) rnk from
(select userid, product_id, count(product_id) cnt from sales group by userid, product_id)a)b
where rnk =1;  
 



