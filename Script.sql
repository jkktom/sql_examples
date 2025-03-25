SELECT
   user_id,
   RANK() OVER(PARTITION BY quiz_id ORDER BY score DESC) AS rank_value
  FROM quiz_attempts
 LIMIT 0,3;