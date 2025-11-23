-- JOINS PRACTICE

-- Lista el nombre y apellido de cada empleado junto con el nombre del departamento al que pertenece.
SELECT first_name, last_name, department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Muestra el nombre del empleado, el nombre del departamento y la ciudad donde se encuentra dicho departamento.
SELECT first_name, last_name, department_name, city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;
-- No trae a Susan Mavris por su postal_code = NULL y su state_province = NULL. 

-- Obtén todos los empleados, incluso aquellos que no tengan departamento asignado, mostrando su nombre y el nombre del departamento si existe.
SELECT first_name, last_name, department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- Muestra todos los departamentos junto con los empleados que trabajan en ellos, incluyendo los departamentos donde no figura ningún empleado.
SELECT department_name, first_name, last_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

-- Muestra todos los empleados y todos los departamentos, coincidan o no entre sí.
SELECT d.department_id, d.department_name, e.first_name, e.last_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
UNION
	(SELECT d.department_id, d.department_name, e.first_name, e.last_name
	FROM employees e
	RIGHT JOIN departments d ON e.department_id = d.department_id);
-- No me funciona el FULL JOIN así que lo tuve que hacer así.

-- Muestra el historial de trabajos indicando el empleado, el puesto y las fechas en que desempeñó cada puesto, incluyendo el título del puesto.
SELECT first_name, last_name, jh.job_id, j.job_title, start_date, end_date
FROM job_history jh
JOIN employees e ON jh.employee_id = e.employee_id
JOIN jobs j ON jh.job_id = j.job_id;

-- Muestra el listado de países junto con el nombre de la región a la que pertenecen.
SELECT country_name, region_name
FROM countries
NATURAL JOIN regions;

-- Lista todos los departamentos con la ciudad en la que se encuentran, incluso si alguno no tiene ubicación registrada.
SELECT department_id, department_name, city, state_province
FROM departments
NATURAL JOIN locations;

-- Muestra los países y las ubicaciones asociadas, incluyendo los que no tengan correspondencia entre sí.
SELECT *
FROM countries c
LEFT JOIN locations l ON c.country_id = l.country_id;

-- Muestra los empleados cuyo salario sea mayor al salario promedio del departamento donde trabajan.
SELECT *
FROM employees e
WHERE salary >
	(SELECT AVG(salary)
    FROM employees
    WHERE e.department_id = department_id);

-- SUBQUERIES PRACTICE

-- Muestra los empleados cuyo salario es mayor al salario promedio de la empresa.
SELECT *
FROM employees
WHERE salary >
		(SELECT AVG(salary)
        FROM employees);

-- Obtén los departamentos que tienen más de cinco empleados.
SELECT department_name, COUNT(employee_id) cantidad_empleados
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(employee_id) > 5;

-- Muestra los empleados cuyo salario es el máximo dentro de su puesto.
SELECT *
FROM employees e
WHERE salary =
	(SELECT MAX(salary)
    FROM employees
    WHERE job_id = e.job_id);

-- Muestra para cada empleado el salario promedio del puesto que ocupa.
SELECT e.first_name, e.last_name, e.job_id,
       (SELECT AVG(salary)
        FROM employees
        WHERE job_id = e.job_id) promedio
FROM employees e;

-- Muestra los empleados cuyo salario es mayor que el de su propio gerente.
SELECT *
FROM employees e
WHERE salary >
	(SELECT salary
    FROM employees
    WHERE employee_id = e.manager_id);


-- Obtén el empleado mejor pagado de cada departamento.
SELECT *
FROM employees e
WHERE salary =
		(SELECT MAX(salary)
        FROM employees
        WHERE department_id = e.department_id);

-- Obtén el salario promedio por región.
SELECT region_name, AVG(salary)
FROM employees e
JOIN departments d ON e.department_id = d.department_id
NATURAL JOIN locations
NATURAL JOIN countries
NATURAL JOIN regions
GROUP BY region_name;

-- Listar los empleados que no han tenido registros en job_history, incluyendo a los que no tienen departamento asignado y mostrar su región.
SELECT *
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id
LEFT JOIN countries c ON l.country_id = c.country_id
LEFT JOIN regions r ON c.region_id = r.region_id
WHERE employee_id NOT IN 
		(SELECT employee_id
        FROM job_history);