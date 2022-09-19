create database airline_reservation_system;

use airline_reservation_system;

create table flight(
	id varchar(250),
	flightName varchar(250),
	fromCity varchar(250),
	toCity varchar(250),
	flightDate datetime,
	airportName varchar(250),
	price varchar(250),
	description varchar(250)
);

insert into flight values 
("5VJ51", "Jet Airway", "Yangon", "Singapore", "2022-09-20 19:00:00", "Yangon International Airport", 1200, "Description"),
("RTSU5", "AirReport Jet", "Russia", "Japan", "2022-09-27 16:30:00", "Yangon International Airport", 1600, "Demo Description");


create table admin(
	id int primary key auto_increment,
	firstName varchar(250),
	lastName varchar(250),
    email varchar(250),
	password varchar(250)
);

insert into admin(firstName,lastName, email, password) values ('bruce', 'wayne', 'admin@mail.com', 'admin123');


create table user(
	id int primary key auto_increment,
	firstName varchar(250),
	lastName varchar(250),
	email varchar(250),
	password varchar(250)
);

insert into user(firstName, lastName, email, password) values('clark', 'kent', 'clark@mail.com', 'admin123');


create table `order`(
	id int primary key auto_increment,
	flightId varchar(250),
	userId int,
	email varchar(250),
	phoneNumber varchar(250),
	noOfPersons varchar(10),
	address varchar(250)
);