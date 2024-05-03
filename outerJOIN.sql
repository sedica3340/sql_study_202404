-- OUTER JOIN 실습환경 세팅
INSERT INTO tb_dept VALUES ('100014', '4차산업혁명팀', '999999');
INSERT INTO tb_dept VALUES ('100015', '포스트코로나팀', '999999');
COMMIT;

SELECT * FROM tb_dept;

ALTER TABLE tb_emp DROP CONSTRAINT fk_tb_emp01;

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000041', '이순신', '19811201', '1', '경기도 용인시 수지구 죽전1동 435', '010-5656-7878',
        NULL, '006', '003', '114-554-223433', '000000', 'N');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000042', '정약용', '19820402', '1', '경기도 고양시 덕양구 화정동 231', '010-4054-6547',
        NULL, '004', '001', '110-223-553453', '000000', 'Y');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000043', '박지원', '19850611', '1', '경기도 수원시 팔달구 매탄동 553', '010-1254-1116',
        NULL, '004', '001', '100-233-664234', '000000', 'N');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000044', '장보고', '19870102', '1', '경기도 성남시 분당구 정자동 776', '010-1215-8784',
        NULL, '004', '002', '180-345-556634', '000000', 'Y');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000045', '김종서', '19880824', '1', '경기도 고양시 일산서구 백석동 474', '010-3687-1245',
        NULL, '004', '002', '325-344-45345', '000000', 'Y');
        
COMMIT;
    
 
SELECT * FROM tb_emp ORDER BY emp_no DESC;

SELECT emp_no, emp_nm, dept_cd 
FROM tb_emp ORDER BY emp_no DESC;

SELECT * FROM tb_dept;
SELECT
    E.emp_nm,
    D.dept_cd
FROM tb_emp E
INNER JOIN tb_dept D
ON e.dept_cd = D.dept_cd
;

-- # OUTER JOIN
-- 1. 조인 조건을 만족하지 않는 행들도 조회할 때 사용하는 조인기법입니다.
-- 2. OUTER조인 연산자 기호는 (+)기호입니다.
-- 3. INNER조인은 조인 조건을 만족하지 않으면 해당 행을 조회하지 않습니다
--   그러나 OUTER JOIN은 방향(LEFT, RIGHT, FULL)에 맞게 조건에 매칭되지 
--   않는 행들도 모두 NULL로 처리해서 조회합니다.

-- # LEFT OUTER JOIN
-- 조인되는 왼쪽 테이블은 모두 조회하고, 오른쪽 테이블은 조인조건에 매칭된 것만 조회합니다.

-- 나는 사원정보는 일단 다 보고 싶은데 혹시 부서테이블에서 부서코드가 매칭되면
-- 보너스로 부서이름도 찍어줘라

SELECT
    e.emp_nm,
    d.dept_nm
FROM tb_emp E
LEFT OUTER JOIN tb_dept D
USING (dept_cd)
;

SELECT
    *
FROM tb_emp E
LEFT OUTER JOIN tb_dept D
USING (dept_cd)
;

-- 오라클 조인
-- LEFT면 조건 오른쪽에 (+) 를 붙이고
-- RIGHT면 조건 왼쪽에 (+) 를 붙인다
-- FULL조인은 지원되지 않음
--(+)가 붙으면 표준 조인에서 ON절에 위치하는 조건
SELECT
    e.emp_nm,
    d.dept_nm
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd (+)
;

-- # RIGHT OUTER JOIN
-- 조인되는 오른쪽 테이블은 모두 조회하고, 왼쪽 테이블은 조건에 매칭된것만 조회

-- 나는 모든 부서정보를 조회하고 싶은데 혹시 부서코드가 일치하는 사원이 있으면 함께 조회해줘

SELECT
    E.emp_nm,
    D.dept_nm
FROM tb_emp E
RIGHT OUTER JOIN tb_dept D
USING (dept_cd)
;
SELECT
    e.emp_nm,
    d.dept_nm
FROM tb_emp E, tb_dept D
WHERE E.dept_cd (+) = D.dept_cd
;
SELECT
    E.emp_nm,
    D.dept_nm
FROM tb_emp E
FULL OUTER JOIN tb_dept D
USING (dept_cd)
;

-- 사원이 46명 부서가 16개
-- 부서를 가진 사원은 41명
-- 사원이 한명이상인 부서 14개
-- INNER JOIN 결과 41건
-- 사원정보 기준 
-- LEFT JOIN 결과는 46건: INNER 41 + 부서가 없는 사원 5 ;
-- RIGHT JOIN 결과는 43건: INNER 41 + 사원이 없는 부서 2 ;
-- FULL JOIN 결과는 48건: INNER 41 + 부없사 5 + 사없부 2 ;

-- # SELF JOIN
-- 1. 하나의 테이블에서 자기 자신의 테이블끼리 조인하는 기법입니다.
-- 2. 자기 자신 테이블에서 pk와 fk로 동등조인합니다.

SELECT
    e1.emp_no 사번,
    e1.emp_nm 이름,
    e1.direct_manager_emp_no "직속 상사 사번",
    e2.emp_nm "직속 상사의 이름"
FROM tb_emp E1
LEFT OUTER JOIN tb_emp E2
ON e1.direct_manager_emp_no = e2.emp_no
;
