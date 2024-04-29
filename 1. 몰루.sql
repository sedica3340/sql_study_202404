select * from tb_emp;

-- 테이블 생성(DDL: 데이터 정의어)
-- 학생들의 성적 정보를 저장할 데이터 구조
CREATE TABLE tbl_score (
    name VARCHAR2(4) NOT NULL,
    kor NUMBER(3) NOT NULL CHECK(kor >= 0 AND kor <= 100),
    eng NUMBER(3) NOT NULL CHECK(eng >= 0 AND eng <= 100),
    math NUMBER(3) NOT NULL CHECK(math >= 0 AND math <= 100),
    total NUMBER(3) NULL,
    average NUMBER(5, 2),
    grade CHAR(1),
    stu_num NUMBER(6) PRIMARY KEY
);
--ALTER문으로 제약조건 추가하기
-- STU_NUM에 깜빡하고 PRIMARY KEY를 안걸었다
ALTER TABLE TBL_SCORE
ADD CONSTRAINT PK_TBL_SCORE
PRIMARY KEY (STU_NUM);

--PK를 제거
ALTER TABLE TBL_SCORE
DROP CONSTRAINT PK_TBL_SCORE;

SELECT * FROM TBL_SCORE;
-- 컬럼 추가하기
ALTER TABLE TBL_SCORE
ADD (SCI NUMBER(3) NOT NULL);
-- 컬럼 제거하기
ALTER TABLE TBL_SCORE
DROP COLUMN SCI;

-- drop: 테이블 제거, 강력한 제거
-- 테이블 복사 (CTAS)
CREATE TABLE TB_EMP_COPY
AS SELECT * FROM TB_EMP;

DROP TABLE TB_EMP_COPY;

SELECT * FROM TB_EMP_COPY;

-- TRUNCATE :
-- 구조는 남기고 안에 데이터만 삭제하기
-- 테이블이 생성된 초기상태로 돌아간다

TRUNCATE TABLE TB_EMP_COPY;