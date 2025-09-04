<<<<<<< HEAD
=======
use hr;
create table shop1(
product_name varchar(30),
price decimal(10,2)
);

alter table shop1 add column Quandity int;

create table shop2(
product_name varchar(30),
price decimal(10,2)
);
alter table shop2 add column Quandity int;
create table shop3(
product_name varchar(30),
price decimal(10,2)
);
alter table shop3 add column Quandity int;


insert into shop1 values('Onion',40.50,1),('Tomato',50,2),('Rice',500,25);

insert into shop2 values('Brinjal',30,1),('Potato',40,1),('Onion',60,2);

insert into shop3 values('Beetroot',40.00,1),
('Tomato',	100.00	,4),('Rice',500.00,2),('Onion',60,2);

select s1.product_name from 
shop1 s1,shop2 s2, shop3 s3 
where s1.product_name = s2.product_name
and s2.product_name = s3.product_name;

select s1.product_name,s2.product_name,s3.product_name from 
shop1 s1 left join shop2 s2 on 
s1.product_name = s2.product_name 
left join shop3 s3 on 
s2.product_name = s3.product_name;

select s1.product_name,s2.product_name,s3.product_name from 
shop1 s1 right join shop2 s2 on 
s1.product_name = s2.product_name 
right join shop3 s3 on 
s2.product_name = s3.product_name;


select * from shop1
union all
select * from shop2
union all
select * from shop3;



>>>>>>> 39ed9a95837c320910ec8faf632a7191fd780b67
use hr;
create table shop1(
product_name varchar(30),
price decimal(10,2)
);

alter table shop1 add column Quandity int;

create table shop2(
product_name varchar(30),
price decimal(10,2)
);
alter table shop2 add column Quandity int;
create table shop3(
product_name varchar(30),
price decimal(10,2)
);
alter table shop3 add column Quandity int;


insert into shop1 values('Onion',40.50,1),('Tomato',50,2),('Rice',500,25);

insert into shop2 values('Brinjal',30,1),('Potato',40,1),('Onion',60,2);

insert into shop3 values('Beetroot',40.00,1),
('Tomato',	100.00	,4),('Rice',500.00,2),('Onion',60,2);

select s1.product_name from 
shop1 s1,shop2 s2, shop3 s3 
where s1.product_name = s2.product_name
and s2.product_name = s3.product_name;

select s1.product_name,s2.product_name,s3.product_name from 
shop1 s1 left join shop2 s2 on 
s1.product_name = s2.product_name 
left join shop3 s3 on 
s2.product_name = s3.product_name;

select s1.product_name,s2.product_name,s3.product_name from 
shop1 s1 right join shop2 s2 on 
s1.product_name = s2.product_name 
right join shop3 s3 on 
s2.product_name = s3.product_name;


select * from shop1
union all
select * from shop2
union all
select * from shop3;



<<<<<<< HEAD
=======
drop function fname;
>>>>>>> 39ed9a95837c320910ec8faf632a7191fd780b67
