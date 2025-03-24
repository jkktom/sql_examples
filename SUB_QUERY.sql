
-- WHERE 절에서 서브 쿼리 활용

-- 수강 신청한 학생 조회 (IN 활용)
SELECT
   username
  FROM users
 WHERE user_id IN (
 	SELECT user_id FROM enrollments
 );

-- 수강 신청하지 않은 학생 조회 (not in 활용.)
SELECT
   username
  FROM users
 WHERE user_id NOT IN (
 	SELECT user_id FROM enrollments
 );


-- 수강 신청한 학생이 있는지 확인
SELECT
   u.username
  FROM users u
 WHERE EXISTS(
 	SELECT 1 FROM enrollments e WHERE e.user_id = u.user_id
 );

-- 2. select 절에서 서브 쿼리 활용
-- 문법 : 단일 행, 단일 열 결과만 반환해야 함.
-- 메모리 : 행별로 서브쿼리 실행, 결과를 캐싱되지 않음

-- 학생별 결제 내역과 강좌 평균 가격 조회
SELECT
   u.username,
   p.amount,
   (SELECT 
       AVG(p2.amount)
      FROM payments p2
     WHERE p2.course_id = p.course_id
    ) AS avg_course_payment
 FROM users u
INNER JOIN payments p ON u.user_id = p.user_id;
   
/*3. FROM 절에서 서브쿼리 사용
FROM 절 서브쿼리란
임시 테이블 (인라인 뷰)를 만들어 쿼리에서 활용
실생활 비유 : "판매 상위 상품"을 뽑아 그 중 조건에 맞느 ㄴ것만 분석하는 것과 비슷
문법 : 서브퀴리에 별칭 필수
메모리 : 임시테이블이 메모리에 생성, 대량 데이터 시 디스크 사용 가능
성능 : 인덱스 조건 미리 적용으로 최적화 가능*/

SELECT
   sub.course_id,
   sub.avg_amount
  FROM (
    SELECT 
        course_id,
        avg(amount) AS avg_amount
      FROM payments
     GROUP BY course_id
  ) AS sub
 WHERE sub.avg_amount > 100;








