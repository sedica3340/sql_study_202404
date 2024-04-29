CREATE TABLE GOODS (
ID NUMBER(6) PRIMARY KEY,
GOOD_NAME VARCHAR2(10) NOT NULL,
PRICE NUMBER(10) DEFAULT 1000,
REG_DATE DATE
);

--INSERT
--SYSDATE = 현재시간
INSERT INTO GOODS
(ID,GOOD_NAME,PRICE,REG_DATE)
VALUES
 (1, '선풍기', 120000, SYSDATE);
 INSERT INTO GOODS
 (GOOD_NAME, ID ,REG_DATE, PRICE)
 VALUES
 ('점퍼', 5, SYSDATE, '49000');
 
-- 컬럼명 생략시 테이블구조 순서대로 자동 기입 
INSERT INTO GOODS

VALUES
(6, '냉장고', 1000000, SYSDATE);


 
 --UPDATE
 
 UPDATE GOODS
 SET GOOD_NAME = '에어컨'
 WHERE ID = 1
 ;
 
 UPDATE GOODS
 SET PRICE = 9999;
 
 UPDATE GOODS
 SET GOOD_NAME = '청바지',
    PRICE = 299000
    WHERE ID = 5;
    
    
-- DELETE

DELETE FROM GOODS
WHERE ID = 6;
 
 
-- 조건없이 DELETE 하면 전체삭제됨
DELETE FROM GOODS;
TRUNCATE TABLE GOODS;
DROP TABLE GOODS;


  SELECT * FROM GOODS;
  
-- SELECT 기본

SELECT
    certi_cd,
    CERTI_NM,
    ISSUE_INSTI_NM
FROM TB_CERTI;

SELECT
    CERTI_NM,
    ISSUE_INSTI_NM
FROM TB_CERTI;
  
SELECT DISTINCT -- 중복제거
    ISSUE_INSTI_NM
FROM TB_CERTI;

-- 컬럼 전체 조회
SELECT
    * 
FROM tb_certi;

SELECT
    emp_nm AS "사원명",
    addr AS "주소"
FROM tb_emp
;

SELECT
    emp_nm 사원명,
    addr 거주지_주소 -- 띄어쓰기 있을 때는 따옴표 생략 불가
FROM tb_emp
;
-- 문자열 결합하기
SELECT
    '자격증: ' || certi_nm AS "자격증 정보"
FROM tb_certi;

SELECT
    certi_nm || ' (' || issue_insti_nm || ')' AS "자격증"
FROM tb_certi
;