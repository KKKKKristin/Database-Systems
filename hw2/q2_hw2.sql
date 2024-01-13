-- database: livesql.oracle.com
-- q2: output the most-self-reported symptom.

SELECT symptom_id
FROM (
  SELECT symptom_id, COUNT(row_id) AS num
  FROM Symptom
  GROUP BY symptom_id
  ORDER BY num DESC
)
FETCH FIRST 1 ROW ONLY;