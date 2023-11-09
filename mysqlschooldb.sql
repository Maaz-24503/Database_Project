DROP TABLE IF EXISTS `QUESTION_TYPES`;
DROP TABLE IF EXISTS `COURSE`;
DROP TABLE IF EXISTS `QUESTIONS`;
DROP TABLE IF EXISTS `CLO`;
DROP TABLE IF EXISTS `QUESTION_CLO`;
DROP TABLE IF EXISTS `QUALIFICATION`;
DROP TABLE IF EXISTS `FACULTY`;
DROP TABLE IF EXISTS `FACULTY_QUALIFICATION`;
DROP TABLE IF EXISTS `ASSESSMENT`;
DROP TABLE IF EXISTS `QUESTION_ASSESSMENT`;
DROP TABLE IF EXISTS `ECA`;
DROP TABLE IF EXISTS `ACADEMIC_YEAR`;
DROP TABLE IF EXISTS `CLASS`;
DROP TABLE IF EXISTS `STUDENT`;
DROP TABLE IF EXISTS `STUDENT_ECA`;
DROP TABLE IF EXISTS `STUDENT_ASMNT`;
DROP TABLE IF EXISTS `CLASS_TEACHER`;
DROP TABLE IF EXISTS `TRANSACTION`;
-- DROP TABLE IF EXISTS `ROLE`;

-- CREATE TABLE IF EXISTS ROLES (
--     ROLE_ID INT AUTO_INCREMENT PRIMARY KEY,
--     ROLE_TITLE VARCHAR(32) NOT NULL,
-- )

