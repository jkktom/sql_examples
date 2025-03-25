
/*      윈도우 함수 미션      */

-- i📌 각 강좌에서 상위 3명의 학생을 `RANK()`를 이용해 조회하세요.
-- show user id
-- on quiz attemps
-- but only 3 of top rank

SELECT
   user_id,
   RANK() OVER(PARTITION BY quiz_id ORDER BY score DESC) AS rank_value
  FROM quiz_attempts
 LIMIT 0,3;

-- i📌 `DENSE_RANK()`를 이용해 상위 5명까지 출력하고 순위 차이를 비교하세요.
SELECT
   user_id,
   DENSE_RANK() OVER(PARTITION BY quiz_id ORDER BY score DESC) AS rank_value
  FROM quiz_attempts
 LIMIT 0,5;

SELECT
   user_id,
   quiz_id,
   ROW_NUMBER() OVER(PARTITION BY quiz_id ORDER BY attempted_at DESC) AS row_num_value
  FROM quiz_attempts
 WHERE row_num_value = 1;


SELECT 
    user_id,
    quiz_id,
    score
FROM (
    SELECT
        user_id,
        quiz_id,
        score,
        attempted_at,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY attempted_at DESC) AS row_num
    FROM quiz_attempts
) AS asb
WHERE row_num = 1;


/*       미션        */

-- i📌 두 개의 강좌를 결제한 후, 첫 번째 결제만 유지하고 두 번째 결제는 취소하세요
START TRANSACTION;

INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES(1001, 100, 23456.0, 'pending');

SAVEPOINT payment1;

SELECT * FROM payments WHERE user_id = 1001;

-- 두 번째 결제
INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES(1001, 999, 6543.0, 'pending');

-- 조회
SELECT * FROM payments WHERE user_id = 1001;

ROLLBACK TO SAVEPOINT payment1;
