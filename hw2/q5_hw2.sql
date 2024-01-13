-- database : livesql.oracle.com
-- q5: output the employees who have covid-19 symptom but test_result are negative

SELECT employee_id AS potential_covid_employee
FROM (
    SELECT t.employee_id
    FROM Test t
	JOIN Symptom s ON t.employee_id = s.employee_id
	WHERE t.test_result = 'negative'
	GROUP BY t.employee_id
)