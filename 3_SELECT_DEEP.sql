/*
 * select 심화
	
	select 란 
	SQL에서 'Select 문을 사용하면 데이터베이스의 실제 테이블에서 데이터를 조회하여
	가상의 결과 집합 (가상의 테이블)을 형성하는 작업이다.
	
	이 결과 집합은 쿼리가 실행되는 동안만 존재하며, 실제 데이터베이스의 구조나 데이터에 영향을 주지 않는다.
	
	실 생활 비유 ; 친구 명단을 보고 싶을 때, 특정 조건에 따라 친구 목록 필터링
 * 
 * */

-- Inner Join
SELECT
    u.username,
    r.role_name
  FROM users u
 INNER JOIN roles r ON u.role_id = r.role_id;

/*
 * LEFT JOIN 과 RIGHT JOIN
 * LEFT JOIN 왼쪽 테이블의 모든 데이터와 오른쪽 테이블의 일치 데이터를 반환
 * RIGHT JOIN 오른쪽 테이블의 모든 데이터와 왼쪽 테이블의 일치 데이터를 반환
 * LEFT JOIN : 모든 사용자와 강좌를 조회
 * 
 */
  
  SELECT
  	  u.user_id,
      u.username,
      u.role_id,
      c.instructor_id
    FROM users u
    LEFT JOIN courses c ON u.user_id = c.instructor_id;

   SELECT
      u.username,
      c.instructor_id
    FROM users u
    RIGHT JOIN courses c ON u.user_id = c.instructor_id;
   
 
  
  