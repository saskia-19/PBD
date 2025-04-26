use PBD_Week8;
-- Nomor 1 [Buatlah 3 buah tabel (Food, Drink, dan Struk)]
create table Food (id_food varchar(8) primary key, food varchar(10), harga int(38));
create table Drink (id_drink varchar(8) primary key, drink varchar(10), harga int(38));
create table Struk (no_struk varchar(8) primary key, id_food varchar(8), id_drink varchar(8), foreign key (id_food) references Food(id_food), foreign key (id_drink) references Drink(id_drink));

-- Nomor 2 [Buatlah query untuk memasukkan data tabel (Food, Drink, dan Struk)]
insert into Drink (id_drink, drink, harga) values 
	("DR001", "Aqua", 2500), 
	("DR002", "Kopi", 3000), 
	("DR003", "Teh", 2000), 
	("DR004", "Susu", 4500);
insert into Food (id_food, food, harga) values 
	("FD001", "KFC", 15000), 
	("FD002", "Rames", 5000), 
	("FD003", "Nasgor", 11000), 
	("FD004", "Nasi Uduk", 6000);
insert into Struk (no_struk, id_food, id_drink) values 
	("ST001", "FD001", "DR002"), 
	("ST002", "FD003", "DR001"), 
	("ST003", "FD004", "DR003"), 
	("ST004", "FD002", "DR003"), 
	("ST005", "FD001", "DR004");

-- Nomor 3 [Buatlah query untuk menampilkan data join tabel Struk, Food, dan Drink]
select 
	s.no_struk, f.food, f.harga, d.drink, d.harga, (f.harga + d.harga) as Total
from Struk s
join Food f on s.id_food = f.id_food
join Drink d on s.id_drink = d.id_drink
order by s.no_struk;

-- Nomor 4
create view Struk_Food_dan_Drink as
select s.no_struk, f.food, d.drink
from Struk s
join food f on s.id_food = f.id_food
join drink d on s.id_drink = d.id_drink;

-- Nomor 5
-- 5a
select
    avg(f.harga + d.harga) AS rataRata,
    min(f.harga + d.harga) AS minimal
from 
    Struk s
join 
    Food f on s.id_food = f.id_food
join 
    Drink d on s.id_drink = d.id_drink;

-- 5b
select 
    (select min(harga) from Food) as "min(harga Food)",
    (select min(harga) from Drink) as "min(harga Drink)"
from dual;

-- 5c
select sum(harga) as "sum(harga)" from Drink;

-- 5d
select avg(harga) as "avg(harga)" from Food;


-- Nomor 6
select 
    s.no_struk,
    d.drink,
    d.harga
from 
    Struk s
join 
    Drink d on s.id_drink = d.id_drink
order by s.no_struk;


-- Nomor 7
select 
    s.no_struk, f.food as Item, f.harga
from 
    Struk s
join 
    Food f on s.id_food = f.id_food
    
union all

select 
    s.no_struk, d.drink as Item, d.harga
from 
    Struk s
join 
    Drink d on s.id_drink = d.id_drink

order by no_struk;


-- Nomor 8
select 
    s.no_struk,
    f.food,
    d.drink,
    (f.harga + d.harga) as Total
from 
    Struk s
join 
    Food f on s.id_food = f.id_food
join 
    Drink d on s.id_drink = d.id_drink
order by Total desc;

