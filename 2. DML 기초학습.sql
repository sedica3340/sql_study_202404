CREATE TABLE GOODS (
ID NUMBER(6) PRIMARY KEY,
GOOD_NAME VARCHAR2(10) NOT NULL,
PRICE NUMBER(10) DEFAULT 1000,
REG_DATE DATE
);

--INSERT
--SYSDATE = ����ð�
INSERT INTO GOODS
(ID,GOOD_NAME,PRICE,REG_DATE)
VALUES
 (1, '��ǳ��', 120000, SYSDATE);
 INSERT INTO GOODS
 (GOOD_NAME, ID ,REG_DATE, PRICE)
 VALUES
 ('����', 5, SYSDATE, '49000');
 
-- �÷��� ������ ���̺��� ������� �ڵ� ���� 
INSERT INTO GOODS

VALUES
(6, '�����', 1000000, SYSDATE);


 
 --UPDATE
 
 UPDATE GOODS
 SET GOOD_NAME = '������'
 WHERE ID = 1
 ;
 
 UPDATE GOODS
 SET PRICE = 9999;
 
 UPDATE GOODS
 SET GOOD_NAME = 'û����',
    PRICE = 299000
    WHERE ID = 5;
    
    
-- DELETE

DELETE FROM GOODS
WHERE ID = 6;
 
 
-- ���Ǿ��� DELETE �ϸ� ��ü������
DELETE FROM GOODS;
TRUNCATE TABLE GOODS;
DROP TABLE GOODS;


  SELECT * FROM GOODS;
  
-- SELECT �⺻

SELECT
    certi_cd,
    CERTI_NM,
    ISSUE_INSTI_NM
FROM TB_CERTI;

SELECT
    CERTI_NM,
    ISSUE_INSTI_NM
FROM TB_CERTI;
  
SELECT DISTINCT -- �ߺ�����
    ISSUE_INSTI_NM
FROM TB_CERTI;

-- �÷� ��ü ��ȸ
SELECT
    * 
FROM tb_certi;

SELECT
    emp_nm AS "�����",
    addr AS "�ּ�"
FROM tb_emp
;

SELECT
    emp_nm �����,
    addr ������_�ּ� -- ���� ���� ���� ����ǥ ���� �Ұ�
FROM tb_emp
;
-- ���ڿ� �����ϱ�
SELECT
    '�ڰ���: ' || certi_nm AS "�ڰ��� ����"
FROM tb_certi;

SELECT
    certi_nm || ' (' || issue_insti_nm || ')' AS "�ڰ���"
FROM tb_certi
;