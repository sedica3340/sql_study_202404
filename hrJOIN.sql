


-- ����� first_name, employee_id, department_id, department_name
SELECT
    e.employee_id,
    e.first_name,
    department_id,
    d.department_name
FROM employees E
NATURAL JOIN departments D
ORDER BY e.employee_id
;

SELECT
    e.employee_id,
    e.first_name,
    e.department_id,
    d.department_name
FROM employees E
INNER JOIN departments D
ON e.department_id = d.department_id
  AND e.manager_id = d.manager_id
ORDER BY e.employee_id
;

SELECT
    e.employee_id,
    e.first_name,
    department_id,
    d.department_name
FROM employees E
INNER JOIN departments D
USING(department_id)
ORDER BY e.employee_id
;

SELECT
    e.employee_id,
    e.first_name,
    department_id,
    d.department_name
FROM employees E
INNER JOIN departments D
USING(department_id, manager_id)
ORDER BY e.employee_id
;

-- 1. employees���̺�� departments���̺��� inner join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT
    e.employee_id,
    e.last_name,
    d.department_id,
    d.department_name
FROM employees E
INNER JOIN departments D
ON e.department_id = d.department_id
;

-- 2. employees���̺�� departments���̺��� natural join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    department_id,
    d.department_name
FROM employees E
NATURAL JOIN departments D
;
-- 3. employees���̺�� departments���̺��� using���� ����Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    department_id,
    d.department_name
FROM employees E
INNER JOIN departments D
USING (department_id)
;

-- 4. employees���̺�� departments���̺�� locations ���̺��� 
--    join�Ͽ� employee_id, first_name, department_name, city�� ��ȸ�ϼ���
SELECT
    e.employee_id,
    e.first_name,
    d.department_name,
    l.city
FROM employees E
JOIN departments D
ON e.department_id = d.department_id
JOIN locations L
ON l.location_id = d.location_id
;

-- 5. employees ���̺�� jobs ���̺��� INNER JOIN�Ͽ� 
-- ����� first_name, last_name, job_title�� ��ȸ�ϼ���.
SELECT
    e.first_name,
    e.last_name,
    j.job_title
FROM employees E
INNER JOIN jobs J
ON e.job_id = j.job_id
;
-- 6. employees ���̺�� departments ���̺��� INNER JOIN�Ͽ� 
-- �μ���� �� �μ��� �ִ� �޿����� ��ȸ�ϼ���.
SELECT
    d.department_name,
    MAX(e.salary),
    MIN(e.salary)
    
FROM employees E
INNER JOIN  departments D
ON e.department_id = d.department_id
GROUP BY d.department_name
;
-- 7. employees ���̺�� jobs ���̺��� INNER JOIN�Ͽ� 
--    ������ ��� �޿��� ���� Ÿ��Ʋ�� ��ȸ�ϼ���.
SELECT
    j.job_title,
    AVG(e.salary)
FROM employees E
INNER JOIN jobs J
ON e.job_id = j.job_id
GROUP BY j.job_title
;