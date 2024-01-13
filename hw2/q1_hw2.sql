
-- database: livesql.oracle.com
-- q1: create tables and insert value


-- table employee
CREATE TABLE Employee ( 
  employee_id      NUMBER(3) NOT NULL, 
  employee_name    VARCHAR2(30 CHAR) NOT NULL, 
  office_number    NUMBER(4) NOT NULL, 
  floor_number     NUMBER(2) CONSTRAINT check_floor CHECK (floor_number >= 1 AND floor_number <= 10) NOT NULL, 
  phone_number     NUMBER NOT NULL, 
  email_address    VARCHAR2(50), 
  PRIMARY KEY (employee_id)
);


-- table meeting 
CREATE TABLE Meeting ( 
  meeting_id          NUMBER(3) NOT NULL, 
  employee_id         NUMBER(3) NOT NULL, 
  room_number         NUMBER NOT NULL, 
  floor_number        NUMBER NOT NULL, 
  meeting_start_time  NUMBER(2) CONSTRAINT check_meeting_start_time CHECK (meeting_start_time >= 8 AND meeting_start_time <= 18) NOT NULL, 
  PRIMARY KEY (meeting_id, employee_id), 
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) 
);


-- table notification
CREATE TABLE Notification ( 
  notification_id     NUMBER(3) NOT NULL, 
  employee_id         NUMBER(3) NOT NULL, 
  notification_date   DATE NOT NULL, 
  notification_type   VARCHAR2(20 CHAR) CONSTRAINT check_notification_type CHECK (notification_type IN ('mandatory', 'optional')) NOT NULL, 
  PRIMARY KEY (notification_id), 
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) 
);

--table symptom
CREATE TABLE Symptom ( 
  row_id              NUMBER(3) NOT NULL, 
  employee_id         NUMBER(3) NOT NULL, 
  date_reported       DATE NOT NULL, 
  symptom_id          NUMBER(1) CONSTRAINT check_symptom_id CHECK (symptom_id >= 1 AND symptom_id <= 5) NOT NULL, 
  PRIMARY KEY (row_id, employee_id), 
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) 
);


-- table scan
CREATE TABLE Scan( 
    scan_id NUMBER(3) NOT NULL, 
    employee_id NUMBER(3) NOT NULL, 
    scan_date DATE NOT NULL, 
    scan_time NUMBER(2) CONSTRAINT check_scan_time CHECK(scan_time >= 0 AND scan_time < 24) NOT NULL, 
    temperature NUMBER(3,1) NOT NULL, 
    PRIMARY KEY (scan_id, employee_id), 
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) 
);


-- table test
CREATE TABLE Test( 
    test_id NUMBER(3) NOT NULL, 
    location VARCHAR2(30 CHAR) NOT NULL, 
    employee_id NUMBER(3) NOT NULL, 
    test_date DATE NOT NULL, 
    test_time           NUMBER(2) CONSTRAINT check_test_time CHECK (test_time >= 0 AND test_time < 24) NOT NULL, 
    test_result         VARCHAR2(20 CHAR) CONSTRAINT check_test_result CHECK (test_result IN ('positive', 'negative')) NOT NULL, 
    PRIMARY KEY (test_id, employee_id), 
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) 
     
);




--table case
CREATE TABLE Cases( 
  case_id             NUMBER(3) NOT NULL, 
  employee_id         NUMBER(3) NOT NULL, 
  case_date           DATE NOT NULL, 
  resolution          VARCHAR2(20 CHAR) CONSTRAINT check_resolution CHECK (resolution IN ('back to work', 'left the company', 'deceased')) NOT NULL, 
  PRIMARY KEY (case_id, employee_id), 
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) 
);

-- table healthstatus
CREATE TABLE HealthStatus ( 
  row_id              NUMBER(3) NOT NULL, 
  case_id             NUMBER(3) NOT NULL, 
  employee_id         NUMBER(3) NOT NULL, 
  healthstatus_date   DATE NOT NULL, 
  status              VARCHAR2(20 CHAR) CONSTRAINT check_status CHECK (status IN ('sick', 'hospitalized', 'well')) NOT NULL, 
  PRIMARY KEY (row_id, employee_id, case_id), 
  -- here has a foreign key refer case_id, so we have to create cases table before healthstatus
  FOREIGN KEY (employee_id, case_id) REFERENCES Cases(employee_id, case_id) 
);



