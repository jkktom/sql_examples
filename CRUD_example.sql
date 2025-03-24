-- instructor index 2
-- insert 사용 신규 강사 추가
-- insert course 추가 신규 강사 이용
-- update 강좌이름 수정.
INSERT INTO users(
	username,
	email,
	password_hash,
	role_id)
VALUES ("Jake", "jake@web3.email", "hash2323", 2);

INSERT INTO courses(
	title,
	instructor_id)
VALUES ("course1", 2),
	   ("course2", 2);



UPDATE
	courses c 
   SET c.title="수정_course1"
 WHERE c.title="course1";


UPDATE
	courses c 
   SET c.title="수정_course2"
 WHERE c.title="course2";
-- courses 와 users 를 IN

-- table 두개 설정
-- u users / c courses
-- i강사 이름은 username 강좌 제목은 title instructor_id
-- i강사가 개설한 강좌만 조회
SELECT
   u.username,
   c.title
  FROM users u
INNER JOIN courses c ON u.user_id = c.instructor_id;
   

SELECT
   u.username,
   e.user_id 
  FROM users u
INNER JOIN enrollments e ON u.user_id = e.user_id ;

	
SELECT
   l.course_id ,
   c.title
  FROM lessons l
INNER JOIN courses c ON l.course_id = c.course_id;

SELECT
   q.title "퀴즈제목",
   c.title AS "강좌제목"
  FROM quizzes q 
 INNER JOIN courses c ON q.course_id = c.course_id;

SELECT
	u.username,
	p.amount "결제금액"
  FROM payments p
INNER JOIN users u ON p.user_id = u.user_id;

SELECT
	c.title,
	g.final_score
  FROM grades g 
INNER JOIN courses c ON g.course_id = c.course_id;

SELECT 
	e.enrollment_id,
    c.title,
	e.course_id
  FROM courses c 
  LEFT JOIN enrollments e ON e.enrollment_id  = c.course_id;

SELECT 
    e.enrollment_id,
    c.title
  FROM enrollments e
  LEFT JOIN courses c ON e.enrollment_id = c.course_id;

SELECT
	u.user_id,
	e.enrolled_at
  FROM users u 
  LEFT JOIN enrollments e ON e.user_id = u.user_id;

SELECT
	c.course_id "강좌ID",
	l.title "강의제목"
  FROM lessons l 
 RIGHT JOIN courses c ON c.course_id = l.course_id;


SELECT
	u.user_id,
	p.payment_id
  FROM users u 
  LEFT JOIN payments p ON u.user_id = p.user_id;
  
  
SELECT
	q.title,
	qa.attempt_id
  FROM quizzes q 
 RIGHT JOIN quiz_attempts qa  ON q.quiz_id = qa.quiz_id ;

SELECT
	c.course_id,
	e.status
  FROM courses c 
  LEFT JOIN enrollments e ON c.course_id = e.course_id;
  