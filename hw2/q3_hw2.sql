-- database : livesql.oracle.com
-- q3: output the 'sickest' floor.

SELECT floor_number AS sickest_floor
FROM (
  SELECT e.floor_number, COUNT(t.employee_id) AS number_size
  FROM test t
  JOIN Employee e ON t.employee_id = e.employee_id
  WHERE t.test_result = 'positive'
  GROUP BY e.floor_number
  ORDER BY number_size DESC
)
WHERE ROWNUM = 1;