


-- »ç¿øÀÇ first_name, employee_id, department_id, department_name
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