CREATE TABLE IF NOT EXISTS QUESTION_TYPES (
    QUESTION_TYPE INT AUTO_INCREMENT PRIMARY KEY,
    TYPE_NAME VARCHAR(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS COURSE (
    COURSE_ID VARCHAR(8) PRIMARY KEY,
    COURSE_NAME VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS CLO (
    CLO_ID VARCHAR(12) PRIMARY KEY,
    CLO_NAME VARCHAR(256) NOT NULL,
    CLO_DESC VARCHAR(1024),
    COURSE_ID VARCHAR(8),
    FOREIGN KEY (COURSE_ID) REFERENCES COURSE(COURSE_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS QUESTION (
    QUESTION_ID INT AUTO_INCREMENT PRIMARY KEY,
    QUESTION_DESC VARCHAR(1024) NOT NULL,
    QUESTION_TYPE INT,
    MAX_MARKS INT NOT NULL
    FOREIGN KEY (QUESTION_TYPE) REFERENCES QUESTION_TYPES(QUESTION_TYPE) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS QUESTION_CLO (
    QUESTION_ID INT,
    CLO_ID VARCHAR(12),
    PRIMARY KEY (QUESTION_ID, CLO_ID),
    FOREIGN KEY (QUESTION_ID) REFERENCES QUESTION(QUESTION_ID) ON DELETE CASCADE,
    FOREIGN KEY (CLO_ID) REFERENCES CLO(CLO_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS QUALIFICATION (
    QUALIFICATION_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS FACULTY (
    FACULTY_ID INT AUTO_INCREMENT PRIMARY KEY,
    CNIC VARCHAR(15) UNIQUE,
    FIRST_NAME VARCHAR(64) NOT NULL,
    LAST_NAME VARCHAR(64) NOT NULL,
    DOB DATE NOT NULL,
    GENDER VARCHAR(7),
    HIRE_DATE DATE NOT NULL,
    NATIONALITY VARCHAR(32) NOT NULL,
    RELIGION VARCHAR(128),
    FULL_TIME BOOLEAN,
    SALARY INT NOT NULL
);

CREATE TABLE IF NOT EXISTS FACULTY_QUALIFICATION (
    FACULTY_ID INT,
    QUALIFICATION_ID INT,
    PRIMARY KEY (FACULTY_ID, QUALIFICATION_ID),
    FOREIGN KEY (FACULTY_ID) REFERENCES FACULTY(FACULTY_ID) ON DELETE CASCADE,
    FOREIGN KEY (QUALIFICATION_ID) REFERENCES QUALIFICATION(QUALIFICATION_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ASSESSMENT (
    ASSESSMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
    COURSE_ID VARCHAR(8),
    FACULTY_ID INT,
    MAX_MARKS INT NOT NULL,
    ASSESSMENT_DATE DATE,
    ASSESSMENT_TYPE VARCHAR(64),
    FOREIGN KEY (COURSE_ID) REFERENCES COURSE(COURSE_ID) ON DELETE CASCADE,
    FOREIGN KEY (FACULTY_ID) REFERENCES FACULTY(FACULTY_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS QUESTION_ASSESSMENT (
    QUESTION_ID INT,
    ASSESSMENT_ID INT,
    PRIMARY KEY (QUESTION_ID, ASSESSMENT_ID),
    FOREIGN KEY (QUESTION_ID) REFERENCES QUESTION(QUESTION_ID) ON DELETE CASCADE,
    FOREIGN KEY (ASSESSMENT_ID) REFERENCES ASSESSMENT(ASSESSMENT_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ECA (
    ECA_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS ACADEMIC_YEAR(
    START_YEAR INT PRIMARY KEY,
    ACADEMIC_DESC VARCHAR(16) NOT NULL
);

CREATE TABLE IF NOT EXISTS CLASS (
    CLASS_ID INT AUTO_INCREMENT PRIMARY KEY,
    STRENGTH INT NOT NULL,
    YEAR INT NOT NULL,
    SECTION VARCHAR(4) NOT NULL,
    START_YEAR INT,
    FOREIGN KEY (START_YEAR) REFERENCES ACADEMIC_YEAR(START_YEAR) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS STUDENT (
    STUDENT_ID INT AUTO_INCREMENT PRIMARY KEY,
    CNIC VARCHAR(15) UNIQUE,
    FIRST_NAME VARCHAR(64) NOT NULL,
    LAST_NAME VARCHAR(64) NOT NULL,
    DOB DATE NOT NULL,
    CLASS_ID INT,
    GENDER VARCHAR(7),
    EMERGENCY_CONTACT VARCHAR(20) NOT NULL,
    ADMISSION_DATE DATE NOT NULL,
    NATIONALITY VARCHAR(32) NOT NULL,
    RELIGION VARCHAR(128),
    FOREIGN KEY (CLASS_ID) REFERENCES CLASS(CLASS_ID)
);

CREATE TABLE IF NOT EXISTS STUDENT_ECA (
    STUDENT_ID INT,
    ECA_ID INT,
    ROLE VARCHAR(128),
    PRIMARY KEY (STUDENT_ID, ECA_ID),
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE,
    FOREIGN KEY (ECA_ID) REFERENCES ECA(ECA_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS STD_ASMNT (
    STUDENT_ID INT,
    ASSESSMENT_ID INT,
    OBTAINED_MARKS INT NOT NULL,
    SUBMISSION_DATE DATE NOT NULL,
    PRIMARY KEY (STUDENT_ID, ASSESSMENT_ID),
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE,
    FOREIGN KEY (ASSESSMENT_ID) REFERENCES ASSESSMENT(ASSESSMENT_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CLASS_TEACHER (
    CLASS_ID INT,
    FACULTY_ID INT,
    PRIMARY KEY (CLASS_ID, FACULTY_ID),
    FOREIGN KEY (CLASS_ID) REFERENCES CLASS(CLASS_ID) ON DELETE CASCADE,
    FOREIGN KEY (FACULTY_ID) REFERENCES FACULTY(FACULTY_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CLASS_COURSE (
    CLASS_ID INT,
    COURSE_ID VARCHAR(8),
    START_TIME DATETIME NOT NULL,
    END_TIME DATETIME NOT NULL,
    FACULTY_ID INT,
    DAY VARCHAR(8) NOT NULL,
    PRIMARY KEY (COURSE_ID, FACULTY_ID, CLASS_ID, START_TIME, DAY),
    FOREIGN KEY (CLASS_ID) REFERENCES CLASS(CLASS_ID) ON DELETE CASCADE,
    FOREIGN KEY (COURSE_ID) REFERENCES COURSE(COURSE_ID) ON DELETE CASCADE,
    FOREIGN KEY (FACULTY_ID) REFERENCES FACULTY(FACULTY_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ATTENDANCE (
    STUDENT_ID INT,
    P_DATE DATE NOT NULL,
    PRESENT BOOLEAN NOT NULL,
    PRIMARY KEY (STUDENT_ID, P_DATE),
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS RELATION (
    RELATION_ID INT AUTO_INCREMENT PRIMARY KEY,
    RELATION_TYPE VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS GUARDIAN (
    GUARDIAN_ID INT AUTO_INCREMENT PRIMARY KEY,
    FIRST_NAME VARCHAR(64) NOT NULL,
    LAST_NAME VARCHAR(64) NOT NULL,
    CNIC VARCHAR(15) NOT NULL,
    PHONE_NUMBER VARCHAR(20) NOT NULL,
    OCCUPATION VARCHAR(128),
    NATIONALITY VARCHAR(32) NOT NULL,
    RELIGION VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS STUDENT_GUARDIAN (
    STUDENT_ID INT,
    GUARDIAN_ID INT,
    RELATION_ID INT,
    PRIMARY KEY (STUDENT_ID, GUARDIAN_ID),
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE,
    FOREIGN KEY (GUARDIAN_ID) REFERENCES GUARDIAN(GUARDIAN_ID) ON DELETE CASCADE,
    FOREIGN KEY (RELATION_ID) REFERENCES RELATION(RELATION_ID)
);

CREATE TABLE IF NOT EXISTS TRANSACTION (
    TRANSACTION_ID INT AUTO_INCREMENT PRIMARY KEY,
    STUDENT_ID INT,
    T_NAME VARCHAR(128),
    T_AMOUNT INT NOT NULL,
    T_DATE DATE NOT NULL,
    T_FLAG BOOLEAN not null default 1,
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ADMIN(
    ADMIN_ID INT AUTO_INCREMENT PRIMARY KEY,
    CNIC VARCHAR(15) UNIQUE,
    FIRST_NAME VARCHAR(64) NOT NULL,
    LAST_NAME VARCHAR(64) NOT NULL,
    HIRE_DATE DATE NOT NULL,
    GENDER VARCHAR(7),
    NATIONALITY VARCHAR(32) NOT NULL,
    RELIGION VARCHAR(128),
    SALARY INT NOT NULL
);

CREATE TABLE IF NOT EXISTS USERS (
    USERNAME VARCHAR(64) PRIMARY KEY,
    PASSWORD VARCHAR(64) NOT NULL,
    STUDENT_ID INT REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE,
    GUARDIAN_ID INT REFERENCES GUARDIAN(GUARDIAN_ID) ON DELETE CASCADE,
    FACULTY_ID INT REFERENCES FACULTY(FACULTY_ID) ON DELETE CASCADE,
    ADMIN_ID INT REFERENCES ADMIN(ADMIN_ID) ON DELETE CASCADE
);

ALTER TABLE FACULTY
ADD COLUMN PHONE_NUMBER VARCHAR(17) NOT NULL;

ALTER TABLE GUARDIAN
MODIFY COLUMN CNIC VARCHAR(15) UNIQUE;

-- REFERENCE COMMIT: relationService Completed, Database modifed
ALTER TABLE `STUDENT_GUARDIAN`
ADD COLUMN FLAG BOOLEAN NOT NULL DEFAULT TRUE;

-- REFERENCE COMMIT: attendanceService Complete, academicYearService created, Database changes
ALTER TABLE `ACADEMIC_YEAR`
ADD COLUMN DAYS INT NOT NULL DEFAULT 165;

ALTER TABLE `ATTENDANCE`
ADD COLUMN ACADEMIC_YEAR INT NOT NULL;

ALTER TABLE `ATTENDANCE`
ADD FOREIGN KEY (ACADEMIC_YEAR) REFERENCES ACADEMIC_YEAR(START_YEAR) ON DELETE CASCADE;

-- REFERENCE COMMIT: createdEnrollmentService, Finished academicYearService and Major Database changes

ALTER TABLE `ACADEMIC_YEAR`
ADD COLUMN FLAG BOOLEAN NOT NULL DEFAULT TRUE;

ALTER TABLE `STUDENT`
DROP FOREIGN KEY student_ibfk_1;

ALTER TABLE `STUDENT`
DROP INDEX `CLASS_ID`;

ALTER TABLE `STUDENT`
DROP COLUMN `CLASS_ID`;

ALTER TABLE `CLASS`
CHANGE `CLASS_ID`
`CLASS_ID` VARCHAR(9) NOT NULL;

DROP TABLE `CLASS_COURSE`;
DROP TABLE `CLASS_TEACHER`;
DROP TABLE `CLASS`

CREATE TABLE IF NOT EXISTS CLASS (
    CLASS_ID VARCHAR(9) PRIMARY KEY,
    STRENGTH INT NOT NULL,
    YEAR INT NOT NULL,
    SECTION VARCHAR(2) NOT NULL,
    START_YEAR INT,
    FOREIGN KEY (START_YEAR) REFERENCES ACADEMICYEAR(START_YEAR) ON DELETE CASCADE
);

CREATE TABLE `STUDENT_ACADEMIC_HISTORY`(
    STUDENT_ID INTEGER,
    CLASS_ID VARCHAR(9),
    ENROLLMENT_DATE DATETIME NOT NULL,
    PRIMARY KEY (STUDENT_ID, CLASS_ID),
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
    FOREIGN KEY (CLASS_ID) REFERENCES CLASS(CLASS_ID)
);

CREATE TABLE IF NOT EXISTS CLASS_COURSE (
    CLASS_ID VARCHAR(9) NOT NULL,
    COURSE_ID VARCHAR(8) NOT NULL,
    START_TIME DATETIME NOT NULL,
    END_TIME DATETIME NOT NULL,
    FACULTY_ID INT,
    DAY VARCHAR(8) NOT NULL,
    PRIMARY KEY (COURSE_ID, FACULTY_ID, CLASS_ID, START_TIME, DAY),
    FOREIGN KEY (CLASS_ID) REFERENCES CLASS(CLASS_ID) ON DELETE CASCADE,
    FOREIGN KEY (COURSE_ID) REFERENCES COURSE(COURSE_ID) ON DELETE CASCADE,
    FOREIGN KEY (FACULTY_ID) REFERENCES FACULTY(FACULTY_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CLASS_TEACHER (
    CLASS_ID VARCHAR(9) NOT NULL,
    FACULTY_ID INT,
    PRIMARY KEY (CLASS_ID, FACULTY_ID),
    FOREIGN KEY (CLASS_ID) REFERENCES CLASS(CLASS_ID) ON DELETE CASCADE,
    FOREIGN KEY (FACULTY_ID) REFERENCES FACULTY(FACULTY_ID) ON DELETE CASCADE
);

-- Reference Commit :

CREATE TABLE ROLES (
    ROLE_ID VARCHAR(16) PRIMARY KEY
)

INSERT INTO `roles` (`ROLE_ID`) VALUES
('ADMIN'),
('ALUMNI'),
('FACULTY'),
('GUARDIAN'),
('STAFF'),
('STUDENT');

CREATE TABLE IF NOT EXISTS NATIONALITIES (
    NAT_ID VARCHAR(128) PRIMARY KEY
)

INSERT INTO nationalities (NAT_ID) VALUES 
    ('Afghan'),
    ('Albanian'),
    ('Algerian'),
    ('American'),
    ('Andorran'),
    ('Angolan'),
    ('Antiguans'),
    ('Argentinean'),
    ('Armenian'),
    ('Australian'),
    ('Austrian'),
    ('Azerbaijani'),
    ('Bahamian'),
    ('Bahraini'),
    ('Bangladeshi'),
    ('Barbadian'),
    ('Barbudans'),
    ('Batswana'),
    ('Belarusian'),
    ('Belgian'),
    ('Belizean'),
    ('Beninese'),
    ('Bhutanese'),
    ('Bolivian'),
    ('Bosnian'),
    ('Brazilian'),
    ('British'),
    ('Bruneian'),
    ('Bulgarian'),
    ('Burkinabe'),
    ('Burmese'),
    ('Burundian'),
    ('Cambodian'),
    ('Cameroonian'),
    ('Canadian'),
    ('Cape Verdean'),
    ('Central African'),
    ('Chadian'),
    ('Chilean'),
    ('Chinese'),
    ('Colombian'),
    ('Comoran'),
    ('Congolese'),
    ('Costa Rican'),
    ('Croatian'),
    ('Cuban'),
    ('Cypriot'),
    ('Czech'),
    ('Danish'),
    ('Djibouti'),
    ('Dominican'),
    ('Dutch'),
    ('East Timorese'),
    ('Ecuadorean'),
    ('Egyptian'),
    ('Emirian'),
    ('Equatorial Guinean'),
    ('Eritrean'),
    ('Estonian'),
    ('Ethiopian'),
    ('Fijian'),
    ('Filipino'),
    ('Finnish'),
    ('French'),
    ('Gabonese'),
    ('Gambian'),
    ('Georgian'),
    ('German'),
    ('Ghanaian'),
    ('Greek'),
    ('Grenadian'),
    ('Guatemalan'),
    ('Guinea-Bissauan'),
    ('Guinean'),
    ('Guyanese'),
    ('Haitian'),
    ('Herzegovinian'),
    ('Honduran'),
    ('Hungarian'),
    ('I-Kiribati'),
    ('Icelander'),
    ('Indian'),
    ('Indonesian'),
    ('Iranian'),
    ('Iraqi'),
    ('Irish'),
    ('Israeli'),
    ('Italian'),
    ('Ivorian'),
    ('Jamaican'),
    ('Japanese'),
    ('Jordanian'),
    ('Kazakhstani'),
    ('Kenyan'),
    ('Kittian and Nevisian'),
    ('Kuwaiti'),
    ('Kyrgyz'),
    ('Laotian'),
    ('Latvian'),
    ('Lebanese'),
    ('Liberian'),
    ('Libyan'),
    ('Liechtensteiner'),
    ('Lithuanian'),
    ('Luxembourger'),
    ('Macedonian'),
    ('Malagasy'),
    ('Malawian'),
    ('Malaysian'),
    ('Maldivan'),
    ('Malian'),
    ('Maltese'),
    ('Marshallese'),
    ('Mauritanian'),
    ('Mauritian'),
    ('Mexican'),
    ('Micronesian'),
    ('Moldovan'),
    ('Monacan'),
    ('Mongolian'),
    ('Moroccan'),
    ('Mosotho'),
    ('Motswana'),
    ('Mozambican'),
    ('Namibian'),
    ('Nauruan'),
    ('Nepalese'),
    ('New Zealander'),
    ('Nicaraguan'),
    ('Nigerian'),
    ('Nigerien'),
    ('North Korean'),
    ('Northern Irish'),
    ('Norwegian'),
    ('Omani'),
    ('Pakistani'),
    ('Palauan'),
    ('Palestenian'),
    ('Panamanian'),
    ('Papua New Guinean'),
    ('Paraguayan'),
    ('Peruvian'),
    ('Polish'),
    ('Portuguese'),
    ('Qatari'),
    ('Romanian'),
    ('Russian'),
    ('Rwandan'),
    ('Saint Lucian'),
    ('Salvadoran'),
    ('Samoan'),
    ('San Marinese'),
    ('Sao Tomean'),
    ('Saudi'),
    ('Scottish'),
    ('Senegalese'),
    ('Serbian'),
    ('Seychellois'),
    ('Sierra Leonean'),
    ('Singaporean'),
    ('Slovakian'),
    ('Slovenian'),
    ('Solomon Islander'),
    ('Somali'),
    ('South African'),
    ('South Korean'),
    ('Spanish'),
    ('Sri Lankan'),
    ('Sudanese'),
    ('Surinamer'),
    ('Swazi'),
    ('Swedish'),
    ('Swiss'),
    ('Syrian'),
    ('Taiwanese'),
    ('Tajik'),
    ('Tanzanian'),
    ('Thai'),
    ('Togolese'),
    ('Tongan'),
    ('Trinidadian or Tobagonian'),
    ('Tunisian'),
    ('Turkish'),
    ('Tuvaluan'),
    ('Ugandan'),
    ('Ukrainian'),
    ('Uruguayan'),
    ('Uzbekistani'),
    ('Venezuelan'),
    ('Vietnamese'),
    ('Welsh'),
    ('Yemenite'),
    ('Zambian'),
    ('Zimbabwean');


CREATE TABLE IF NOT EXISTS RELIGIONS(
    RELIGION_ID VARCHAR(32) PRIMARY KEY
)

INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Christianity');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Judaism');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Islam');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Buddhism');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Hinduism');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Adventism');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Ayyavazhi');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Atheism');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Zoroastrianism');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Cultism');
INSERT INTO RELIGIONS (RELIGION_ID) VALUES ('Sikhism');

CREATE TABLE IF NOT EXISTS GENDERS(
    GENDER_ID VARCHAR(8) PRIMARY KEY
)

INSERT INTO GENDERS (GENDER_ID) VALUES ('Male');
INSERT INTO GENDERS (GENDER_ID) VALUES ('Female');
INSERT INTO GENDERS (GENDER_ID) VALUES ('Intersex');

DROP TABLE USERS;

CREATE TABLE IF NOT EXISTS USERS (
    USER_ID INT AUTO_INCREMENT PRIMARY KEY,
    CNIC VARCHAR(15) UNIQUE,
    FIRST_NAME VARCHAR(64) NOT NULL,
    LAST_NAME VARCHAR(64) NOT NULL,
    DOB DATE NOT NULL,
    GENDER VARCHAR(7) NOT NULL,
    EMERGENCY_CONTACT VARCHAR(20) NOT NULL,
    JOIN_DATE DATE NOT NULL,
    NATIONALITY VARCHAR(128) NOT NULL,
    RELIGION VARCHAR(128) NOT NULL,
    P_HASH VARCHAR(256) NOT NULL,
    ROLE_ID VARCHAR(16) NOT NULL,
    EMAIL_ADDRESS VARCHAR(256) NOT NULL,
    BLOCK BOOLEAN default false,
    ADDRESS VARCHAR(256) NOT NULL,
    PHONE VARCHAR(24) UNIQUE NOT NULL,
    FOREIGN KEY (ROLE_ID) REFERENCES ROLES(ROLE_ID),
    FOREIGN KEY (NATIONALITY) REFERENCES NATIONALITIES(NAT_ID),
    FOREIGN KEY (RELIGION) REFERENCES RELIGIONS(RELIGION_ID)
);

CREATE TABLE GUARDIAN_DETAILS(
	GUARDIAN_ID INT NOT NULL,
    OCCUPATION VARCHAR(128) NOT NULL,
    FOREIGN KEY (GUARDIAN_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE
);

CREATE TABLE EMPLOYEE_DETAILS(
	EMPLOYEE_ID INT NOT NULL,
    FULLTIME Boolean NOT NULL,
    SALARY INT,
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE
);

CREATE TABLE PROGRAM(
    PROGRAM_NAME VARCHAR(128) PRIMARY KEY,
    PROGRAM_DESC VARCHAR(512)
);

CREATE TABLE PLO(
    PLO_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    PLO_NAME VARCHAR(128),
    PLO_DESC VARCHAR(512)
);

CREATE TABLE PROGRAM_PLO(
    PLO_ID INTEGER,
    PROGRAM_NAME VARCHAR(128),
    FOREIGN KEY (PLO_ID) REFERENCES PLO(PLO_ID),
    FOREIGN KEY (PROGRAM_NAME) REFERENCES PROGRAM(PROGRAM_NAME)
);

CREATE TABLE PLO_CLO(
    PLO_ID INTEGER,
    CLO_ID VARCHAR(12),
    FOREIGN KEY (PLO_ID) REFERENCES PLO(PLO_ID),
    FOREIGN KEY (CLO_ID) REFERENCES CLO(CLO_ID)
);

INSERT INTO COURSE VALUES('cmpt100','Introduction To Programming');
INSERT INTO COURSE VALUES('phys1','Physics');
INSERT INTO COURSE VALUES('math1','Mathematics');
INSERT INTO COURSE VALUES('end1','English');
INSERT INTO COURSE VALUES('arb1','Arabic');
INSERT INTO class_course (CLASS_ID, COURSE_ID, FACULTY_ID) VALUES ('09-B-2024', 'cmpt100', 3);
INSERT INTO class_course (CLASS_ID, COURSE_ID, FACULTY_ID) VALUES ('09-B-2024', 'phys1', 3);
INSERT INTO class_course (CLASS_ID, COURSE_ID, FACULTY_ID) VALUES ('09-B-2024', 'math1', 3);
INSERT INTO class_course (CLASS_ID, COURSE_ID, FACULTY_ID) VALUES ('09-B-2024', 'end1', 3);
INSERT INTO class_course (CLASS_ID, COURSE_ID, FACULTY_ID) VALUES ('09-B-2024', 'arb1', 3);
