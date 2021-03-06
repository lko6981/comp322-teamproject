DROP TABLE MOVIE CASCADE CONSTRAINTS;
CREATE TABLE MOVIE(
  Id NUMBER NOT NULL,
 	Title  VARCHAR(100) NOT NULL,
  mType VARCHAR(30) NOT NULL,
  Runtime NUMBER NOT NULL,
  Start_year DATE NOT NULL,
  End_year DATE,
  Admin_id  VARCHAR(25) NOT NULL,
  Rating FLOAT DEFAULT 0,
  Num_of_votes  NUMBER DEFAULT 0,
	Director VARCHAR(110),
	Writer VARCHAR(100),
  Company VARCHAR(100),
  Descriptions VARCHAR(500),
  PRIMARY KEY(Id)
);

-- 2
DROP TABLE ACCOUNT CASCADE CONSTRAINTS;
CREATE TABLE ACCOUNT(
  -- general info: Id, Password, Phone_number
  Id VARCHAR(25),
  Password VARCHAR(25) NOT NULL,
  Phone_number VARCHAR(20) NOT NULL,
  Name VARCHAR(30),
  Membership_grade NUMBER, -- 0: basic, 1: premium 2: prime  3:admin
  -- Addtion info
  Gender CHAR,
  Age NUMBER,      
  Birthday DATE,
  Job VARCHAR(20),
  Address VARCHAR(30),
  PRIMARY KEY(Id),
  UNIQUE(Phone_number)
);

DROP TABLE VERSION CASCADE CONSTRAINTS;
CREATE TABLE VERSION(
  Movie_id      NUMBER,
  Title         VARCHAR(200) NOT NULL,   
  Region         VARCHAR(20) NOT NULL,
  Language         VARCHAR(20) NOT NULL,
  Is_original_title      NUMBER(1), -- 0: false, 1: true
  PRIMARY KEY(Movie_id, Region)
);

DROP TABLE ACTOR CASCADE CONSTRAINTS;
CREATE TABLE ACTOR(
  Id         NUMBER NOT NULL,
  Byear         VARCHAR(4),
  Dyear         VARCHAR(4) DEFAULT NULL,
  Gender         CHAR,
  Aname         VARCHAR(20),
  PRIMARY KEY(Id)
);

DROP TABLE PLAY CASCADE CONSTRAINTS;
CREATE TABLE PLAY(
  Movie_id      NUMBER NOT NULL,
  Actor_id      NUMBER NOT NULL,
  cast      VARCHAR(50), -- role name
  PRIMARY KEY(Movie_id, Actor_id)
);

DROP TABLE GENRE CASCADE CONSTRAINTS;
CREATE TABLE GENRE(
    Name VARCHAR(20) NOT NULL,
    PRIMARY KEY(Name)
);

DROP TABLE GENRE_OF CASCADE CONSTRAINTS;
CREATE TABLE GENRE_OF(
    Movie_id NUMBER NOT NULL,
    Genre_name VARCHAR(20) NOT NULL,
    PRIMARY KEY(Movie_id, Genre_Name)
);

DROP TABLE EPISODE CASCADE CONSTRAINTS;
CREATE TABLE EPISODE(
    Movie_id NUMBER NOT NULL,
    EP_title VARCHAR(50) NOT NULL,
    EP_num NUMBER NOT NULL,
    Season_title VARCHAR(50) NOT NULL,
    Season_num NUMBER NOT NULL,
    PRIMARY KEY(Movie_id, EP_title)
);

DROP TABLE WATCH CASCADE CONSTRAINTS;
CREATE TABLE WATCH(
    Movie_id NUMBER NOT NULL,
    Account_id VARCHAR(25) NOT NULL,
    PRIMARY KEY(Movie_Id, Account_id)
);

DROP TABLE RATING CASCADE CONSTRAINTS;
CREATE TABLE RATING(
    Rating_id  NUMBER,
    Account_id VARCHAR(25) NOT NULL,
    Stars NUMBER NOT NULL,
    Movie_id NUMBER NOT NULL,
    PRIMARY KEY(Rating_id, Account_Id)
);

ALTER TABLE RATING ADD FOREIGN KEY(Account_id) REFERENCES ACCOUNT(Id) ON DELETE SET NULL;
ALTER TABLE RATING ADD FOREIGN KEY(Movie_id) REFERENCES MOVIE(Id) ON DELETE CASCADE;

ALTER TABLE MOVIE ADD FOREIGN KEY(Admin_id) REFERENCES ACCOUNT(Id) ON DELETE CASCADE;

ALTER TABLE USERS ADD FOREIGN KEY(Account_id) REFERENCES ACCOUNT(Id) ON DELETE CASCADE;

ALTER TABLE VERSION ADD FOREIGN KEY(Movie_id) REFERENCES MOVIE(Id) ON DELETE CASCADE;

ALTER TABLE PLAY ADD FOREIGN KEY(Movie_id) REFERENCES MOVIE(Id) ON DELETE CASCADE;
ALTER TABLE PLAY ADD FOREIGN KEY(Actor_id) REFERENCES ACTOR(Id) ON DELETE CASCADE;

ALTER TABLE GENRE_OF ADD FOREIGN KEY(Movie_id) REFERENCES MOVIE(Id) ON DELETE CASCADE;
ALTER TABLE GENRE_OF ADD FOREIGN KEY(Genre_name) REFERENCES GENRE(Name) ON DELETE CASCADE;

ALTER TABLE REVIEW ADD FOREIGN KEY(Account_id) REFERENCES ACCOUNT(Id) ON DELETE SET NULL;
ALTER TABLE REVIEW ADD FOREIGN KEY(Movie_id) REFERENCES MOVIE(Id) ON DELETE CASCADE;

ALTER TABLE WATCH ADD FOREIGN KEY(Account_id) REFERENCES ACCOUNT(Id) ON DELETE SET NULL;
ALTER TABLE WATCH ADD FOREIGN KEY(Movie_id) REFERENCES MOVIE(Id) ON DELETE CASCADE;

ALTER TABLE EPISODE ADD FOREIGN KEY(Movie_id) REFERENCES MOVIE(Id) ON DELETE CASCADE;

commit;