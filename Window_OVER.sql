		/*
		 * 윈도우 함수
		
		group by와 다르게, 각 행을 개별적으로 유지하면서
		그룹별 계산이 가능하다.
		주로 순위 계산, 누적 합계, 이동 평균, 백분위 계산 등에 활용된다.
		
		
		 * 
		 */
		
SELECT
    quiz_id,
    user_id,
    score,
    RANK() OVER(PARTITION BY quiz_id ORDER BY score DESC) AS rank_value,
    DENSE_RANK() OVER(PARTITION BY quiz_id ORDER BY score DESC) AS dense_rank_value,
    ROW_NUMBER() OVER(PARTITION BY quiz_id ORDER BY score DESC) AS row_num_value
  FROM quiz_attempts
 WHERE quiz_id = 1;
    /*
     * OVER 절 SQL 에서 윈도우 함수를 사용할 때 데이터의 특정 집합에 대해 계산을 수행하는 데 사용된다.
PARTITION BY : 데이터 그룹화
RANK 같은 점수일 경우 동일한 순위를 부여, 다음 순위 건너 뜀
DENSE_RANK() 같은 점수 일 경우 동일한 순위를 부여하지만, 다음 순위를 건너뛰지 않음
ROW_NUMBER() 무조건 고유한 순위 부여
     */


  
  
  