-- insert value in table employee
INSERT INTO Employee (employee_id, employee_name, office_number, floor_number, phone_number, email_address)
    SELECT 1, 'Amy', 1, 1, 2137020001, 'amy@gmail.com' FROM DUAL UNION ALL
    SELECT 2, 'Bob', 2, 1, 2137020002, 'bob@gmail.com' FROM DUAL UNION ALL
    SELECT 3, 'Cindy', 3, 2, 2137020003, 'cindy@gmail.com' FROM DUAL UNION ALL
    SELECT 4, 'David', 4, 2, 2137020004, 'david@gmail.com' FROM DUAL UNION ALL
    SELECT 5, 'Emily', 5, 2, 2137020005, 'emily@gmail.com' FROM DUAL UNION ALL
    SELECT 6, 'Frank', 6, 3, 2137020006, 'frank@gmail.com' FROM DUAL UNION ALL
    SELECT 7, 'Grace', 7, 9, 2137020007, 'grace@gmail.com' FROM DUAL UNION ALL
    SELECT 8, 'Hannah', 8, 3, 2137020008, 'hannah@gmail.com' FROM DUAL UNION ALL
    SELECT 9, 'Ian', 9, 3, 2137020009, 'ian@gmail.com' FROM DUAL UNION ALL
    SELECT 10, 'Jack', 10, 4, 2137020010, 'jack@gmail.com' FROM DUAL UNION ALL
    SELECT 11, 'Katherine', 1, 1, 2137020011, 'katherine@gmail.com' FROM DUAL UNION ALL
    SELECT 12, 'Liam', 12, 5, 2137020012, 'liam@gmail.com' FROM DUAL UNION ALL
    SELECT 13, 'Mia', 13, 2, 2137020013, 'mia@gmail.com' FROM DUAL UNION ALL
    SELECT 14, 'Noah', 14, 5, 2137020014, 'noah@gmail.com' FROM DUAL UNION ALL
    SELECT 15, 'Olivia', 15, 4, 2137020015, 'olivia@gmail.com' FROM DUAL UNION ALL
    SELECT 16, 'Parker', 16, 6, 2137020016, 'parker@gmail.com' FROM DUAL UNION ALL
    SELECT 17, 'Quinn', 17, 6, 2137020017, 'quinn@gmail.com' FROM DUAL UNION ALL
    SELECT 18, 'Ryan', 18, 7, 2137020018, 'ryan@gmail.com' FROM DUAL UNION ALL
    SELECT 19, 'Sophia', 19, 7, 2137020019, 'sophia@gmail.com' FROM DUAL UNION ALL
    SELECT 20, 'Thomas', 20, 4, 2137020020, 'thomas@gmail.com' FROM DUAL UNION ALL
    SELECT 21, 'Victoria', 21, 10, 2137020021, 'victoria@gmail.com' FROM DUAL UNION ALL
    SELECT 22, 'William', 21, 8, 2137020022, 'william@gmail.com' FROM DUAL UNION ALL
    SELECT 23, 'Xavier', 23, 9, 2137020023, 'xavier@gmail.com' FROM DUAL UNION ALL
    SELECT 24, 'Yasmine', 24, 9, 2137020024, 'yasmine@gmail.com' FROM DUAL UNION ALL
    SELECT 25, 'Zane', 25, 8, 2137020025, 'zane@gmail.com' FROM DUAL
;


-- insert value into table meeting
INSERT INTO Meeting (meeting_id, employee_id, room_number, floor_number, meeting_start_time)
    SELECT 1, 1, 1, 1, 10 FROM DUAL UNION ALL
    SELECT 5, 2, 5, 5, 14 FROM DUAL UNION ALL
    SELECT 2, 3, 2, 2, 11 FROM DUAL UNION ALL
    SELECT 2, 4, 2, 2, 11 FROM DUAL UNION ALL
    SELECT 1, 5, 1, 1, 10 FROM DUAL UNION ALL
    SELECT 3, 6, 3, 3, 12 FROM DUAL UNION ALL
    SELECT 6, 7, 6, 6, 15 FROM DUAL UNION ALL
    SELECT 4, 8, 4, 4, 13 FROM DUAL UNION ALL
    SELECT 5, 9, 5, 5, 14 FROM DUAL UNION ALL
    SELECT 7, 10, 7, 7, 16 FROM DUAL UNION ALL
    SELECT 3, 11, 3, 3, 12 FROM DUAL UNION ALL
    SELECT 6, 12, 6, 6, 15 FROM DUAL UNION ALL
    SELECT 7, 13, 7, 7, 16 FROM DUAL UNION ALL
    SELECT 2, 14, 2, 2, 11 FROM DUAL UNION ALL
    SELECT 1, 15, 1, 1, 10 FROM DUAL UNION ALL
    SELECT 3, 16, 3, 3, 12 FROM DUAL UNION ALL
    SELECT 5, 17, 5, 5, 14 FROM DUAL UNION ALL
    SELECT 4, 18, 4, 4, 13 FROM DUAL UNION ALL
    SELECT 4, 19, 4, 4, 13 FROM DUAL UNION ALL
    SELECT 6, 20, 6, 6, 15 FROM DUAL UNION ALL
    SELECT 3, 21, 3, 3, 12 FROM DUAL UNION ALL
    SELECT 7, 22, 7, 7, 16 FROM DUAL UNION ALL
    SELECT 2, 23, 2, 2, 11 FROM DUAL UNION ALL
    SELECT 7, 24, 7, 7, 16 FROM DUAL UNION ALL
    SELECT 1, 25, 1, 1, 10 FROM DUAL
;



-- insert value into table notification

