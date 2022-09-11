# 5 Users -------------------------------------------------------------------------------------
SELECT 
    u.username, u.gender, u.age
FROM
    users AS u
ORDER BY u.age DESC , u.username ASC;

# 6 06.	Extract 5 Most Commented Photos --------------------------------------------------------

SELECT 
    p.id, p.date, p.description, COUNT(c.id) as 'commentsCount'
FROM
    photos AS p
        JOIN
    comments AS c ON p.id = c.photo_id
    GROUP BY p.id
    ORDER BY commentsCount DESC, p.id ASC
    LIMIT 5;
    
    
# 7 07.	Lucky Users ----------------------------------------------------------------------------
SELECT 
    concat_ws(' ', u.id, u.username) AS 'id_username', u.email
FROM
    users AS u
        JOIN
    users_photos AS up ON u.id = up.user_id
WHERE
    u.id = up.photo_id
    ORDER BY u.id ASC;
    
    
# 8 08.	Count Likes and Comments --------------------------------------------------------------

    SELECT 
    p.id,
    COUNT(DISTINCT l.id) AS 'likes_count',
    COUNT(DISTINCT c.id) AS 'comments_count'
FROM
    photos AS p
        LEFT JOIN
    likes AS l ON p.id = l.photo_id
        LEFT JOIN
    comments AS c ON p.id = c.photo_id
GROUP BY p.id
ORDER BY likes_count DESC , comments_count DESC , p.id ASC;

# 8. 2nd VAR with NESTED SELECT -------------------------------------------------------------------------
 
SELECT p.id, 
		(SELECT count(id)
    	FROM likes
    	WHERE photo_id = p.id) AS likes_count, 
    	(SELECT count(id)
    	FROM comments
    	WHERE photo_id = p.id) AS comments_count
FROM photos AS p
ORDER BY likes_count DESC, comments_count DESC, p.id;

# 9 09.	The Photo on the Tenth Day of the Month ------------------------------------------------

SELECT 
    CONCAT(LEFT(p.description, 30), '...') AS summary, p.date
FROM
    photos AS p
WHERE
    DAY(`date`) = 10
ORDER BY date DESC;

    



