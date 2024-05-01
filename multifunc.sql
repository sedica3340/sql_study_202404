SELECT * FROM tb_sal_his;

-- 집계 함수 (다중행 함수)
-- 여러 행을 묶어서 한번에 함수를 적용

SELECT
    COUNT(*) 지급횟수,
    SUM(pay_amt) 지급총액,
    AVG(pay_amt) 평균지급액,
    MAX(pay_amt) 최대지급액,
    MIN(pay_amt) 최소지급액
FROM tb_sal_his
;

SELECT
    SUBSTR(emp_nm, 1, 1)
FROM tb_emp;

SELECT
    *
FROM tb_emp;

SELECT
    COUNT(*)
FROM tb_emp;

SELECT
    emp_nm
FROM tb_emp;

SELECT
    COUNT(emp_nm)
FROM tb_emp;

SELECT
    emp_nm
FROM tb_emp
WHERE emp_nm Like '김%'
;
SELECT
    COUNT(emp_nm)
FROM tb_emp
WHERE emp_nm Like '김%'
;

SELECT
    direct_manager_emp_no
FROM tb_emp
;
SELECT
    COUNT(direct_manager_emp_no)
FROM tb_emp
;

SELECT 
    COUNT(emp_no) 총사원수,
    MIN(birth_de) 연장자생일,
    MAX(birth_de) 연소자생일
FROM tb_emp
;

-- 부서별 사원수, 연장자생일, 연소자생일
SELECT 
    emp_no,
    emp_nm,
    birth_de,
    dept_cd
FROM tb_emp
ORDER BY dept_cd
;
SELECT 
    dept_cd 부서코드,
    COUNT(emp_no) 부서별사원수,
    MIN(birth_de) 연장자생일,
    NULLIF(MAX(birth_de), MIN(birth_de)) 연소자생일
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd
;

SELECT
    emp_no,
    SUM(pay_amt)
FROM tb_sal_his
GROUP BY emp_no
ORDER BY SUM(pay_amt)
;

SELECT
    emp_no,
    MAX(pay_amt) 최대급여,
    MIN(pay_amt) 최소급여,
    ROUND(AVG(pay_amt), 2) 평균급여,
    SUM(pay_amt) 총급여,
    COUNT(pay_de) 급여횟수
FROM tb_Sal_his
GROUP BY emp_no
ORDER BY emp_no
;

SELECT
    emp_no,
    emp_nm,
    dept_cd
FROM tb_emp
;

SELECT
    sex_cd, COUNT(*)
FROM tb_emp
GROUP BY sex_cd
;
SELECT
    dept_cd 부서코드,
    sex_cd 성별코드,
    COUNT(*) 인원수
FROM tb_emp
GROUP BY sex_cd, dept_cd
ORDER BY dept_cd
;

-- 사원별로 2019년에 급여 평균액, 최소지급액,
SELECT 
    emp_no, 
    TO_CHAR(SUM(pay_amt), 'L999,999,999') "사원별 총급여액",
    TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "사원별 평균급여액",
    TO_CHAR(MAX(pay_amt), 'L999,999,999') "사원별 최고급여액",
    COUNT(pay_de) "급여 수령횟수"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;

SELECT 
    emp_no, 
    TO_CHAR(SUM(pay_amt), 'L999,999,999') "사원별 총급여액",
    TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "사원별 평균급여액",
    TO_CHAR(MAX(pay_amt), 'L999,999,999') "사원별 최고급여액",
    COUNT(pay_de) "급여 수령횟수"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4000000
ORDER BY emp_no
;
-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일, 부서별 총 사원 수를 조회
-- 그런데 부서별 사원이 1명인 부서의 정보는 조회하고 싶지 않음.
SELECT
    dept_cd,
    MAX(birth_de),
    MIN(birth_de),
    COUNT(*)
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(*) > 1
ORDER BY dept_cd
;

-- ORDER BY : 정렬
-- ASC : 오름차 정렬 (기본값), DESC : 내림차 정렬
-- 항상 SELECT절의 맨 마지막에 위치

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no
;

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm ASC
;

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd, emp_nm DESC
;


SELECT 
    emp_no AS 사번
    , emp_nm AS 이름
    , addr AS 주소
FROM tb_emp
ORDER BY 이름 DESC
;

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, 1 DESC
;


SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, emp_no DESC
;

SELECT emp_no AS 사번, emp_nm AS 이름, addr AS 주소
FROM tb_emp
ORDER BY 이름, 1 DESC
;

SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

SELECT 
	EMP_NM ,
	DIRECT_MANAGER_EMP_NO 
FROM TB_EMP
ORDER BY DIRECT_MANAGER_EMP_NO DESC
;


-- 사원별로 2019년 월평균 수령액이 450만원 이상인 사원의 사원번호와 2019년 연봉 조회
SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY SUM(pay_amt) DESC
;
