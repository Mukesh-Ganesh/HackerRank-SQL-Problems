----------------------------------------------HackerRank SQL Medium Problems-----------------------------------------------------

-- The PADS

SELECT CONCAT(name, '(', SUBSTRING(occupation, 1, 1), ')') 
FROM occupations
ORDER BY name;

SELECT CONCAT('There are a total of ', COUNT(occupation), ' ', LOWER(occupation), 's.')
FROM occupations
GROUP BY occupation
ORDER BY COUNT(occupation), occupation;

-- Occupations

SET @r1 = 0, @r2 = 0, @r3 = 0, @r4 = 0;

SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor) FROM
(SELECT CASE
WHEN occupation = 'Doctor' THEN @r1 := @r1 + 1
WHEN occupation = 'Professor' THEN @r2 := @r2 + 1
WHEN occupation = 'Singer' THEN @r3 := @r3 + 1
WHEN occupation = 'Actor' THEN @r4 := @r4 + 1
END AS RowNumber,

CASE WHEN occupation = 'Doctor' THEN name END AS Doctor,
CASE WHEN occupation = 'Professor' THEN name END AS Professor,
CASE WHEN occupation = 'Singer' THEN name END AS Singer,
CASE WHEN occupation = 'Actor' THEN name END AS Actor
FROM occupations
ORDER BY name) temp
GROUP BY RowNumber;

--Binary Tree Nodes

SELECT CASE
WHEN p IS NULL THEN CONCAT(n, ' Root')
WHEN n in (SELECT DISTINCT(p) FROM BST) THEN CONCAT(n, ' Inner')
ELSE CONCAT(n, ' Leaf')
END
FROM BST
ORDER BY n;

--New Companies

SELECT CONCAT(c.company_code, ' ', c.founder, ' ', COUNT(DISTINCT l.lead_manager_code), ' ', COUNT(DISTINCT s.senior_manager_code), ' ', COUNT(DISTINCT m.manager_code), ' ', COUNT(DISTINCT e.employee_code))
FROM company c 
JOIN lead_manager l
JOIN senior_manager s
JOIN manager m
JOIN employee e
ON c.company_code = l.company_code
AND c.company_code = s.company_code
AND c.company_code = m.company_code
AND c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;

--Weather Observation Station 18

SELECT ROUND(ABS(MAX(lat_n) - MIN(lat_n)) + ABS(MAX(long_w) - MIN(long_w)), 4) FROM station;

--Weather Observation Station 19

SELECT ROUND(SQRT(POWER(MAX(lat_n) - MIN(lat_n), 2) + POWER(MAX(long_w) - MIN(long_w), 2)), 4)  FROM station; 

--Weather Observation Station 20

SELECT ROUND(s.lat_n, 4) FROM station s WHERE
(SELECT COUNT(lat_n) FROM station WHERE lat_n < s.lat_n) = (SELECT COUNT(lat_n) FROM station WHERE lat_n > s.lat_n);

--The Report

SELECT IF(g.grade < 8, 'NULL', s.name), g.grade, s.marks 
FROM students s
JOIN grades g
WHERE s.marks between min_mark and max_mark
ORDER BY g.grade DESC, s.name;

--Top Competitors

SELECT h.hacker_id, h.name
FROM hackers h
JOIN submissions s
JOIN challenges c
JOIN difficulty d
ON h.hacker_id = s.hacker_id
AND s.challenge_id = c.challenge_id
AND c.difficulty_level = d.difficulty_level
WHERE s.score = d.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(s.challenge_id) > 1
ORDER BY COUNT(s.hacker_id) DESC, hacker_id;

--Ollivander's Inventory

SELECT w.id, p.age, w.coins_needed, w.power
FROM wands w
JOIN wands_property p
ON w.code = p.code
WHERE p.is_evil = 0
AND w.coins_needed = 
(SELECT min(coins_needed) 
 FROM wands w1 
 JOIN wands_property p1 
 ON w1.code = p1.code
 WHERE w1.power = w.power
 AND p1.age = p.age
)
ORDER BY w.power DESC, p.age DESC;

--Challenges

WITH data AS(
    SELECT h.hacker_id as id, h.name as name, COUNT(c.challenge_id) as total
    FROM hackers h
    JOIN challenges c
    ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name)
    
SELECT id, name, total
FROM data
WHERE total = (SELECT max(total) FROM data)
OR total IN (SELECT total
             FROM data
             GROUP BY total
             HAVING COUNT(total) = 1)
ORDER BY total DESC, id;        
      

--Contest Leaderboard

SELECT h.hacker_id, h.name, SUM(max_score) FROM 
(SELECT hacker_id, challenge_id, MAX(score) AS max_score FROM submissions GROUP BY hacker_id, challenge_id) score
JOIN hackers h
ON score.hacker_id = h.hacker_id 
GROUP BY h.hacker_id, h.name
HAVING SUM(max_score) > 0
ORDER BY SUM(max_score) desc, h.hacker_id

--SQL Project Planning

SELECT start_date, MIN(end_date)
FROM
(SELECT start_date FROM projects WHERE start_date NOT IN(SELECT end_date FROM projects))a,
(SELECT end_date FROM projects WHERE end_date NOT IN(SELECT start_date FROM projects))b
WHERE start_date < end_date
GROUP BY start_date
ORDER BY DATEDIFF(start_date, MIN(end_date)) DESC, start_date

--Placements

SELECT s.name 
FROM students s JOIN friends f JOIN packages p1 JOIN packages p2
ON s.id = f.id
AND s.id = p1.id
AND f.friend_id = p2.id
WHERE p2.salary > p1.salary
ORDER BY p2.salary

--Symmetric Pairs

SELECT f1.x, f1.y 
FROM functions f1
JOIN functions f2 
ON f1.x = f2.y AND f1.y = f2.x
GROUP BY f1.x, f1.y
HAVING COUNT(f1.x) > 1 OR f1.x < f1.y
ORDER BY f1.x

--Print Prime Numbers

DECLARE @i int = 2;
DECLARE @prime int;
DECLARE @result nvarchar(1000) = '';
WHILE (@i <= 1000)
BEGIN
   DECLARE @j int = @i - 1;
   SET @prime = 1;
   WHILE(@j > 1)
   BEGIN
      IF @i % @j = 0
      BEGIN 
         SET @PRIME = 0;
      END
    SET @j = @j - 1;
   END
   
   IF @prime = 1
   BEGIN
      SET @result += CAST(@i AS nvarchar(1000)) + '&';
   END
SET @i = @i + 1;
END
SET @result = SUBSTRING(@result, 1, LEN(@result) - 1)
SELECT @result