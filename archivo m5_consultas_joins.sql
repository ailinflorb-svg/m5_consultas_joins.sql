USE Ventas_Tech_DB;

SELECT 
v.fecha_venta,
c.id_cliente,
c.nombre AS nombre_cliente,
p.id_producto,
p.nombre_producto AS producto,
p.id_categoria,
v.cantidad,
v.precio_unitario,
v.cantidad * v.precio_unitario AS total_venta

FROM ventas AS v 
INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente 
INNER JOIN productos AS p ON v.id_producto = p.id_producto

ORDER BY v.fecha_venta;

SELECT
c.id_cliente,
c.nombre,
c.email,
c.fecha_registro

FROM clientes AS c 
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

SELECT
p.id_producto,
p.nombre_producto AS producto,
p.id_categoria,
p.precio

FROM productos AS p 
LEFT JOIN  ventas AS v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

USE Ventas_Tech_DB;

SELECT
canal,
SUM(total) AS total_canal
FROM (
SELECT
fecha_venta,
cantidad * precio_unitario AS total,
'Venta de 1 unidad' AS canal
FROM ventas
WHERE cantidad = 1

UNION ALL

SELECT
fecha_venta,
cantidad * precio_unitario AS total,
'Venta de varias unidades' AS canal
FROM ventas
WHERE cantidad >= 2
) AS consolidado
GROUP BY canal;
