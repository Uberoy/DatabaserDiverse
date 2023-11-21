--CREATE DATABASE BookStoreDb;

--USE BookStoreDb;

BEGIN -- Uppskapande av tabeller
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
Name nvarchar(max) not null,
Address nvarchar(max) not null);

CREATE TABLE StockTbl(
StoreID int not null,
ISBN13 bigint not null,
Amount int not null,
PRIMARY KEY (StoreID, ISBN13));

--1/4 extra tabell--
CREATE TABLE CustomerTbl(
UserName nvarchar(max) not null,
FirstName nvarchar(max) not null,
LastName nvarchar(max) not null,
PhoneNumber int not null);

--2/4 extra tabell--

CREATE TABLE RegisteredUsersTbl(
UserName nvarchar(max),
RegisteredStoreID int FOREIGN KEY REFERENCES StoresTbl(ID));

--3/4 extra tabell--
CREATE TABLE ReviewTbl(
ISBN13 bigint FOREIGN KEY REFERENCES BooksTbl(ISBN13),
Score float);

--4/4 extra tabell--
CREATE TABLE OrderTbl(
OrderID int PRIMARY KEY,
StoreID int not null,
Item int not null);
--Jag tänker att item ska kopplas till ett unikt ID som böcker har och kanske lägga till andra produkter också och då blir ISBN en dålig kolumn att kolla på.
--Antar att "Item" ska vara en FOREIGN KEY i så fall men osäker.

END

BEGIN -- Populera exempel till AuthorTbl
INSERT INTO AuthorTbl 
VALUES (1, 'Agatha', 'Christie', '1890-09-15 00:00:00.000');
INSERT INTO AuthorTbl 
VALUES (2, 'Max', 'Stirner', '1806-10-25 00:00:00.000');
INSERT INTO AuthorTbl 
VALUES (3, 'Friedrich', 'Nietzsche', '1844-10-15 00:00:00.000');
INSERT INTO AuthorTbl 
VALUES (4, 'Michel', 'Foucault', '1926-10-15 00:00:00.000');
END

BEGIN -- Populera exempel till BooksTbl
INSERT INTO BooksTbl
VALUES (9783847267508, 'Der Einzige Und Sein Eigentum', 'Tyska', 375, '2012-05-11 00:00:00.000', 2);
INSERT INTO BooksTbl
VALUES (1620490072, 'Stirners Critics', 'Engelska', 150, '2012-01-01 00:00:00.000', 2);
INSERT INTO BooksTbl
VALUES (9789188745989, 'Och så var de bara en', 'Svenska', 149, '2018-03-05 00:00:00.000', 1);
INSERT INTO BooksTbl
VALUES (9789175471679, 'Poirots jul', 'Svenska', 179, '2014-11-28 00:00:00.000', 1);
INSERT INTO BooksTbl
VALUES (9789189007130, 'Dolken från Tunis', 'Svenska', 199, '2019-09-01 00:00:00.000', 1);
INSERT INTO BooksTbl
VALUES (9789175470900, 'Mordet på Orientexpressen', 'Svenska', 199, '2014-09-01 00:00:00.000', 1);
INSERT INTO BooksTbl
VALUES (9780007527526, 'Murder of Roger Ackroyd', 'Engelska', 138, '2013-09-26 00:00:00.000', 1);
INSERT INTO BooksTbl
VALUES (9780141395838, 'Beyond Good and Evil', 'Engelska', 257, '2014-11-06 00:00:00.000', 3);
INSERT INTO BooksTbl
VALUES (9780140441185, 'Thus Spoke Zarathustra', 'Engelska', 499, '1974-02-28 00:00:00.000', 3);
INSERT INTO BooksTbl
VALUES (9780141195377, 'On the Genealogy of Morals', 'Engelska', 93, '2013-11-07 00:00:00.000', 3);
END

BEGIN -- Populera exempel till CustomerTbl
INSERT INTO CustomerTbl
VALUES ('joajan', 'Joacim','Jansson', 0738123456);

INSERT INTO CustomerTbl
VALUES ('nikhje', 'Niklas','Hjelm', 0738224466);
END

BEGIN -- Populera exempel till OrderTbl
INSERT INTO OrderTbl
VALUES (012345, 1,1337);
END

BEGIN -- Populera exempel till RegisteredUsersTbl

