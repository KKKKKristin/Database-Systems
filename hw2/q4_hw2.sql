-- database : livesql.oracle.com
-- q4: for a given period (between start, end dates), on the following: number of scans, number of tests, number of employees who self-reported symptoms, number of positive cases. 


SELECT
  (SELECT COUNT(scan_id) FROM Scan 
   WHERE scan_date BETWEEN TO_DATE('2023-09-01', 'YYYY-MM-DD') AND TO_DATE('2023-09-03', 'YYYY-MM-DD')
  ) AS scan_number,

  (SELECT COUNT(test_id) FROM Test
   WHERE test_date BETWEEN TO_DATE('2023-09-01', 'YYYY-MM-DD') AND TO_DATE('2023-09-03', 'YYYY-MM-DD')
  ) AS test_number,

  (SELECT COUNT(employee_id) FROM 
   (SELECT DISTINCT employee_id, row_id FROM Symptom 
    WHERE date_reported BETWEEN TO_DATE('2023-09-03', 'YYYY-MM-DD') AND TO_DATE('2023-09-03', 'YYYY-MM-DD')
   )
  ) AS self_report_number,

  (SELECT COUNT(employee_id) FROM 
   (SELECT DISTINCT employee_id FROM Test 
    WHERE test_date BETWEEN TO_DATE('2023-09-03', 'YYYY-MM-DD') AND TO_DATE('2023-09-03', 'YYYY-MM-DD')
    AND test_result = 'positive'
   )
  ) AS positive_number
FROM dual;



