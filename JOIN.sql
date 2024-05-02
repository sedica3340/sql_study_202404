-- 사원의 사번, 이름, 부서번호, 부서명 조회
SELECT
    tb_emp.emp_no 사번,
    tb_emp.emp_nm 이름,
    tb_emp.dept_cd 부서번호,
    tb_dept.dept_nm 부서명
FROM tb_emp
INNER JOIN tb_dept
ON tb_emp.dept_cd = tb_dept.dept_cd
;
SELECT
    tb_emp.emp_no 사번,
    tb_emp.emp_nm 이름,
    tb_emp.dept_cd 부서번호,
    tb_dept.dept_nm 부서명
FROM tb_emp, tb_dept
WHERE tb_emp.dept_cd = tb_dept.dept_cd
;
-- 조인 기초 테스트 데이터
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

INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);

SELECT * FROM test_a;
SELECT * FROM test_b;

-- 조인의 원리는 곱하기연산
-- Cartesian production : product연산
-- Cross Join : 가능한 모든 경우의 수를 매칭하여 조회
SELECT
    *
FROM test_a, test_b
;

-- INNER JOIN
-- 두 테이블 간에 연관컬럼을 이용하여
-- 관계가 있는 데이터를 매칭하여 조인
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
    E.emp_no 사번,
    E.emp_nm 이름,
    E.addr 주소,
    E.tel_no 연락처,
    E.dept_cd 부서번호,
    D.dept_nm 부서명
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
;

-- 사원의 사원번호와 취득한 자격증 명을 조회
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

-- 사원의 사원번호와 취득한 자격증 명, 부서명 까지 조회
SELECT
    E.EMP_NM 이름,
    E.emp_no 사번,
    D.dept_nm 부서,
    EC.certi_cd 자격증코드,
    EC.acqu_de 취득일,
    C.certi_nm 자격증명
FROM tb_emp E,tb_emp_certi EC, tb_certi C, tb_dept D
WHERE 1=1
    AND E.emp_no = EC.emp_no 
    AND EC.certi_cd = C.certi_cd
    AND E.dept_cd = D.dept_cd
ORDER BY e.emp_no
;


-- 부서별로 총 자격증 취득 개수를 조회

SELECT
    D.dept_cd 부서코드,
    D.dept_nm 부서명,
    COUNT(EC.certi_cd) 자격증개수
FROM tb_emp E, tb_dept D, tb_emp_certi EC
WHERE E.emp_no = EC.emp_no
    AND E.dept_cd = D.dept_cd
GROUP BY D.dept_cd, D.dept_nm
ORDER BY D.dept_cd
;

-- # INNER JOIN
-- 1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법입니다.
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인됩니다.

-- 용인시에 사는 김씨 사원의 사원번호, 사원명, 주소, 부서코드, 부서명을 조회하고 싶다.
SELECT
    E.emp_no 사번,
    E.emp_nm 이름,
    SUBSTR(E.addr, 9) "주소(경기도 용인시)",
    E.dept_cd 부서코드,
    d.dept_nm 부서명
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
AND E.addr LIKE '%용인%'
AND E.emp_nm LIKE '김%'
;

SELECT
    E.emp_no 사번,
    E.emp_nm 이름,
    SUBSTR(E.addr, 9) "주소(경기도 용인시)",
    E.dept_cd 부서코드,
    d.dept_nm 부서명
FROM tb_emp E
INNER JOIN  tb_dept D
ON E.dept_cd = D.dept_cd
WHERE 1=1
AND E.addr LIKE '%용인%'
AND D.dept_nm LIKE '%개발팀%'
;

-- 사원의 사원번호와 취득한 자격증 명, 부서명 까지 조회
SELECT
    E.EMP_NM 이름,
    E.emp_no 사번,
    D.dept_nm 부서,
    EC.certi_cd 자격증코드,
    EC.acqu_de 취득일,
    C.certi_nm 자격증명
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

-- 1980년대생 사원들의 사번, 사원명, 부서명,
-- 자격증명, 취득일자 조회

SELECT
    E.emp_no 사번,
    E.emp_nm 이름,
    D.dept_nm 부서명,
    C.certi_nm 자격증명,
    EC.acqu_de 취득일자
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE 1=1
AND E.dept_cd = D.dept_cd
AND E.emp_no = EC.emp_no
AND EC.certi_cd = C.certi_cd
AND E.birth_de BETWEEN '19800101' AND '19891231'
ORDER BY E.emp_no
;
-- 1980년대생 사원들의 사번, 사원명, 부서명,
-- 자격증명, 취득일자 조회

SELECT
    E.emp_no 사번,
    E.emp_nm 이름,
    D.dept_nm 부서명,
    C.certi_nm 자격증명,
    EC.acqu_de 취득일자
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

-- INNER JOIN은 두 테이블 간에
-- 연간 데이터가 있는 경우에만 사용
-- 어떤 쇼핑몰회원이 한건도 주문하지 않은 경우
-- INNER JOIN에서는 해당 회원이 조회되지 않음


-- SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화
-- HAVING    그룹화 조건
-- ORDER BY  정렬할 열 [ASC | DESC];

-- 조인 조건을 안걸면 카테시안 곱이 만들어짐
-- 크로스 조인
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
-- 1. NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 자동으로 조인조건을 생성하는 기법입니다.
-- 2. 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER조인을 수행합니다.
-- 3. 이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며, 
--    ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안됩니다.
-- 4. SELECT * 문법을 사용하면, 공통 컬럼은 집합에서 한번만 표기됩니다.
-- 5. 공통 컬럼이 n개 이상이면 조인 조건이 n개로 처리됩니다.

-- 사원 테이블과 부서 테이블을 조인 (사번, 사원명, 부서코드, 부서명)

SELECT 
    A.emp_no, 
    A.emp_nm, 
    dept_cd, 
    B.dept_nm
--*
FROM tb_emp A 
NATURAL JOIN tb_dept B
;