INSERT INTO Notification (notification_id, employee_id, notification_date, notification_type) 
SELECT 1, 5, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 2, 10, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 3, 15, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 4, 20, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 5, 25, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 6, 1, TO_DATE('2023-09-03', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 7, 7, TO_DATE('2023-09-03', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 8, 12, TO_DATE('2023-09-04', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 9, 13, TO_DATE('2023-09-04', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 10, 22, TO_DATE('2023-09-04', 'YYYY-MM-DD'), 'mandatory' FROM DUAL UNION ALL
SELECT 11, 3, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'optional' FROM DUAL UNION ALL
SELECT 12, 4, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'optional' FROM DUAL UNION ALL
SELECT 13, 21, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'optional' FROM DUAL;


-- insert value into table symptom
INSERT INTO Symptom (row_id, employee_id, date_reported, symptom_id)
SELECT 1, 5, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 1 FROM DUAL UNION ALL
SELECT 2, 10, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 1 FROM DUAL UNION ALL
SELECT 3, 15, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 2 FROM DUAL UNION ALL
SELECT 4, 20, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 1 FROM DUAL UNION ALL
SELECT 5, 25, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 1 FROM DUAL UNION ALL
SELECT 6, 7, TO_DATE('2023-09-03', 'YYYY-MM-DD'), 2 FROM DUAL UNION ALL
SELECT 7, 12, TO_DATE('2023-09-04', 'YYYY-MM-DD'), 4 FROM DUAL UNION ALL
SELECT 8, 21, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 5 FROM DUAL;

-- insert value into table scan
INSERT INTO Scan (scan_id, employee_id, scan_date, scan_time, temperature)
SELECT 1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 10, 98.3 FROM DUAL UNION ALL
SELECT 2, 24, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 10, 98.3 FROM DUAL UNION ALL
SELECT 3, 3, TO_DATE('2023-09-03', 'YYYY-MM-DD'), 11, 98.2 FROM DUAL UNION ALL
SELECT 4, 10, TO_DATE('2023-09-04', 'YYYY-MM-DD'), 12, 98.6 FROM DUAL UNION ALL
SELECT 5, 19, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 13, 98.3 FROM DUAL UNION ALL
SELECT 6, 9, TO_DATE('2023-09-06', 'YYYY-MM-DD'), 9, 98.4 FROM DUAL;


-- insert value into table test
INSERT INTO Test (test_id, location, employee_id, test_date, test_time, test_result)
SELECT 1, 'company', 5, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 10, 'positive' FROM DUAL UNION ALL
SELECT 2, 'company', 10, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 10, 'positive' FROM DUAL UNION ALL
SELECT 3, 'company', 15, TO_DATE('2023-09-03', 'YYYY-MM-DD'), 11, 'positive' FROM DUAL UNION ALL
SELECT 4, 'company', 20, TO_DATE('2023-09-03', 'YYYY-MM-DD'), 14, 'positive' FROM DUAL UNION ALL
SELECT 5, 'company', 25, TO_DATE('2023-09-03', 'YYYY-MM-DD'), 12, 'positive' FROM DUAL UNION ALL
SELECT 6, 'company', 1, TO_DATE('2023-09-04', 'YYYY-MM-DD'), 9, 'negative' FROM DUAL UNION ALL
SELECT 7, 'company', 7, TO_DATE('2023-09-04', 'YYYY-MM-DD'), 10, 'positive' FROM DUAL UNION ALL
SELECT 8, 'company', 12, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 9, 'negative' FROM DUAL UNION ALL
SELECT 9, 'company', 13, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 11, 'negative' FROM DUAL UNION ALL
SELECT 10, 'company', 22, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 10, 'negative' FROM DUAL UNION ALL
SELECT 11, 'company', 21, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 10, 'negative' FROM DUAL;


-- insert value into table case
INSERT INTO Cases (case_id, employee_id, case_date, resolution)
SELECT 1, 5, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'left the company' FROM DUAL UNION ALL
SELECT 2, 10, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'left the company' FROM DUAL UNION ALL
SELECT 3, 15, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'left the company' FROM DUAL UNION ALL
SELECT 4, 20, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'left the company' FROM DUAL UNION ALL
SELECT 5, 25, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'left the company' FROM DUAL UNION ALL
SELECT 6, 7, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 'left the company' FROM DUAL UNION ALL
SELECT 7, 12, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 'back to work' FROM DUAL UNION ALL
SELECT 8, 21, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 'back to work' FROM DUAL;


-- insert data into table healthstatus
INSERT INTO HealthStatus (row_id, case_id, employee_id, healthstatus_date, status)
SELECT 1, 1, 5, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'hospitalized' FROM DUAL UNION ALL
SELECT 2, 2, 10, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'hospitalized' FROM DUAL UNION ALL
SELECT 3, 3, 15, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'hospitalized' FROM DUAL UNION ALL
SELECT 4, 4, 20, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'hospitalized' FROM DUAL UNION ALL
SELECT 5, 5, 25, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'hospitalized' FROM DUAL UNION ALL
SELECT 6, 6, 7, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'hospitalized' FROM DUAL UNION ALL
SELECT 7, 7, 12, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'well' FROM DUAL UNION ALL
SELECT 8, 8, 21, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'well' FROM DUAL;

