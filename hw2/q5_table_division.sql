-- database : livesql.oracle.com
-- q5_table_division: output the employees who are super healthy(no symptom and not positive)

SELECT e.employee_id
FROM Employee e
WHERE 
  e.employee_id NOT IN (
    SELECT t.employee_id
    FROM Test t
    WHERE t.test_result = 'positive'
  )
  AND
  e.employee_id NOT IN (
    SELECT s.employee_id
    FROM Symptom s
    WHERE s.symptom_id = 1 
  );


