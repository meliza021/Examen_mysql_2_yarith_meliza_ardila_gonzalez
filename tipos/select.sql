-- Mostrar los empleados junto al país donde laboran.
SELECT 
    em.nombre AS empleados 
    pa.nombre
FROM empleados  AS em
JOIN departamento AS de ON  em.empleado_id = de.id
JOIN pais AS pa ON de.id ON pa.idpais_id


-- Listar el nombre de cada cliente con su municipio, departamento y país.
SELECT  
    cl.nombre AS nombre
    mu.nombre
FROM clientes AS cl
JOIN municipio AS mu ON  mu.nombre = cl.municipio_id
    

-- Obtener los nombres de los empleados cuyo puesto existe en más de una sucursal.
SELECT em.nombre,
        em.puesto
FROM empleados AS em 
JOIN sucursal AS su ON em.sucursalid = su.id

-- Mostrar el total de empleados por municipio y el nombre del departamento al que pertenecen.

SELECT mu.nombre
        de.nombre
        em.nombre
FROM municipio AS mu 
JOIN departamento AS de ON mu.id = de.id
JOIN empleados AS em ON mu.id = de.id 
WHERE empleado_id = mu.nombre 

-- Mostrar todos los municipios con sucursales activas (que tengan al menos un empleado).
SELECT 
    mu.nombre
    pe.estado
FROM municipio AS mu
JOIN pedidos AS pe ON mu.id = pe.cliente_id
