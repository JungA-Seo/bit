DROP TABLE MEMBER
CASCADE CONSTRAINTS;

CREATE TABLE MEMBER(
    ID VARCHAR2(50) PRIMARY KEY,
    PWD VARCHAR2(50) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    BIRTH VARCHAR2(50) NOT NULL,
    GENDER VARCHAR2(10) NOT NULL,
    EMAIL VARCHAR2(50) NOT NULL,
    ADDR VARCHAR2(200) NOT NULL,
    AUTH NUMBER(1) NOT NULL
);

-- 세미프로젝트 MEMBER는 추후에 MEM으로 이름 변경적용하기
-- 파이널프로젝트에서 동일명인 MEMBER 테이블 써야해서 삭제함 (이 주석은 2021.08.11에 작성했음)

INSERT INTO MEMBER (ID, PWD, NAME, BIRTH, GENDER, EMAIL, ADDR, AUTH)
VALUES('admin', '1234', '관리자', '00000000', '남자', 'admin@admin.com', '서울시 마포구 백범로23, 3층', '3');

INSERT INTO MEMBER (ID, PWD, NAME, BIRTH, GENDER, EMAIL, ADDR, AUTH)
VALUES('mem', '1234', '남규', '19931103', '남자', 'skarbsla93@naver.com', '서울시 마포구 와우산로14길19, 3층', '0');

select * from member;