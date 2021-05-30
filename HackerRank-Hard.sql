------------------------------------------------HackerRank SQL Hard Problems----------------------------------------------------

---------------------------------------------------Interviews-----------------------------------------------------------------------

WITH temp1 AS(
    SELECT c2.contest_id, SUM(s.total_submissions) as SUM_TS, SUM(s.total_accepted_submissions) as SUM_TAS
    FROM colleges c2 
    JOIN challenges c3 ON c2.college_id = c3.college_id
    JOIN submission_stats s ON c3.challenge_id = s.challenge_id
    GROUP BY c2.contest_id
),

temp2 AS(
    SELECT c2.contest_id, SUM(v.total_views) AS SUM_TV, SUM(v.total_unique_views) AS SUM_TUS
    FROM colleges c2
    JOIN challenges c3 ON c2.college_id = c3.college_id
    JOIN View_Stats v ON c3.challenge_id = v.challenge_id
    GROUP BY c2.contest_id
)

SELECT c1.contest_id, c1.hacker_id, c1.name, t1.SUM_TS, t1.SUM_TAS, t2.SUM_TV, t2.SUM_TUS
FROM contests c1
JOIN temp1 t1 ON c1.contest_id = t1.contest_id
JOIN temp2 t2 ON c1.contest_id = t2.contest_id
WHERE t1.SUM_TS > 0
OR t1.SUM_TAS > 0
OR t2.SUM_TV > 0
OR t2.SUM_TUS > 0
ORDER BY c1.contest_id;

------------------------------------------------15 Days of Learning SQL------------------------------------------------------------

--Create table to store consistent hackers who have made submissions each day

DECLARE @consistent_hackers TABLE(
    hacker_id int,
    submission_date date
);

DECLARE @count_hackers TABLE(
    hacker_id int, 
    submission_date date
);

--Find consistent hackers

DECLARE @subdate date;
DECLARE @remaningdate date;

INSERT INTO @consistent_hackers
    SELECT hacker_id, submission_date
    FROM submissions
    WHERE submission_date LIKE '2016-03-01'

SET @subdate = '2016-03-01';
SET @remaningdate = '2016-03-01';

WHILE @subdate < '2016-03-15'
BEGIN  
    SET @subdate = DATEADD(day, 1, @subdate);
    INSERT INTO @consistent_hackers
    SELECT s.hacker_id, s.submission_date
    FROM submissions s
    JOIN @consistent_hackers c1
    ON s.hacker_id = c1.hacker_id
    AND c1.submission_date LIKE @remaningdate
    WHERE s.submission_date LIKE @subdate;
    
    SET @remaningdate = DATEADD(day, 1, @remaningdate);
END

--Count consistent hackers

INSERT INTO @count_hackers
    SELECT COUNT(DISTINCT hacker_id), submission_date
    FROM @consistent_hackers
    GROUP BY submission_date;

--Find maximum hackers each day

WITH max_hacker AS(
    SELECT ROW_NUMBER() OVER (PARTITION BY s.submission_date
                  ORDER BY COUNT(s.hacker_id) DESC, s.hacker_id) AS row#,
                  s.hacker_id, s.submission_date, h.name
                  FROM submissions s
                  JOIN hackers h
                  ON s.hacker_id = h.hacker_id
                  GROUP BY s.submission_date, s.hacker_id, h.name
)

--Final output with all columns required

SELECT s.submission_date, c2.hacker_id, m.hacker_id, m.name
FROM submissions s
JOIN max_hacker m 
ON s.submission_date = m.submission_date AND row# = 1
JOIN @count_hackers c2
ON s.submission_date = c2.submission_date
GROUP BY s.submission_date, c2.hacker_id, m.hacker_id, m.name
ORDER BY s.submission_date;
