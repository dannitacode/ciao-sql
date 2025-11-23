/*
1. Por motivos presupuestarios, el departamento de recursos
humanos necesita un informe que muestre los apellidos, la
descripción de la tarea que realizan, la ciudad en la que trabajan
y el salario de los empleados que ganan más de 12.000 dólares.
*/
SELECT
    last_name,
    job_title,
    city,
    salary
FROM
    employees
NATURAL JOIN jobs JOIN departments ON employees.department_id = departments.department_id
NATURAL JOIN locations WHERE salary > 12000

/*
2. Cree un informe que muestre el nombre y apellido, sueldo anual
incluida comisión si la cobran y departamento de los empleados
que desempeñan sus tareas en Europa.
*/
SELECT
    first_name nombre,
    last_name apellido,
    salary * 12 AS sueldo_anual,
    commission_pct comision,
    department_name departamento,
    region_name continente
FROM
    employees
JOIN departments ON employees.department_id = departments.department_id
NATURAL JOIN locations NATURAL JOIN countries NATURAL JOIN regions WHERE commission_pct IS NOT NULL AND region_name = 'Europe'

/*
3. Cree un informe para mostrar el nombre y apellido, el puesto y la
fecha de inicio para los empleados con los apellidos que
contienen las letras <<a>> y <<b>>. Ordene la consulta por
orden ascendente por fecha de inicio. 
*/
SELECT
    first_name nombre,
    last_name apellido,
    hire_date fecha_de_inicio,
    job_title
FROM
    employees e
JOIN jobs j ON
    (e.job_id = j.job_id)
WHERE
    last_name LIKE '%a%' AND last_name LIKE '%b%'
ORDER BY
    hire_date ASC

/*
4. Encuentre el apellido, correo electrónico, teléfono y el salario de
los empleados que ganan entre 5.000 y 12.000 dólares, están en
el departamento Ventas y han sido contratados en 1994. Etiquete
las columnas como Empleado, E-mail, Teléfono y Sueldo,
respectivamente.
*/
SELECT
    last_name "Empleado",
    email "E-mail",
    phone_number "Teléfono",
    salary "Sueldo"
FROM
    employees
JOIN departments ON employees.department_id = departments.department_id
WHERE
    departments.department_name = "Sales" AND salary BETWEEN 5000 AND 12000 AND YEAR(hire_date) = 1994

/*
5. Cree un informe que muestre el apellido, el salario y la comisión
de todos los empleados que ganen comisiones. Ordene los datos
en orden descendente por salario y comisiones.
*/
SELECT
    last_name apellido,
    salary salario,
    commission_pct comision
FROM
    employees
WHERE
    commission_pct IS NOT NULL
ORDER BY
    salary,
    commission_pct
DESC

/*
6. Muestre el apellido, el puesto de trabajo y el salario de todos los
empleados que sean representante de ventas o administrativo y
cuyo salario sea distinto de 2.500, 3.500 ó 7.000 dólares.
*/
SELECT
    last_name,
    department_name,
    salary
FROM
    employees e
JOIN departments d ON
    e.department_id = d.department_id
WHERE
    (
        d.department_name = "Sales" OR d.department_name = "Administration"
    ) AND(salary NOT IN(2500, 3500, 7000));

/*
7. Mostrar el apellido, el salario y la comisión de todos los
empleados cuyo importe de comisión sea de más del 20% de los
ingresos anuales de CEO de la empresa.
*/
SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    (salary * commission_pct) > (
    SELECT
        (salary * 0.20) * 12
    FROM
        employees
    WHERE
        job_id = 'AD_PRES'
)

SELECT last_name,first_name , department_name 
FROM employees e 
JOIN departments d on e.department_id= d.department_id
WHERE e.employee_id NOT IN  ( 
    SELECT employee_id 
    FROM job_history);

    SELECT e.last_name,
       e.first_name,
       d.department_name
FROM employees e
JOIN departments d 
       ON e.department_id = d.department_id
LEFT JOIN job_history jh 
       ON e.employee_id = jh.employee_id
WHERE jh.employee_id IS NULL;

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