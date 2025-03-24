/*
 * * ==========================
📌 VIEW 활용 미션
==========================
-- 1
-- 2

-- 📌 3 과제 제출 여부를 확인할 수 있는 뷰 생성

*/

-- a 📌 1 퀴즈 응시자의 평균 점수보다 높은 학생만 표시하는 뷰 생성
-- a 퀴즈 응시자 점수 전체 평균 구하기
-- b user_id 표시 및 평균 이상만 표시
-- c (자체 추가 미션 : user 별 퀴즈 평균을 구하고, 해당 평균이 전체 평균보다 크면 표시)

CREATE VIEW high_score_students AS
SELECT DISTINCT
    qa.user_id
FROM quiz_attempts qa
WHERE qa.score > (
    SELECT AVG(qa2.score)
    FROM quiz_attempts qa2
    WHERE qa2.quiz_id = qa.quiz_id
);

SELECT * FROM high_score_students;
DROP VIEW high_score_students;



-- 📌 3 특정 강좌의 결제 내역만 필터링하는 뷰 생성 (강좌 ID 3번에 해당하는 결제 내역)

CREATE VIEW see_course_id_3 AS
SELECT
   cour
 