-- 결제 한 학생 조회 (IN 활용)

SELECT 
   username
  FROM users
 WHERE user_id IN(
    SELECT user_id FROM payments
 );

-- 퀴즈에 응시하지 않은 학생 목록 조회 (NOT IN 활용)
SELECT
   username
  FROM users
 WHERE user_id NOT IN (
    SELECT user_id FROM quiz_attempts 
 );

--  과제가 있는 강의 목록 조회 (EXISTS 활용)
SELECT
   c.course_id
  FROM courses c
 WHERE EXISTS(
    SELECT 1
      FROM quizzes q
     WHERE q.course_id = c.course_id
 );



/*       SELECT 미션        */

-- 📌 학생별 퀴즈 점수와 퀴즈별 평균 점수와 비교
-- username / quiz id / quiz score / quiz avg score
SELECT
   u.username,
   qa.score,
   (SELECT
       AVG(qa2.score)
      FROM quiz_attempts qa2
     WHERE qa2.quiz_id = qa.quiz_id 
   ) AS avg_quiz_score
  FROM users u
 INNER JOIN quiz_attempts qa ON u.user_id = qa.user_id;

-- userid / quiz score / quiz avg score
SELECT
   qa.user_id,
   qa.score,
   (SELECT
       AVG(qa2.score)
      FROM quiz_attempts qa2
     WHERE qa2.quiz_id = qa.quiz_id 
   ) AS avg_quiz_score
  FROM quiz_attempts qa


-- 📌 (강좌별 ) 결제 금액과 해당 강좌의 수강생 수 출력
-- course id / course payment amount (sum) / course enrolled user is sum
  
SELECT
   c.course_id,
   (SELECT
       SUM(p.amount)
      FROM payments p
     WHERE p.course_id = c.course_id
   ) AS course_amount_sum,
   COUNT(e.user_id) AS student_count
  FROM courses c
 INNER JOIN enrollments e ON c.course_id = e.course_id
 GROUP BY c.course_id;


-- 📌 학생별  결제합계 금액 조회
-- user_id / sum p amount for all course id
SELECT
   p.user_id,
   SUM(p.amount)
  FROM payments p
 GROUP BY p.user_id

-- 📌 학생별 평균 결제 금액 조회
-- user_id / sum  /average payment amount among courses

SELECT
   p.user_id,
   SUM(p.amount) as sum_amount,
   COUNT(p.course_id) AS course_count,
   AVG(p.amount)
  FROM payments p
 GROUP BY p.user_id;
 


/*        FROM 미션         */
-- 📌 평균 점수보다 높은 퀴즈(응시 ) 조회
-- attempt id that is higher than avg score of that quiz
SELECT 
    sub.attempt_id
  FROM (
    SELECT 
        qa.attempt_id,
        qa.score,
        qa.quiz_id,
        (SELECT 
        	AVG(qa2.score) 
           FROM quiz_attempts qa2 
          WHERE qa2.quiz_id = qa.quiz_id
         ) as avg_score
      FROM quiz_attempts qa
  ) AS sub
WHERE sub.score > sub.avg_score;

-- 📌 결제 총액 평균보다 큰 강좌 조회
SELECT
   sub.course_id,
   sub.amount,
   sub.avg_amount
  FROM (
    SELECT
       p.course_id,
       p.amount,
       (SELECT
           avg(p2.amount)
          FROM payments p2
       ) as avg_amount
      FROM payments p
  ) AS sub
 WHERE sub.amount > sub.avg_amount
 ORDER BY sub.amount ASC;


-- 📌 전체 평균 과제 수보다, 과제 수 가 많은 강의 조회
--  강좌 별 과제 수 구하기
-- 강좌 별  평균 과제수 구하기
-- 강의 별 과제 수 구하기
-- 비교 후 해당 건만 출력 
SELECT
   sub.course_id,
   sub.quiz_count,
   sub.avg_count
  FROM ( 
    SELECT
       q.course_id,
       COUNT(quiz_id) AS quiz_count,
       (SELECT 
           avg(count)
          FROM quizzes q2
         GROUP BY q2.course_id
       ) as avg_count
      FROM quizzes q
     GROUP BY q.course_id
  ) AS sub 
 WHERE sub.quiz_count > sub.avg_count;
 ORDER BY sub.quiz_count ASC;
-- a 강좌 별 과제 수 구하기 quiz_counts_per_courses
-- a 전체  평균 과제수 구하기 total_quiz_avg
-- a 강의 별 과제 수 구하기
-- a 비교 후 해당 건만 출력 

SELECT
   sub.course_id,
   sub.quiz_count,
   sub.total_avg
  FROM
   -- c 강좌 별 퀴즈 수 구하기
	(SELECT
	    q.course_id,
	    count(q.quiz_id) AS quiz_count,
	    -- b 전체 평균 퀴즈 수 구하기
	   (SELECT
		   AVG(quiz_count)
		  FROM 
		    -- a 강좌 별 퀴즈 수 구하기
			(SELECT
			     course_id,
			     COUNT(quiz_id) as quiz_count
			   FROM quizzes
			  GROUP BY course_id
		     )as quiz_counts_per_courses
		    -- a END.
		)as total_avg
	    -- b END
	   FROM quizzes q
	  GROUP BY q.course_id
	 ) AS sub
 WHERE sub.quiz_count > sub.total_avg
 ORDER BY sub.quiz_count ASC;