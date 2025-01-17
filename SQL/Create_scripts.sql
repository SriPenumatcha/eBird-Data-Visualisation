drop table if exists Observations;
drop table if exists Species;
drop table if exists Locations;
drop table if exists Observations_temp;

--1. Create Table Species
Create table Species (
	speciesCode varchar not null primary key,
	comName varchar, 
	sciName varchar
);

--2. Create Table Locations
Create table Locations (
	locId varchar not null primary key, 
	locName varchar,
	lat dec, 
	lng dec, 
	locationPrivate boolean,
	subNational2code varchar, 
	subNaitonal2Name varchar, 
	subNational1Code varchar, 
	subNational2Name varchar,
	countryCode varchar,
	countryName varchar
);

--1. Create Table Observations_temp
--this temperary table is used later to add date and time
create table Observations_temp (
	id serial primary key not null,
	locid varchar,
	speciesCode varchar, 
	obsDt text, 
	howMany int,
	obsValid boolean, 
	obsReviewed boolean,
	userDisplayName varchar,
	obsId varchar, 
	checkListId varchar , 
	presenceNoted boolean,
	hasComments boolean,
	firstName varchar, 
	lastName varchar, 
	hasRichMedia boolean,
	evidence varchar, 
	exoticCategory varchar,
	foreign key (locid) references Locations(locid),
	foreign key(speciesCode) references Species(speciesCode)
);


--3. Create Table Observations
create table Observations (
	id serial primary key not null,
	locid varchar,
	speciesCode varchar, 
	obsDt timestamp, 
	howMany int,
	obsValid boolean, 
	obsReviewed boolean,
	userDisplayName varchar,
	obsId varchar, 
	checkListId varchar , 
	presenceNoted boolean,
	hasComments boolean,
	firstName varchar, 
	lastName varchar, 
	hasRichMedia boolean,
	evidence varchar, 
	exoticCategory varchar,
	foreign key (locid) references Locations(locid),
	foreign key(speciesCode) references Species(speciesCode)
);

--Have a look at the created tables with imported data
select * from Locations;
select * from Species;
select * from Observations_temp;
select * from Observations;

--Use the to_timestamp command to convert the data and time text data type to timestamp one and insert into the Observations table:
INSERT INTO Observations (id, locid, speciesCode, obsDt, howMany, obsValid, obsReviewed, userDisplayName, obsId, checkListId, presenceNoted, hasComments, firstName, lastName, hasRichMedia, evidence, exoticCategory)
SELECT id, locid, speciesCode, to_timestamp(obsDt, 'DD/MM/YYYY HH24:MI'), howMany, obsValid, obsReviewed, userDisplayName, obsId, checkListId, presenceNoted, hasComments, firstName, lastName, hasRichMedia, evidence, exoticCategory
FROM Observations_temp;