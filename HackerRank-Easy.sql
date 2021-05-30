------------------------------------------------HackerRank SQL Easy Problems--------------------------------------------------------

--Revising the Select Query I

SELECT * FROM city WHERE countrycode = 'USA' AND population > 100000;

--Revising the Select Query II

SELECT name FROM city WHERE countrycode = 'USA' AND population > 120000;

--Select All

SELECT * FROM city;

--Select By ID

SELECT * FROM city WHERE id = 1661;

--Japanese Cities' Attributes

SELECT * FROM city WHERE countrycode = 'JPN';

--Japanese Cities' Names

SELECT name FROM city where countrycode = 'JPN';

--Weather Observation Station 1

SELECT city, state FROM station;

--Weather Observation Station 3

SELECT DISTINCT(city) FROM station WHERE id % 2 = 0;

--Weather Observation Station 4

SELECT COUNT(city) - COUNT(DISTINCT city) FROM station;

--Weather Observation Station 5

SELECT city, LENGTH(city) 
FROM station
GROUP BY city
ORDER BY LENGTH(city) DESC, city
LIMIT 1;

SELECT city, LENGTH(city)
FROM station
GROUP BY city
ORDER BY LENGTH(city), city
LIMIT 1;

--Weather Observation Station 6

SELECT DISTINCT(city) FROM station WHERE city REGEXP '^[aeiou]';

--Weather Observation Station 7

SELECT DISTINCT(city) FROM station WHERE city REGEXP '[aeiou]$';

--Weather Observation Station 8

SELECT DISTINCT(city) FROM station WHERE city REGEXP '^[aeiou]' AND city REGEXP '[aeiou]$';

--Weather Observation Station 9

SELECT DISTINCT(city) FROM station WHERE city REGEXP '^[^aeiou]';

--Weather Observation Station 10

SELECT DISTINCT(city) FROM station WHERE city REGEXP '[^aeiou]$';

--Weather Observation Station 11

SELECT DISTINCT(city) FROM station WHERE city REGEXP '^[^aeiou]' OR city REGEXP '[^aeiou]$';

--Weather Observation Station 12

SELECT DISTINCT(city) FROM station WHERE city REGEXP '^[^aeiou]' AND city REGEXP '[^aeiou]$';

--Higher Than 75 Marks

SELECT name 
FROM students 
WHERE marks > 75 
ORDER BY RIGHT(name, 3), id;

--Employee Names

SELECT name FROM employee ORDER BY name;

--Employee Salaries

SELECT name 
FROM employee 
WHERE salary > 2000 AND months < 10
ORDER BY employee_id;

--Type of Triangle

SELECT CASE 
WHEN(A + B > C AND B + C > A AND C + A > B) THEN
CASE 
WHEN(A = B AND B = C) THEN 'Equilateral'
WHEN(A = B OR B = C OR C = A) THEN 'Isosceles'
ELSE 'Scalene'
END
ELSE 'Not A Triangle'
END
FROM triangles;

--Revising Aggregations - The Count Function

SELECT COUNT(id) FROM city WHERE population > 100000;

--Revising Aggregations - The Sum Function

SELECT SUM(population) FROM city WHERE district = 'California';

--Revising Aggregations - Averages

SELECT AVG(population) FROM city WHERE district = 'California';

--Average Population

SELECT FLOOR(AVG(population)) FROM city;

--Japan Population

SELECT SUM(population) FROM city WHERE countrycode = 'JPN';

--Population Density Difference

SELECT MAX(population) - MIN(population) FROM city;

--The Blunder

SELECT CEILING(AVG(salary) - AVG(REPLACE(salary, '0', ''))) FROM employees;

--Top Earners

SELECT salary*months AS total_earings, COUNT(employee_id) as employee_count 
FROM Employee
GROUP BY total_earings
ORDER BY employee_count DESC
LIMIT 1;

--Weather Observation Station 2

SELECT ROUND(SUM(lat_n), 2), ROUND(SUM(long_w), 2) FROM station;

--Weather Observation Station 13

SELECT ROUND(SUM(lat_n), 4) FROM station WHERE lat_n > 38.7880 and lat_n < 137.2345;

--Weather Observation Station 14

SELECT ROUND(MAX(lat_n), 4) FROM station WHERE lat_n < 137.2345;

--Weather Observation Station 15

SELECT ROUND(long_w, 4) 
FROM station 
WHERE lat_n IN (SELECT MAX(lat_n) FROM station WHERE lat_n < 137.2345);

--Weather Observation Station 16

SELECT ROUND(MIN(lat_n), 4) FROM station WHERE lat_n > 38.7780;

--Weather Observation Station 17

SELECT ROUND(long_w, 4) 
FROM station 
WHERE lat_n IN (SELECT MIN(lat_n) FROM station WHERE lat_n > 38.7780);

--Population Census

SELECT SUM(c1.population)
FROM city c1
JOIN country c2
ON c1.countrycode = c2.code
WHERE c2.continent = 'Asia';

--African Cities

SELECT c1.name 
FROM city c1
JOIN country c2
ON c1.countrycode = c2.code
WHERE c2.continent = 'Africa';

--Average Population of Each Continent

SELECT c2.continent, FLOOR(AVG(c1.population))
FROM city c1
JOIN country c2
ON c1.countrycode = c2.code
GROUP BY c2.continent;

--Draw The Triangle 1

SET @number = 21;
SELECT REPEAT('* ', @number := @number - 1) FROM INFORMATION_SCHEMA.tables;

--Draw The Triangle 2

SET @number = 0;
SELECT REPEAT('* ', @number := @number + 1) FROM INFORMATION_SCHEMA.tables
WHERE @number < 20;