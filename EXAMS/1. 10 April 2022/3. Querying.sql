# 5 05.	Countries
SELECT 
    c.id, c.name, c.continent,c.currency
FROM
    countries AS c
ORDER BY currency DESC , id ASC;

# 6  06.	Old movies   ?????? 0/10 ??????????? ------------------------------------------------------------
SELECT 
    m.id, m.title, mai.runtime, mai.budget, mai.release_date
FROM
    movies_additional_info AS mai
        JOIN
    movies AS m ON mai.id = m.id
    WHERE year(release_date) BETWEEN 1996 AND 1999
    ORDER BY runtime ASC,id
    LIMIT 20;	
    
# 6 2nd VAR      10/10    ---------------------------------------------------------------------------
SELECT 
    m.id, m.title, mai.runtime, mai.budget, mai.release_date
FROM
    movies_additional_info AS mai
        JOIN
    movies AS m USING (id)
WHERE
    YEAR(release_date) BETWEEN 1996 AND 1999
ORDER BY runtime , id
LIMIT 20;

# 7 07.	Movie casting --------------------------------------------------------------------------------
SELECT 
    concat_ws(' ', first_name, last_name) AS 'full_name',
    concat(reverse(last_name), length(last_name), '@cast.com' ) AS 'email',
    2022 - year(birthdate),
    a.height
FROM
    actors AS a
     LEFT   JOIN
    movies_actors AS ma ON ma.actor_id = a.id 
    WHERE actor_id IS NULL
    ORDER BY height;
    
# 8 08.	International festival ------------------------------------------------------------------------
SELECT 
    c.`name`, COUNT(m.id) AS 'movies_count'
FROM
    movies AS m
       LEFT  JOIN
    countries AS c ON m.country_id = c.id
    GROUP BY c.id
    HAVING movies_count >=7
    ORDER BY c.id DESC;
    
# 9 09.	Rating system ----------------------------------------------------------------
SELECT 
    title, 
    CASE 
		WHEN rating <= 4 THEN 'poor'
		WHEN rating <= 7 THEN 'good'
        ELSE 'excellent'
        END AS 'rating'
    , 
    if(i.has_subtitles, 'english', '-') AS subtitles, 
    i.budget
FROM
    movies AS m
        JOIN
    movies_additional_info AS i ON m.id = i.id
ORDER BY i.budget DESC;
    
