CREATE TABLE BG_NOTICE(
	SEQ NUMBER(8) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	WDATE DATE NOT NULL,
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	READCOUNT NUMBER(8) NOT NULL,
	DEL NUMBER(1) NOT NULL
)

CREATE SEQUENCE SEQ_BG_NOTICE
START WITH 1
INCREMENT BY 1
NOCACHE;


SELECT * FROM BG_NOTICE


ALTER TABLE BG_NOTICE
ADD CONSTRAINT FK_BG_NOTICE_ID FOREIGN KEY(ID)
REFERENCES BG_MEMBER(ID)