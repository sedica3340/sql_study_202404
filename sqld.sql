select * from tb_emp;

-- ���̺� ����(DDL: ������ ���Ǿ�)
-- �л����� ���� ������ ������ ������ ����
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
--ALTER������ �������� �߰��ϱ�
-- STU_NUM�� �����ϰ� PRIMARY KEY�� �Ȱɾ���
ALTER TABLE TBL_SCORE
ADD CONSTRAINT PK_TBL_SCORE
PRIMARY KEY (STU_NUM);

--PK�� ����
ALTER TABLE TBL_SCORE
DROP CONSTRAINT PK_TBL_SCORE;

SELECT * FROM TBL_SCORE;
-- �÷� �߰��ϱ�
ALTER TABLE TBL_SCORE
ADD (SCI NUMBER(3) NOT NULL);
-- �÷� �����ϱ�
ALTER TABLE TBL_SCORE
DROP COLUMN SCI;

-- drop: ���̺� ����, ������ ����
-- ���̺� ���� (CTAS)
CREATE TABLE TB_EMP_COPY
AS SELECT * FROM TB_EMP;

DROP TABLE TB_EMP_COPY;

SELECT * FROM TB_EMP_COPY;

-- TRUNCATE :
-- ������ ����� �ȿ� �����͸� �����ϱ�
-- ���̺��� ������ �ʱ���·� ���ư���

TRUNCATE TABLE TB_EMP_COPY;