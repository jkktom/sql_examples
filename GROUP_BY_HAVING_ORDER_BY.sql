SELECT
	qa.quiz_id,
	avg(qa.score) AS average_score
  FROM quiz_attempts qa
 GROUP BY qa.quiz_id 
HAVING average_score >= 70;

SELECT
	e.course_id,
	count(e.user_id) AS students
  FROM enrollments e 
 GROUP BY e.course_id
HAVING students >= 2;

SELECT
	qa.user_id,
	avg(qa.score) AS average_score
  FROM quiz_attempts qa
 GROUP BY qa.user_id 
HAVING average_score >= 80;

SELECT
	l.course_id,
	count(l.lesson_id) AS lesson_count
  FROM lessons l
 GROUP BY l.course_id 
HAVING lesson_count >= 3;


SELECT
	g.course_id,
	avg(g.final_score) AS avg_score
  FROM grades g
 GROUP BY g.course_id
HAVING avg_score >= 60;


SELECT
	g.course_id,
	avg(g.final_score) AS avg_score
  FROM grades g
 GROUP BY g.course_id
HAVING avg_score >= 60;

SELECT
	c.title,
	c.price
  FROM courses c 
ORDER BY c.price DESC;

SELECT
	p.course_id,
	p.amount
  FROM payments p 
 ORDER BY p.amount  DESC;


SELECT
	qa.quiz_id,
	qa.score
  FROM quiz_attempts qa 
 ORDER BY qa.score  ASC;


SELECT
	l.title,
	l.created_at
  FROM lessons l 
 ORDER BY l.created_at   ASC;





