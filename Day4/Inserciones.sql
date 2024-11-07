Use T2;

INSERT INTO departamento (codigo, nombre, presupuesto) VALUES
(1, 'Desarrollo', 120000),
(2, 'Sistemas', 150000),
(3, 'Recursos Humanos', 280000);

INSERT INTO empleado (codigo, nif, nombre, apellido1, apellido2, codigo_departamento) VALUES
(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1),
(2, 'Y557632D', 'Adela', 'Salas', 'Díaz', 2),
(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);

select * from empleado,departamento;
select * from empleado join departamento on empleado.codigo_departamento = departamento.codigo;
select * from empleado inner join departamento using (codigo);

-- LEFT JOIN: Devuelve todas las filas de la tabla izquierda y las filas coincide de la tabla derecha. Las filas
-- no tienen coincidencias en la derecha tendran NULL en las columnas de la tabla derecha.

select * from empleado left join departamento on empleado.codigo_departamento = departamento.codigo;

-- Right join: devuelve todas las filas de la tabla derecha y las filas que coinciden de la tabla izquierda. Las filas
-- no tienen coincidencias en la izquierda tendran NULL en las columnas de la tabla derecha.