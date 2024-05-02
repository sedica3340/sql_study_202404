-- ����� ���, �̸�, �μ���ȣ, �μ��� ��ȸ
SELECT
    tb_emp.emp_no ���,
    tb_emp.emp_nm �̸�,
    tb_emp.dept_cd �μ���ȣ,
    tb_dept.dept_nm �μ���
FROM tb_emp
INNER JOIN tb_dept
ON tb_emp.dept_cd = tb_dept.dept_cd
;
SELECT
    tb_emp.emp_no ���,
    tb_emp.emp_nm �̸�,
    tb_emp.dept_cd �μ���ȣ,
    tb_dept.dept_nm �μ���
FROM tb_emp, tb_dept
WHERE tb_emp.dept_cd = tb_dept.dept_cd
;
-- ���� ���� �׽�Ʈ ������
CREATE TABLE TEST_A (
    id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);
CREATE TABLE TEST_B (
    b_id NUMBER(10) PRIMARY KEY
    , reply VARCHAR2(100)
    , a_id NUMBER(10)
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, '������', 1);
INSERT INTO TEST_B  VALUES (2, '������', 1);
INSERT INTO TEST_B  VALUES (3, '������', 2);
INSERT INTO TEST_B  VALUES (4, '������', 3);

SELECT * FROM test_a;
SELECT * FROM test_b;

-- ������ ������ ���ϱ⿬��
-- Cartesian production : product����
-- Cross Join : ������ ��� ����� ���� ��Ī�Ͽ� ��ȸ
SELECT
    *
FROM test_a, test_b
;

-- INNER JOIN
-- �� ���̺� ���� �����÷��� �̿��Ͽ�
-- ���谡 �ִ� �����͸� ��Ī�Ͽ� ����
SELECT
    *
FROM test_a, test_b
WHERE test_a.id = test_b.a_id
;

SELECT
test_a.id,
test_a.content,
test_b.reply
FROM test_a
INNER JOIN test_b
ON test_a.id = test_b.a_id
;

SELECT
    E.emp_no ���,
    E.emp_nm �̸�,
    E.addr �ּ�,
    E.tel_no ����ó,
    E.dept_cd �μ���ȣ,
    D.dept_nm �μ���
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
;

-- ����� �����ȣ�� ����� �ڰ��� ���� ��ȸ
SELECT
    E.EMP_NM,
    E.emp_no,
    EC.certi_cd,
    EC.acqu_de,
    C.certi_nm
FROM tb_emp E,tb_emp_certi EC, tb_certi C
WHERE 1=1
    AND E.emp_no = EC.emp_no 
    AND EC.certi_cd = C.certi_cd
ORDER BY e.emp_no
;

-- ����� �����ȣ�� ����� �ڰ��� ��, �μ��� ���� ��ȸ
SELECT
    E.EMP_NM �̸�,
    E.emp_no ���,
    D.dept_nm �μ�,
    EC.certi_cd �ڰ����ڵ�,
    EC.acqu_de �����,
    C.certi_nm �ڰ�����
FROM tb_emp E,tb_emp_certi EC, tb_certi C, tb_dept D
WHERE 1=1
    AND E.emp_no = EC.emp_no 
    AND EC.certi_cd = C.certi_cd
    AND E.dept_cd = D.dept_cd
ORDER BY e.emp_no
;


-- �μ����� �� �ڰ��� ��� ������ ��ȸ

SELECT
    D.dept_cd �μ��ڵ�,
    D.dept_nm �μ���,
    COUNT(EC.certi_cd) �ڰ�������
FROM tb_emp E, tb_dept D, tb_emp_certi EC
WHERE E.emp_no = EC.emp_no
    AND E.dept_cd = D.dept_cd
GROUP BY D.dept_cd, D.dept_nm
ORDER BY D.dept_cd
;

-- # INNER JOIN
-- 1. 2�� �̻��� ���̺��� ����� �÷��� ���� �������� ���յǴ� ���α���Դϴ�.
-- 2. WHERE���� ���� �÷����� �������(=)�� ���� ���ε˴ϴ�.

-- ���νÿ� ��� �达 ����� �����ȣ, �����, �ּ�, �μ��ڵ�, �μ����� ��ȸ�ϰ� �ʹ�.
SELECT
    E.emp_no ���,
    E.emp_nm �̸�,
    SUBSTR(E.addr, 9) "�ּ�(��⵵ ���ν�)",
    E.dept_cd �μ��ڵ�,
    d.dept_nm �μ���
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
AND E.addr LIKE '%����%'
AND E.emp_nm LIKE '��%'
;

