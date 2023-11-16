--CTRL + SKIFT + R = Tar bort alla rödrader. Kan behöva refresh:a i "Object Explorer" först

--USE master;
--DROP DATABASE DjurDB;

--CREATE DATABASE DjurDB;
--USE DjurDB;

--CREATE TABLE DjurTbl(
--Id int PRIMARY KEY,
--Namn nvarchar(max) NOT NULL);

--INSERT INTO DjurTbl (Id, Namn)
--VALUES ('1', 'Hamster');
--INSERT INTO DjurTbl (Id, Namn)
--VALUES ('2', 'Hund');
--INSERT INTO DjurTbl (Id, Namn)
--VALUES ('3', 'Katt');
--INSERT INTO DjurTbl (Id, Namn)
--VALUES ('4', 'Kanin');

--SELECT * 
--FROM DjurTbl;

--CREATE DATABASE KlassenDb;
--USE KlassenDb;

--CREATE TABLE KlassenTbl(
--Id int PRIMARY KEY,
--Förnamn nvarchar(max) not null,
--Efternamn nvarchar(max) not null,
--Ålder int,
--Hemort nvarchar(max) not null);

--INSERT INTO KlassenTbl (Id, Förnamn, Efternamn, Ålder, Hemort)
--VALUES (1, 'Joacim', 'Jansson', 31, 'Göteborg');
--INSERT INTO KlassenTbl (Id, Förnamn, Efternamn, Ålder, Hemort)
--VALUES (2, 'Mattias', 'Lavsund', 31, 'Göteborg');
--INSERT INTO KlassenTbl (Id, Förnamn, Efternamn, Ålder, Hemort)
--VALUES (3, 'Tiina', 'Välimäki', 42, 'Göteborg');
--INSERT INTO KlassenTbl (Id, Förnamn, Efternamn, Ålder, Hemort)
--VALUES (4, 'Phu', 'Nguyen', 42, 'Kina');
--INSERT INTO KlassenTbl (Id, Förnamn, Efternamn, Ålder, Hemort)
--VALUES (5, 'Anna', 'Hållinder', 31, 'Göteborg');

--UPDATE KlassenTbl
--SET Ålder = 20
--WHERE NOT Förnamn =  'Joacim';

--SELECT * 
--FROM KlassenTbl
--WHERE Förnamn LIKE '%a%';

--SELECT Förnamn 
--FROM KlassenTbl;