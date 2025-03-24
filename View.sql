/*
View (뷰)란

뷰(View) 는 하나 이상의 테이블에서 가져온 데이터를 저장하는 가상의 테이블이다.
데이터를 실제로 저장하지 않고, 원본 테이블을 참조하여 결과를 제공한다.

실생활 비유

매일 아침 인기 뉴스를 보여주는 페이지는 뉴스 데이터베이스에서 특정 조건을 만족하는 뉴스만 보여줌
실제 뉴스 기사를 따로 저장하는 것이 아니라, 특정 기준으로 필터링 된 기사 목록만 보여줌

View를 사용하는 이융
복잡한 쿼리 단순화
join, group by 서브 쿼리 등 복잡한 쿼리를 매번 작성할 필요 없이 view 를 생성하면 재사용이 가능함.


보안성 강화
특정 컬럼만 노출하여 민감함 데이터 보호 가능
읽기 전용 테이블처럼 활용 가능
직접 데이터를 수정할 수 없도록 막고, 조회만 가능하도록 설정
성능 최적화
자주 실행하는 복잡한 쿼리를 미리 정의하여 성능 향상 가능 
*//*
*View 생성
뷰는 특정 조건을 만족하는 데이터를 미리 생성할 때 사용한다

수강 신청한 학생들의 정보를 저장하는 뷰 생성

*/

CREATE VIEW enrolled_students AS
SELECT
    u.user_id,
    u.username,
    u.email,
    e.course_id,
    c.title AS course_title
  FROM users u
 INNER JOIN enrollments e ON u.user_id = e.user_id
 INNER JOIN courses c ON e.course_id = c.course_id;


/*
 * View 조회
 * */
SELECT
   *
  FROM enrolled_students;





/*
 * View 내용 수정
 * 뷰를 생성한 후에도 수정이 가능하다.
 * Alter view 문을 사용하여 뷰를 업데이트 할 수 있다.
 * */

-- 수강 신청 한 학생 목록에 등록 날짜 추가
ALTER VIEW enrolled_students AS
SELECT
    u.user_id,
    u.username,
    u.email,
    c.course_id,
    c.title AS course_title,
    e.enrolled_at
  FROM users u
 INNER JOIN enrollements e ON u.user_id = e.user_id
 INNER JOIN courses c ON e.course_id = c.course_id;

-- view 조회 하기
SELECT
   *
  FROM enrolled_students;

-- view 삭제 하기
DROP VIEW ENROLLED_STUDENTS;


	/*
	 * view 사용 시 주의점
	뷰는 실제 데이터를 저장하지 않고 원본 테이블을 참조한다.
	원본 테이블의 데이터가 변경되면 뷰의 결과도 변경된다.
	성능 문제
	복잡한 뷰를 자주 사용할 경우 실행 성능이 저하될 수 있다.
	뷰 내부에 여러 개의 조인이 포함되어 있다면 쿼리 최적화를 고려해야 한다.
	뷰를 사용한 데이터 변경 제한
	일반적으로 뷰를 통해 데이터를 직접 수정 (insert, update, delete)하는 것은 제한된다.
	기본 키 (primary key)가 포함 된 경우 일부 뷰느 ㄴ데이터 수정이 가능하다. 하지만 그렇지 않으면 읽기 전용이다.
	

 * 
 */*/