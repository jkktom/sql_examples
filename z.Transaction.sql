		
		/*
		트랜잭션
		
		여러개의 SQL 작업을 하나의 논리적인 단위로 묶는 것
		모든 작업이 성공하면 적용 (Commit) 실패하면 취소 (Rollback)
		데이터 무결성을 보장하는 핵심 기능.
		
		트랜잭션의 4가지 특성 (기사 시험 및 면접 출제)
		Atomicity(원자성) 트랜잭션 내 모든 작업이 성공하거나 실패해야함.
		Consistency(일관성) 트랜잭션 전 후 데이터 무결성을 유지해야 함.
		Isolation(격리성) 동시에 실행되는 트랜잭션 간 영향 최소화
		Durability(지속성) 트랜잭션이 Commit 이 되면 데이터가 영구 저장됨.
		결제 (결제_id)-> 주문서 생성(주문_id) -> 주방 빌 지 생성(빌지_id)
		**/

/*
	 * 모듈2 : commit & Rollback
	
	학생이 강의를 결제 했을 때 결제 테이블(payments)와 수강 신청 테이블 (enrollments)를 동시에 업데이트 한다.
	만약 한쪽에서 오류가 발생하면 모든 작업을 원래 상태로 되돌려야 한다.
	
	

 */
-- 트랜잭션 시작
START TRANSACTION;
SELECT * FROM users WHERE user_id = 1001; 
SELECT * FROM courses WHERE course_id = 1;
--  결제내역 추가
INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES (1001, 1, 100.0, "pending");

-- 수강 신청 추가
INSERT INTO enrollments (user_id, course_id, status)
VALUES (1001, 1, "active");

COMMIT;

SELECT * FROM payments WHERE user_id = "1001";
SELECT * FROM enrollments WHERE user_id = "1001";

/*
 * rollback/
 * 
 * */

START TRANSACTION;

INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES (1001, 1, 100.0, "pending");

SELECT * FROM payments p WHERE user_id = 1001;
-- 오류 만들기
INSERT INTO enrollments (user_id, course_id, status)
VALUES (1001, 99990990099, "active");

ROLLBACK;

SELECT * FROM payments p WHERE user_id = 1001;

	/*
	 * SAVEPOINT
	 * 트랜잭션 내에서 부분적으로 저장할 수 있는 포인트를 설정
	특정 지점까지만 Rollback 가능 (Save point 이후 실행된 SQL 만 취소함)
	 * 
 */


START TRANSACTION;

INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES(1001, 100, 97490.0, 'pending');

SAVEPOINT payment1;

SELECT * FROM payments WHERE user_id = 1001;

-- 두 번째 결제
INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES(1001, 999, 100.0, 'pending');

-- 세 번째 결제
INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES(1001, 999, 100.0, 'pending');

-- 네 번째 결제
INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES(1001, 999, 100.0, 'pending');

-- 5번째 결제
INSERT INTO payments(user_id, course_id, amount, payment_status)
VALUES(1001, 11123999, 100.0, 'pending');

-- 조회
SELECT * FROM payments WHERE user_id = 1001;

ROLLBACK TO SAVEPOINT payment1;




