DROP TABLE MOVIE CASCADE CONSTRAINTS;
CREATE TABLE MOVIE(
  Id NUMBER NOT NULL,
 	Title  VARCHAR(100) NOT NULL,
  mType VARCHAR(30) NOT NULL, 
  Runtime NUMBER NOT NULL,
  --Cumulative_audience Number DEFAULT 0,
  Start_year DATE NOT NULL,
  End_year DATE,
  --Keyword VARCHAR(10),
  --Famous_line VARCHAR(25),
  Admin_id  VARCHAR(25) NOT NULL,
  Rating FLOAT DEFAULT 0,
  Num_of_votes  NUMBER DEFAULT 0,
	Director VARCHAR(30),
	Writer VARCHAR(30),
  Company VARCHAR(20),
  Descriptions VARCHAR(200),
  PRIMARY KEY(Id)
);

-- 2
DROP TABLE ACCOUNT CASCADE CONSTRAINTS;
CREATE TABLE ACCOUNT(
  -- general info: Id, Password, Phone_number
  Id VARCHAR(25),
  Password VARCHAR(25) NOT NULL,
  Phone_number VARCHAR(20) NOT NULL,

  Membership_grade NUMBER, -- 0: basic, 1: premium 2: prime
  -- Addtion info
  Birthday DATE,
  is_admin NUMBER DEFAULT 0, -- 0: USER, 1: ADMIN
  Gender CHAR,
  Address VARCHAR(30),
  Job VARCHAR(15),
  Watching_limit NUMBER,
  First_name VARCHAR(20),
  Middle_name VARCHAR(20),
  Last_name VARCHAR(20),
  PRIMARY KEY(Id),
  UNIQUE(Phone_number)
);

DROP TABLE USERS CASCADE CONSTRAINTS;
CREATE TABLE USERS(
  Account_id VARCHAR(25), --fk
  User_name VARCHAR(15) NOT NULL,
  PRIMARY KEY(Account_id, User_name)
);

DROP TABLE VERSION CASCADE CONSTRAINTS;
CREATE TABLE VERSION(
  Movie_id      NUMBER,
  Subtitle         VARCHAR(20),
  Title         VARCHAR(20) NOT NULL,   
  Region         VARCHAR(20) NOT NULL,
  Language         VARCHAR(20) NOT NULL,
  Is_original_title      NUMBER(1),
  PRIMARY KEY(Movie_id, Region)
);

DROP TABLE ACTOR CASCADE CONSTRAINTS;
CREATE TABLE ACTOR(
Id         NUMBER NOT NULL,
BYear         VARCHAR(4)
Dyear         VARCHAR(4) DEFAULT NULL,
Gender         CHAR,
AName         VARCHAR(20),
PRIMARY KEY(Id)
);

DROP TABLE PLAY CASCADE CONSTRAINTS;
CREATE TABLE PLAY(
  Movie_id      NUMBER NOT NULL,
  Actor_id      NUMBER NOT NULL,
  cast      VARCHAR(20), -- role name
  PRIMARY KEY(Movie_id, Actor_id)
);

DROP TABLE GENRE CASCADE CONSTRAINTS;
CREATE TABLE GENRE(
    --Genre_Name NUMBER NOT NULL,
    Name VARCHAR(20) NOT NULL,
    PRIMARY KEY(Name)
);

DROP TABLE GENRE_OF CASCADE CONSTRAINTS;
CREATE TABLE GENRE_OF(
    Movie_id NUMBER NOT NULL,
    -- G_name NUMBER NOT NULL,
    Genre_name VARCHAR(20) NOT NULL,
    PRIMARY KEY(Movie_id, Genre_Name)
);

DROP TABLE REVIEW CASCADE CONSTRAINTS;
CREATE TABLE REVIEW(
    Account_id VARCHAR(25) NOT NULL,
    Movie_id NUMBER NOT NULL,
    Review_limit NUMBER DEFAULT 0,
    PRIMARY KEY(Account_id, Movie_id)
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
    Comments VARCHAR(200),
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