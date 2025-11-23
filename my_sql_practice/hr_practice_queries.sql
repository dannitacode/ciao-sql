-- Ejercicio básicos.

-- Listar todos los empleados con employee_id, first_name y last_name.
SELECT e.employee_id, e.first_name, e.last_name 
FROM employees e;

-- Mostrar el nombre y salario de todos los empleados ordenados por salario de menor a mayor.
SELECT CONCAT(first_name, ' ', last_name) AS nombre, salary 
FROM employees e
ORDER BY salary ASC


-- Listar todos los trabajos con job_id, job_title, min_salary y max_salary.
SELECT * FROM jobs;


-- Listar todos los departamentos con department_id y department_name.
SELECT d.department_id, d.department_name
FROM  departments d;

-- Mostrar los empleados cuyo salario sea mayor a 5000.
SELECT * 
FROM employees 
WHERE salary > 5000

-- Listar todos los empleados que pertenezcan al department_id = 90.
SELECT * 
FROM employees 
WHERE department_id = 90

-- Listar todos los empleados ordenados por last_name ascendente.
SELECT * 
FROM employees 
ORDER BY last_name ASC;

-- Mostrar los empleados que tengan comisión (commission_pct).
SELECT * 
FROM employees
WHERE commission_pct IS NOT NULL;

-- Listar todos los países con country_id y country_name.
SELECT c.country_id, c.country_name
FROM countries c;

-- Mostrar los empleados cuyo first_name comienza con la letra ‘A’.
SELECT *
FROM employees e
WHERE e.first_name LIKE 'a%';

-- Ejercicios intermedios.

-- Mostrar los empleados con el nombre de su departamento.
SELECT CONCAT(first_name, ' ', last_name) AS name, job_id, e.department_id, department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Listar los empleados con el título de su trabajo.
SELECT CONCAT(first_name, ' ', last_name) AS name, e.job_id, job_title
FROM employees e
NATURAL JOIN jobs;

-- Mostrar los empleados con la ciudad donde se encuentra su departamento.
SELECT CONCAT(first_name, ' ', last_name) AS name, e.department_id, d.department_name, city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
NATURAL JOIN locations;

-- Obtener el salario promedio de todos los empleados.
SELECT AVG(salary)
FROM employees;

-- Mostrar el salario máximo y mínimo por cada job_id.
SELECT j.job_id, j.max_salary, j.min_salary 
FROM jobs j;

-- Contar cuántos empleados hay en cada departamento.
SELECT department_name, COUNT(employee_id) AS cantidad_empleados
FROM departments d
JOIN employees e ON d.department_id=e.department_id
GROUP BY d.department_name;

-- Listar los empleados que trabajan en un país específico (elegí uno).
SELECT * 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
NATURAL JOIN locations
NATURAL JOIN countries
WHERE country_name = 'Germany';

-- Mostrar el historial laboral de cada empleado desde job_history.
SELECT CONCAT(first_name, ' ', last_name) AS name, e.job_id, j.start_date, j.end_date
FROM employees e
JOIN job_history j ON e.job_id = j.job_id;

-- Listar los departamentos que no tienen empleados.
SELECT * 
FROM departments d
LEFT JOIN employees e ON d.department_id=e.department_id
WHERE e.department_id IS NULL;

-- Listar los empleados cuyo salario es mayor al salario promedio general.
SELECT *
FROM employees
WHERE salary >=
		(SELECT AVG(salary)
        FROM employees);

-- Ejercicios Avanzados

-- Obtener el empleado con el salario más alto.
SELECT CONCAT(first_name, ' ', last_name) AS name, MAX(salary)
FROM employees;

-- Obtener los 3 empleados con mayor salario.
SELECT employee_id, last_name, MAX(salary)
FROM employees
GROUP BY employee_id
LIMIT 3;

-- Listar los empleados cuyo salario sea mayor al salario promedio de su departamento.
SELECT *
FROM employees e
WHERE salary >
	(SELECT AVG(salary)
     FROM employees
     WHERE department_id = e.department_id);

-- Listar cada departamento junto al empleado mejor pagado de ese departamento.
SELECT e.first_name, e.last_name, e.department_id
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);

/*Listado apellido nombre, salario y nombre del departamento donde trabajan los empleados 
donde tienen registro en job history*/
SELECT DISTINCT last_name, first_name, salary, department_name
FROM employees e
JOIN job_history j ON e.employee_id=j.employee_id
JOIN departments d ON e.department_id=d.department_id

-- Mostrar nombre del empleado, nombre del departamento y ciudad donde trabaja.
SELECT CONCAT(first_name, ' ', last_name) AS name, department_name, city
FROM employees e
JOIN departments d ON e.department_id=d.department_id
JOIN locations l ON d.location_id=l.location_id

-- Mostrar cantidad de empleados por departamento (incluyendo los que no tienen empleados).
SELECT department_name, COUNT(employee_id)
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY department_name

-- Listar el salario máximo, mínimo y promedio por cada “job” (puesto).
SELECT j.job_id, MIN(salary), MAX(salary), AVG(salary)
FROM employees
NATURAL JOIN jobs j
GROUP BY j.job_id

-- Mostrar los departamentos y el nombre de su manager.
SELECT *
FROM departments d
JOIN employees e ON d.manager_id=e.employee_id

-- Obtener los países donde hay empleados trabajando.
SELECT DISTINCT country_name
FROM countries
NATURAL JOIN locations l
JOIN departments d ON l.location_id=d.location_id
JOIN employees e ON d.department_id=e.department_id
WHERE e.employee_id IS NOT NULL;

-- Listar apellido, nombre y nombre del dpto. donde trabajan los empleados que no han ingresado a job_history. 

SELECT last_name, first_name, department_name 
FROM employees e 
JOIN departments d on e.department_id= d.department_id
WHERE e.employee_id NOT IN  ( 
    SELECT employee_id 
    FROM job_history);