SELECT
    E.emp_no ���,
    E.emp_nm �̸�,
    SUBSTR(E.addr, 9) "�ּ�(��⵵ ���ν�)",
    E.dept_cd �μ��ڵ�,
    d.dept_nm �μ���
FROM tb_emp E
INNER JOIN  tb_dept D
ON E.dept_cd = D.dept_cd
WHERE 1=1
AND E.addr LIKE '%����%'
AND D.dept_nm LIKE '%������%'
;

-- ����� �����ȣ�� ����� �ڰ��� ��, �μ��� ���� ��ȸ
SELECT
    E.EMP_NM �̸�,
    E.emp_no ���,
    D.dept_nm �μ�,
    EC.certi_cd �ڰ����ڵ�,
    EC.acqu_de �����,
    C.certi_nm �ڰ�����
FROM tb_emp E
JOIN tb_emp_certi EC
ON E.emp_no = EC.emp_no
JOIN tb_certi C
ON EC.certi_cd = C.certi_cd
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
WHERE 1=1
    AND D.dept_cd IN (100004, 100006)
    AND EC.acqu_de >= '20180101'
ORDER BY e.emp_no
;

-- 1980���� ������� ���, �����, �μ���,
-- �ڰ�����, ������� ��ȸ

SELECT
    E.emp_no ���,
    E.emp_nm �̸�,
    D.dept_nm �μ���,
    C.certi_nm �ڰ�����,
    EC.acqu_de �������
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE 1=1
AND E.dept_cd = D.dept_cd
AND E.emp_no = EC.emp_no
AND EC.certi_cd = C.certi_cd
AND E.birth_de BETWEEN '19800101' AND '19891231'
ORDER BY E.emp_no
;
-- 1980���� ������� ���, �����, �μ���,
-- �ڰ�����, ������� ��ȸ

SELECT
    E.emp_no ���,
    E.emp_nm �̸�,
    D.dept_nm �μ���,
    C.certi_nm �ڰ�����,
    EC.acqu_de �������
FROM tb_emp E
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
JOIN tb_emp_certi EC
ON E.emp_no = EC.emp_no
JOIN tb_certi C
ON EC.certi_cd = C.certi_cd
WHERE 1=1
AND E.birth_de BETWEEN '19800101' AND '19891231'
ORDER BY E.emp_no
;

-- INNER JOIN�� �� ���̺� ����
-- ���� �����Ͱ� �ִ� ��쿡�� ���
-- � ���θ�ȸ���� �Ѱǵ� �ֹ����� ���� ���
-- INNER JOIN������ �ش� ȸ���� ��ȸ���� ����


-- SELECT [DISTINCT] { ���̸� .... } 
-- FROM  ���̺� �Ǵ� �� �̸�
-- JOIN  ���̺� �Ǵ� �� �̸�
-- ON    ���� ����
-- WHERE ��ȸ ����
-- GROUP BY  ���� �׷�ȭ
-- HAVING    �׷�ȭ ����
-- ORDER BY  ������ �� [ASC | DESC];

-- ���� ������ �Ȱɸ� ī�׽þ� ���� �������
-- ũ�ν� ����
SELECT
    *
FROM test_a, test_b
;

SELECT
    *
FROM test_a 
CROSS JOIN test_b
;


-- # NATURAL JOIN
-- 1. NATURAL JOIN�� ������ �̸��� ���� �÷��鿡 ���� �ڵ����� ���������� �����ϴ� ����Դϴ�.
-- 2. ��, �ڵ����� 2�� �̻��� ���̺��� ���� �̸��� ���� �÷��� ã�� INNER������ �����մϴ�.
-- 3. �� �� ���εǴ� ���� �̸��� �÷��� ������ Ÿ���� ���ƾ� �ϸ�, 
--    ALIAS�� ���̺���� �ڵ� ���� �÷� �տ� ǥ���ϸ� �ȵ˴ϴ�.
-- 4. SELECT * ������ ����ϸ�, ���� �÷��� ���տ��� �ѹ��� ǥ��˴ϴ�.
-- 5. ���� �÷��� n�� �̻��̸� ���� ������ n���� ó���˴ϴ�.

-- ��� ���̺�� �μ� ���̺��� ���� (���, �����, �μ��ڵ�, �μ���)

SELECT 
    A.emp_no, 
    A.emp_nm, 
    dept_cd, 
    B.dept_nm
--*
FROM tb_emp A 
NATURAL JOIN tb_dept B
;

