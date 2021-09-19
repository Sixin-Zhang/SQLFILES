 select *
 from survey
 limit 10;

 
 SELECT question,
  COUNT(DISTINCT user_id)
FROM survey
GROUP BY 1;


SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

SELECT DISTINCT q.user_id, 
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs, 
  p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
 ON q.user_id = h.user_id
LEFT JOIN purchase p
 ON q.user_id = p.user_id
LIMIT 10;

WITH home_try_on_funnel AS (
 SELECT DISTINCT q.user_id, 
   CASE
     WHEN h.user_id IS NOT NULL THEN 'True'
     ELSE 'False'
     END AS 'is_home_try_on', 
   CASE
     WHEN h.number_of_pairs IS NULL THEN 'N/A'
     ELSE h.number_of_pairs
     END AS 'number_of_pairs',
   CASE
     WHEN p.user_id IS NOT NULL THEN 'True'
     ELSE 'False'
     END AS 'is_purchase'
 FROM quiz AS q
 LEFT JOIN home_try_on AS h
 	ON h.user_id = q.user_id
 LEFT JOIN purchase AS p
 	ON p.user_id = q.user_id)
SELECT *
FROM home_try_on_funnel
LIMIT 10;

WITH home_try_on_funnel AS (
  SELECT DISTINCT q.user_id,
  CASE WHEN h.user_id IS NOT NULL THEN 'True' ELSE 'False' END AS 'is_home_try_on',
  CASE WHEN h.number_of_pairs IS NULL THEN 'N/A' ELSE h.number_of_pairs END AS 'number_of_pairs',
  CASE WHEN p.user_id IS NOT NULL THEN 'True' ELSE 'False' END AS 
  'is_purchase'
FROM quiz AS q
 LEFT JOIN home_try_on AS h
 	ON h.user_id = q.user_id
 LEFT JOIN purchase AS p
 	ON p.user_id = q.user_id)
SELECT number_of_pairs, is_purchase,
  COUNT(is_purchase) AS 'Number of purchases'
FROM home_try_on_funnel
GROUP BY 1, 2
HAVING number_of_pairs IS NOT NULL;

WITH home_try_on_funnel AS(
 SELECT DISTINCT q.user_id, 
   CASE
     WHEN h.user_id IS NOT NULL THEN 'True'
     ELSE 'False'
     END AS 'is_home_try_on', 
   h.number_of_pairs,
   CASE
     WHEN p.user_id IS NOT NULL THEN 'True'
     ELSE 'False'
     END AS 'is_purchase'
 FROM quiz AS q
 LEFT JOIN home_try_on AS h
 	ON h.user_id = q.user_id
 LEFT JOIN purchase AS p
 	ON p.user_id = q.user_id)
SELECT COUNT(user_id) AS 'Users that completed the quiz', 
  COUNT(number_of_pairs) AS 'Users that did at home try-on',
  (SELECT COUNT(is_purchase) 
  FROM home_try_on_funnel 
  WHERE is_purchase = 'True') AS 'Users that made a purchase'
FROM home_try_on_funnel;

SELECT color 
FROM purchase
GROUP BY 1;

SELECT CASE
    WHEN color LIKE '%Tortoise%' THEN 'Tortoise'
    WHEN color LIKE '%Crystal%' THEN 'Crystal'
    WHEN color LIKE '%Fade%' THEN 'Fade'
    WHEN color LIKE '%Black%' THEN 'Black'
    ELSE 'Gray'
    END AS 'group_color',
  COUNT(*) AS 'number of purchases'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;

SELECT price, 
  COUNT(*) AS 'number of purchases'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;

SELECT model_name, color, price
FROM purchase
GROUP BY 1, 2
ORDER BY 3 DESC;