INSERT INTO RegisteredUsersTbl
VALUES ('joajan', 1);

END

BEGIN -- Populera exempel till ReviewTbl

INSERT INTO ReviewTbl
VALUES (9783847267508, 8.8);

END 

BEGIN -- Populera exempel till StockTbl

INSERT INTO StockTbl
VALUES (1, 9783847267508, 19);
INSERT INTO StockTbl
VALUES (1, 1620490072, 9);
INSERT INTO StockTbl
VALUES (1, 9789188745989, 100);
INSERT INTO StockTbl
VALUES (1, 9789175471679, 200);
INSERT INTO StockTbl
VALUES (2, 9780141195377, 2000);
INSERT INTO StockTbl
VALUES (2, 9780140441185, 2000);
INSERT INTO StockTbl
VALUES (3, 9780007527526, 1);
INSERT INTO StockTbl
VALUES (3, 9789189007130, 1);
INSERT INTO StockTbl
VALUES (3, 9783847267508, 1);
INSERT INTO StockTbl
VALUES (3, 1620490072, 1);
INSERT INTO StockTbl
VALUES (3, 9789188745989, 1);
INSERT INTO StockTbl
VALUES (3, 9789175471679, 1);
INSERT INTO StockTbl
VALUES (3, 9789175470900, 1);
INSERT INTO StockTbl
VALUES (3, 9780141395838, 1);

END

BEGIN -- Populera exempel till StoresTbl
INSERT INTO StoresTbl
VALUES (1, 'Adlibris', 'Hittepågatan 15');
INSERT INTO StoresTbl
VALUES (2, 'Bokus', 'Fantasivägen 2');
INSERT INTO StoresTbl
VALUES (3, 'Akademibokhandeln', 'Låtsasröset 100');
END

CREATE VIEW [TitlesPerAuthorView] AS
SELECT	FirstName + ' ' + LastName AS [Name], 
		DATEDIFF(YEAR, Birthday, GETDATE()) AS Age,
		COUNT(AuthorID) AS NumberOfTitles,
		SUM(BooksTbl.Price * StockTbl.Amount) AS TotalValue
FROM AuthorTbl
JOIN BooksTbl ON AuthorTbl.ID = BooksTbl.AuthorID
JOIN StockTbl ON BooksTbl.ISBN13 = StockTbl.ISBN13 
GROUP BY FirstName, LastName, Birthday; -- Skapa exempelvy som visar "Titlar per författare"

CREATE PROCEDURE MoveBooksInStock 
    @MoveFrom int, 
    @MoveTo int, 
    @Book bigint, 
    @Amount int = 1
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @CanMoveFrom BIT, @CanMoveTo BIT;

    -- Check conditions for @MoveFrom
    SELECT @CanMoveFrom = CASE WHEN Amount >= @Amount AND Amount > 0 THEN 1 ELSE 0 END
    FROM StockTbl WITH (UPDLOCK)
    WHERE StoreId = @MoveFrom AND ISBN13 = @Book;

    -- Check if @MoveTo row exists
    SELECT @CanMoveTo = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM StockTbl WITH (UPDLOCK)
    WHERE StoreId = @MoveTo AND ISBN13 = @Book;

    -- Move books from @MoveFrom
    IF @CanMoveFrom = 1
    BEGIN
        UPDATE StockTbl
        SET Amount = Amount - @Amount
        WHERE StoreId = @MoveFrom AND ISBN13 = @Book;
    END

    -- Move books to @MoveTo only if books were successfully moved from @MoveFrom
    IF @CanMoveFrom = 1
    BEGIN
        IF @CanMoveTo = 1
        BEGIN
            UPDATE StockTbl
            SET Amount = Amount + @Amount
            WHERE StoreId = @MoveTo AND ISBN13 = @Book;
        END
        ELSE
        BEGIN
            -- If @MoveTo row does not exist, consider an INSERT or handle accordingly
            INSERT INTO StockTbl (StoreId, ISBN13, Amount)
            VALUES (@MoveTo, @Book, @Amount);
        END
    END

    -- Commit or Rollback the transaction
    IF @@ERROR = 0
        COMMIT;
    ELSE
        ROLLBACK;
END;


EXEC MoveBooksInStock @MoveFrom = 3, @MoveTo = 2, @Book = 1620490072, @Amount = 8

