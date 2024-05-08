-- ������ ���� 
-- START WITH : ������ ù �ܰ踦 ��� ������ �������� ���� ����
-- CONNECT BY PRIOR �ڽ� = �θ�  -> ������ Ž��
-- CONNECT BY �ڽ� = PRIOR �θ�  -> ������ Ž��
-- ORDER SIBLINGS BY : ���� ���������� ������ ����.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL
-- START WITH A.EMP_NO = '1000000037'
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no
ORDER SIBLINGS BY A.emp_no DESC
;

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
--START WITH A.direct_manager_emp_no IS NULL
 START WITH A.EMP_NO = '1000000037'
CONNECT BY A.emp_no =  PRIOR A.direct_manager_emp_no
--CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no
ORDER SIBLINGS BY A.emp_no DESC
;

SELECT
    emp_no,
    emp_nm,
    direct_manager_emp_no
FROM tb_emp
;


-- # �������� : SQL�ȿ� SQL�� ���Ե� ����
-- ## ������ �������� : ��ȸ ����� 1�� ����
-- �μ��ڵ尡 100004���� �μ��� ���� ��ȸ

SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT
    dept_cd 
    FROM tb_emp 
    WHERE emp_nm = '�̳���')
;

SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT
    dept_cd 
    FROM tb_emp 
    WHERE emp_no LIKE '%0023')
;

SELECT
    emp_no
    FROM tb_emp 
    WHERE emp_nm = '�̰���'
;

-- ȸ����ü 20200525 ��ձ޿� ���
-- �� ��պ��� ���� ��� ��ȸ

SELECT
    emp_no,
    E.emp_nm,
    SH.pay_amt
FROM tb_emp E
JOIN tb_sal_his SH
USING (emp_no)
WHERE 1=1
AND SH.pay_de = '20200525'
AND sh.pay_amt >= (
    SELECT
    AVG(pay_amt)
FROM tb_sal_his SH
WHERE SH.pay_de = '20200525'
)
;

SELECT
    AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;

-- # ������ ��������
-- ���������� ��ȸ �Ǽ��� 0�� �̻��� ��
-- ## ������ ������
-- 1. IN : ���������� �������� �������� ����߿� �ϳ��� ��ġ�ϸ� ��
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 �߿� �����Ƿ� false
-- 2. ANY, SOME : ���������� �������� ���������� �˻���� �� �ϳ� �̻� ��ġ�ϸ� ��
--    ex )  salary > ANY (200, 300, 400)
--            250 ->  200���� ũ�Ƿ� true
-- 3. ALL : ���������� �������� ���������� �˻������ ��� ��ġ�ϸ� ��
--    ex )  salary > ALL (200, 300, 400)
--            250 ->  200���ٴ� ũ���� 300, 400���ٴ� ũ�� �����Ƿ� false
-- 4. EXISTS : ���������� �������� ���������� ��� �� 
--				�����ϴ� ���� �ϳ��� �����ϸ� ��


SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
WHERE dept_cd IN (
    SELECT
    dept_cd 
    FROM tb_emp 
    WHERE emp_nm = '�̰���'
)
;

-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ�
-- ����� �����ȣ�� ����̸��� �ش� ����� �ѱ������ͺ��̽���������� 
-- �߱��� �ڰ��� ������ ��ȸ

SELECT
    E.emp_no,
    E.emp_nm,
    COUNT(c.CERTI_CD)
FROM tb_emp E
INNER JOIN tb_emp_certi EC
ON E.emp_no = EC.emp_no
INNER JOIN tb_certi C
ON EC.certi_cd = c.certi_cd
WHERE C.ISSUE_INSTI_NM = '�ѱ������ͺ��̽������'
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;

-- EXISTS�� : ���������� �������� ���������� ��� �� 
--           �����ϴ� ���� �ϳ��� �����ϸ� ��
-- �ּҰ� ������ �������� �ٹ��ϰ� �ִ� �μ������� ��ȸ (�μ��ڵ�, �μ���)
SELECT
    dept_cd,
    dept_nm
FROM tb_dept D
WHERE EXISTS (
    SELECT
        D.dept_cd
    FROM tb_emp E
    WHERE e.addr LIKE '%����%'
        AND d.dept_cd = e.dept_cd
)
;



-- # ���� �÷� ��������
--  : ���������� ��ȸ �÷��� 2�� �̻��� ��������

-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� 
-- ���� �������� ����� �̸� ������ϰ� �μ��ڵ带 ��ȸ

SELECT 
    A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE (A.dept_cd, A.birth_de) IN (
                        SELECT 
                            dept_cd, MIN(birth_de)
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2
                    )
ORDER BY A.emp_no
;
SELECT 
                            dept_cd, MIN(birth_de)
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2
;

-- �ζ��� �� ��������
-- FROM���� ���� ��������

-- �� ����� ����� �̸��� ��� �޿������� �˰� ����

SELECT
    E.emp_no,
    E.emp_nm,
    S.SA
FROM tb_emp E
JOIN (
    SELECT
        emp_no,
        AVG(pay_amt) SA
    FROM tb_sal_his
    GROUP BY emp_no
)S
ON E.emp_no = S.emp_no
ORDER BY E.emp_no
;

-- ��Į�� �������� (SELECT, INSERT, UPDATE���� ���� ��������)

-- ����� ���, �����, �μ���, �������, �����ڵ带 ��ȸ

SELECT
    e.emp_no,
    e.emp_nm,
    (
    SELECT
        d.dept_nm
    FROM tb_dept D
    WHERE e.dept_cd = d.dept_cd
    ) �μ���,
    e.birth_de,
    e.sex_cd
FROM tb_emp E
;