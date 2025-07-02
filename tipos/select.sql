-- Mostrar los empleados junto al país donde laboran.
SELECT 
    em.nombre AS empleado, 
    pa.nombre AS pais
FROM empleados AS em
JOIN sucursal AS su ON em.sucursalid = su.id
JOIN municipio AS mu ON su.municipioid = mu.id
JOIN departamento AS de ON mu.depid = de.id
JOIN pais AS pa ON de.pais_id = pa.id;


-- Listar el nombre de cada cliente con su municipio, departamento y país.
SELECT  
    cl.nombre AS cliente,
    mu.nombre AS municipio,
    de.nombre AS departamento,
    pa.nombre AS pais
FROM clientes AS cl
JOIN municipio AS mu ON cl.municipio_id = mu.id
JOIN departamento AS de ON mu.depid = de.id
JOIN pais AS pa ON de.pais_id = pa.id;

    

-- Obtener los nombres de los empleados cuyo puesto existe en más de una sucursal.
SELECT DISTINCT em.nombre, em.puesto
FROM empleados AS em
WHERE em.puesto IN (
    SELECT puesto
    FROM empleados
    GROUP BY puesto
    HAVING COUNT(DISTINCT sucursalid) > 1
);


-- Mostrar el total de empleados por municipio y el nombre del departamento al que pertenecen.

SELECT 
    mu.nombre AS municipio,
    de.nombre AS departamento,
    COUNT(em.empleado_id) AS total_empleados
FROM empleados AS em
JOIN sucursal AS su ON em.sucursalid = su.id
JOIN municipio AS mu ON su.municipioid = mu.id
JOIN departamento AS de ON mu.depid = de.id
GROUP BY mu.nombre, de.nombre;


-- Mostrar todos los municipios con sucursales activas (que tengan al menos un empleado).
SELECT DISTINCT mu.nombre AS municipio
FROM municipio AS mu
JOIN sucursal AS su ON mu.id = su.municipioid
JOIN empleados AS em ON su.id = em.sucursalid;

