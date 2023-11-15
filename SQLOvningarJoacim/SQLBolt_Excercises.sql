--###SQLBolt###--
--**Lesson 6**--
--�Task 3�--
--SELECT *
--FROM Movies
--INNER JOIN Boxoffice
--    ON Movies.Id = Boxoffice.Movie_id
--ORDER BY Rating DESC;

--**Lesson 7**--
--�Task 1�--
--SELECT DISTINCT Building_name 
--FROM employees
--LEFT JOIN Buildings
--    ON employees.Building = Buildings.Building_name;

--�Task 2�--
--SELECT Building_name, Capacity
--FROM Buildings;

--�Task 3�--
--SELECT DISTINCT Building_name, Role 
--FROM Buildings
--LEFT JOIN Employees
--    ON Buildings.building_name = Employees.Building;


--**Lesson 8**--
--�Task 1�--
--SELECT * 
--FROM employees
--WHERE Building IS NULL;

----�Task 2�--
--SELECT DISTINCT Building_name 
--FROM Buildings
--LEFT JOIN Employees
--    ON Buildings.Building_name = Employees.Building
--WHERE Building IS NULL


--**Lesson 9**--
--�Task 1�--
--SELECT Title, (Domestic_sales + International_sales) / 1000000 AS Sales 
--FROM movies
--INNER JOIN Boxoffice
--    ON Id = Movie_id;

--�Task 2�--
--SELECT Title, Rating * 10 AS 'Rating in Percent'
--FROM Movies
--INNER JOIN Boxoffice
--    ON Id = Movie_id;

--�Task 3�--
--SELECT *
--FROM Movies
--INNER JOIN Boxoffice
--    ON Id = Movie_id
--WHERE NOT Year%2
    
--**Lesson 10*--
--�Task 1�--
--SELECT MAX(Years_employed) 
--FROM employees;

----�Task 2�--
--SELECT Role, AVG(Years_employed)
--FROM Employees
--GROUP BY Role;

----�Task 3�--
--SELECT Building, SUM(Years_employed)
--FROM Employees
--GROUP BY Building