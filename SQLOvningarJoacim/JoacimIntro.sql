--CTRL + SKIFT + R = Tar bort alla r�drader. Kan beh�va refresh:a i "Object Explorer" f�rst

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
--F�rnamn nvarchar(max) not null,
--Efternamn nvarchar(max) not null,
--�lder int,
--Hemort nvarchar(max) not null);

--INSERT INTO KlassenTbl (Id, F�rnamn, Efternamn, �lder, Hemort)
--VALUES (1, 'Joacim', 'Jansson', 31, 'G�teborg');
--INSERT INTO KlassenTbl (Id, F�rnamn, Efternamn, �lder, Hemort)
--VALUES (2, 'Mattias', 'Lavsund', 31, 'G�teborg');
--INSERT INTO KlassenTbl (Id, F�rnamn, Efternamn, �lder, Hemort)
--VALUES (3, 'Tiina', 'V�lim�ki', 42, 'G�teborg');
--INSERT INTO KlassenTbl (Id, F�rnamn, Efternamn, �lder, Hemort)
--VALUES (4, 'Phu', 'Nguyen', 42, 'Kina');
--INSERT INTO KlassenTbl (Id, F�rnamn, Efternamn, �lder, Hemort)
--VALUES (5, 'Anna', 'H�llinder', 31, 'G�teborg');

--UPDATE KlassenTbl
--SET �lder = 20
--WHERE NOT F�rnamn =  'Joacim';

--SELECT * 
--FROM KlassenTbl
--WHERE F�rnamn LIKE '%a%';

--SELECT F�rnamn 
--FROM KlassenTbl;