--CREATE DATABASE BookStoreDb;

--USE BookStoreDb;

CREATE TABLE AuthorTbl(
ID int PRIMARY KEY,
FirstName nvarchar(max) not null,
LastName nvarchar(max) not null,
Birthday datetime2 not null);

CREATE TABLE BooksTbl(
ISBN13 bigint PRIMARY KEY,
Title nvarchar(max) not null,
Language nvarchar(max) not null,
Price float not null,
PublicationDate datetime2 not null,
AuthorID int FOREIGN KEY REFERENCES AuthorTbl(ID));

CREATE TABLE StoresTbl(
ID int PRIMARY KEY,
Name nvarchar not null,
Address nvarchar(max) not null);

CREATE TABLE StockTbl(
StoreID int not null,
ISBN13 bigint not null,
Amount int not null,
PRIMARY KEY (StoreID, ISBN13));

--1/4 extra tabell--
CREATE TABLE CustomersTbl(
FirstName nvarchar(max) not null,
LastName nvarchar(max) not null,
PhoneNumber int not null);

--2/4 extra tabell--
CREATE TABLE OrderTbl(
OrderID int PRIMARY KEY,
StoreID int not null,
Item int not null);
--Jag t�nker att item ska kopplas till ett unikt ID som b�cker har och kanske l�gga till andra produkter ocks� och d� blir ISBN en d�lig kolumn att kolla p�.
--Antar att "Item" ska vara en FOREIGN KEY i s� fall men os�ker.