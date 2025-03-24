-- group by를 사용하지 않는 경우

-- 강좌별 학생의 숫자를 보고자 하여 아래와 같이 조회

SELECT
    c.title "제목",
    c.course_id AS "강좌 번호"
  FROM courses c
 INNER JOIN enrollments e ON c.course_id = e.course_id
 
 -- group by
/*
* group by는 쿼리에서 지정한 필드에 대해 같은 값을 
갖는 행들을 그룹화 하는 기능이다.
이를 통해 각 그룹마다 집계 함수 (예: count, sum, avg)를 사용하여 그룹화된 데이터의 통계 정보를 계산 할 수 있다.
group by 구문을 사용하면, 동일한 값을 가진 행들이나 하나의 결과로 묶여 데이터 분석에 유용하게 사용할 수 있다.

그룹 함수는 여러 개의 행을 하나의 결과로 반환하기 때문에 1:n 관계의 값을 직접 사용할 수 있다.
예를 들어 count 와 sum 같은 집계 함수는 입력한 필드 전체를 대상으로 1개의 결과를 반환한다.
따라서 그룹화된 결과는 1(그룹): 1(결과) 관계가 형성된다.
그러나 concat 과 같은 문자열 함수는 개별 행의 값을 결합하므로, 그룹 함수와 함께 사용할 경우 예상치 못한 문제가 발생한다. 이 경우 1(그룹):n(결과) 관계가 형성되어
결과 테이블의 행 수가 맞지 않아 오류가 발생할 수 있다. */
 
SELECT
    c.title,
    c.course_id,
    COUNT(e.user_id)
  FROM courses c
  LEFT JOIN enrollments e ON c.course_id=e.course_id
 GROUP BY c.course_id, c.title;

SELECT
    c.title,
    COUNT(e.user_id)
  FROM courses c
  LEFT JOIN enrollments e ON c.course_id=e.course_id
 GROUP BY c.title
/*
	 * having
	having 은 group by로 그룹화된 결과에 대한 조건을 설정하는데 사용된다.
	이 절은 함수의 결과를 기반으로 필터링을 수행할 수 있도록 해준다.
	주어진 쿼리에서는 각 강좌의 수강생 수를 계산하고
	수강생 수가 60명 이상인 강좌만 결과로 포함한다.
	group by 절이 실행된 후, having 절이 적용되므로
	student_count 는 count(e.user_id)로 계산된 집계 결과이다.
	having 절은 where 절과 달리 집계 함수의 결과를 사용할 수 있다.
	원래의 데이터에 대한 필터링은 where 절에서 수행된다.

 */

 SELECT
     c.title,
     c.course_id,
     count(e.user_id) AS student_count
   FROM courses c
  INNER JOIN enrollments e ON c.course_id = e.course_id
  GROUP BY c.course_id, c.title 
 HAVING student_count >= 60;

 
 -- WHERE 절은 쿼리가 실행될 때 원래의 데이터 행을 필터링하는 데 사용된다.
-- 이 절은 GROUP BY 절이 "실행되기 전"에 적용되기 때문에,
-- 집계 함수인 COUNT(e.user_id)의 결과인 student_count를 참조할 수 없다.
-- 따라서 WHERE 절에서 student_count를 사용할 수 없다.

-- 반면 HAVING 절은 GROUP BY 절이 실행된 후에 적용되기 때문에
-- 이 절은 집계 함수의 결과를 기반으로 필터링할 수 있으며,
-- 따라서 COUNT(e.user_id)로 계산된 student_count를 참조할 수 있다.
-- 이는 HAVING 절이 그룹화된 데이터에 대한 조건을 설정할 수 있게 해준다.

/*
 * 그룹바이의 깊은 개념
 * 그룹바이는 기본적으로 모든 행을 읽고 난 이후에 실행이 된다.
 * 이러한 이유로 인해 내부적으로 I/O가 많이 발생하며, 정렬을 진행하는 과정에서 
 * 중간 결과를 저장하는 행위가 발생하게 되고 이 과정에서 메모리와 디스크 간의 
 * 데이터 이동이 추가로 발생되어 추가적인 I/O가 발생하게 된다.
 * 
 * 그룹화 작업이 수행될 때, 데이터베이스는 원본 테이블의 모든 행을 읽어 
 * 주어진 그룹화 기준에 따라 각 행을 적절한 그룹에 배치해야 한다. 
 * 따라서 데이터의 양이 많을수록 I/O 작업이 증가하게 된다.
 * 
 * 또한, GROUP BY 절은 그룹화된 결과를 정렬해야 하므로, 정렬 작업에도 
 * I/O가 발생한다. 이 과정에서 정렬된 데이터를 메모리에 저장하고, 
 * 필요한 경우 디스크에 임시로 저장하는 과정이 추가적으로 발생할 수 있다.
 * 
 * 이러한 이유로 인해 그룹바이는 인덱스를 통해 자주 그룹화하는 값에 대해 
 * 사전 정렬을 해주는 것이 좋다. 인덱스를 활용하면 전체 테이블 스캔을 
 * 피하고 필요한 데이터에 직접 접근할 수 있어 I/O를 줄이고 
 * 쿼리 성능을 향상시킬 수 있다.
 * 
 * 마지막으로, 데이터베이스의 쿼리 최적화 기법을 활용하여 
 * 그룹화 작업을 최소화하거나 효율적으로 수행하는 것도 
 * 성능을 개선하는 데 중요한 요소이다.
 */
