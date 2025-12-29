create database Bank_db;
use Bank_db;

create table district(
		district_code int primary key,
        district_name  varchar(100),
        region varchar(100),
        No_of_inhabitants int,
        No_of_municipalities_under_499 int,
        No_of_municipalities_500_1999 int ,
		No_of_municipalities_2000_9999 int,
        No_of_municipalities_above_10000 int,
        No_of_cities int,
        Ratio_of_urban_inhabitants float,
        Average_salary int,
        Unemployment_rate_96 int,
        No_of_entrepreneurs_per_1000_inhabitants int,
        No_committed_crime_2017 int ,
        No_committed_crime_2018 int
);
select * from district;
SELECT COUNT(*) FROM district;

SHOW TABLES IN bank_db;
create table Account(
	account_id int,
    district_id int,
	frequency varchar(40),
	Date date,
	Account_type varchar(40),
	Card_Assigned varchar(40),
    foreign key (district_id) references district(district_code)
);

create table transactions(
 trans_id int,
 account_id int ,
 date date,
 type varchar(30),
 operation varchar(40),
 amount int,
 balance float,
 purpose varchar(40),
 bank varchar(40),
 account int,
 foreign key(account_id) references Account(account_id)
);

create table loan(
loan_id int primary key,
account_id int ,
date date,
amount int,
duration int,
payments int,
status varchar(35),
foreign key(account_id) references Account(account_id)
);

create table Orders(
order_id int primary key,
account_id int ,
bank_to varchar(45),
account_to int,
amount float,
foreign key (account_id) references Account(account_id)
);


create table client (
	client_id int primary key,
    sex char(10),
    birth_date date,
    district_id int ,
    foreign key (district_id) references district(district_code)
);

select * from client;
drop table client;
SHOW CREATE TABLE client;

create table disposition (
	disp_id int primary key,
    client_id int ,
    account_id int,
    type char(15),
    foreign key (client_id) references client(client_id),
    foreign key (account_id) references Account (account_id)
);


create table card(
card_id int primary key,
disp_id int,
type char(10),
issued date,
foreign key(disp_id) references disposition(disp_id)
);







LOAD DATA LOCAL INFILE 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/district.csv'
INTO TABLE district
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/account.csv'
into table Account
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/loan.csv'
into table loan
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/order.csv'
into table orders
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/trnx_16.csv'
into table transactions
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/trnx_17.csv'
into table transactions
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/trnx_18.csv'
into table transactions
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/trnx_19_new.csv'
into table transactions
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/trnx_20_new.csv'
into table transactions
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/trnx_21_new.csv'
into table transactions
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select count(*) from transactions;


load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/client.csv'
into table client
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select count(*) from client;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/disp.csv'
into table disposition
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/USER/Desktop/class codes/Power BI/end to end  project/bank_stud_data/card.csv'
into table card
fields terminated by  ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from card;
select * from district;
select * from Account;
select * from transactions;
select * from loan;
select * from client;
select * from disposition;

-- ---------------------------------- Data Transformation --------------------------------------
select * from transactions;

-- correction in transactions tables 
-- make 2016 -- 2017
-- make 2017 -- 2018
-- make 2018 -- 2019
-- make 2019 -- 2020
-- make 2020 -- 2021
-- make 2021 -- 2022

SELECT DATE_ADD(date, INTERVAL 1 YEAR) AS new_date
FROM transactions;

UPDATE transactions
SET date = DATE_ADD(date, INTERVAL 1 YEAR);

SELECT distinct(YEAR(STR_TO_DATE(date, '%Y-%m-%d'))) AS year_only
FROM transactions;

select count(*) from transactions
where YEAR(STR_TO_DATE(date, '%Y-%m-%d')) = 2017 and bank ="";

select count(*) from transactions
where YEAR(`date`) = 2017 and bank ="";

SELECT YEAR(`date`) FROM transactions;

SELECT YEAR(`date`),count(*) FROM transactions
where bank =""
group by year(`date`);

-- UPDATE transactions
-- SET bank = ''
-- WHERE YEAR(`date`) = 2017   AND bank = '';

UPDATE transactions
SET bank = 'Southern Bank'
WHERE YEAR(`date`) = 2018   AND bank = '';

UPDATE transactions
SET bank = 'Northern Bank'
WHERE YEAR(`date`) = 2019   AND bank = '';

UPDATE transactions
SET bank = 'DBS Bank'
WHERE YEAR(`date`) = 2021   AND bank = '';

update transactions
set bank = 'Sky Bank' 
where year(date) = 2022 and bank='';


-- --------------------- card table ------------------------
select * from card;

select year(issued),count(*) from card
group by year(issued);

update card
set issued = date_add(issued, interval 1 year);

-- ----------------------client  ----------------------------
select * from client;

select distinct(age) from client;

select max(`date`) into @LTD from transactions;

alter table client
add column age int;

update client 
set age = timestampdiff(year,birth_date,@LTD);

