use universidad_t2;

select apellido1, apellido2, nombre from alumno order by 1,2,3 asc;
select nombre, apellido1, apellido2, telefono from alumno where telefono is null;
select * from asignatura where cuatrimestre = 1 and curso = 3 and id_grado = 7;
select * from asignatura where id_grado = 4;
select asignatura.nombre from asignatura inner join grado on asignatura.id_grado = grado.id where grado.nombre = "Grado en Ingeniería Informática (Plan 2015)";

select alumno.nombre, asignatura.nombre, anyo_inicio, anyo_fin from alumno_se_matricula_asignatura
inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
inner join alumno on alumno_se_matricula_asignatura.id_alumno = alumno.id
inner join asignatura on alumno_se_matricula_asignatura.id_asignatura = asignatura.id where anyo_inicio = 2017 and anyo_fin = 2018;

-- Devuelve el número total de alumnas que hay.
select count(*) as Cantidad_Mujeres from alumno where sexo ="M";

-- Calcula cuántos alumnos nacieron en 1999.
select count(*) as Nacidos_1999 from alumno where year(fecha_nacimiento) = 1999;

-- Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento.
-- El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
select count(*) as cantidad_profesores, departamento.nombre from profesor inner join departamento on profesor.id_departamento = departamento.id group by id_departamento;

-- Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. 
-- Estos departamentos también tienen que aparecer en el listado.
select departamento.nombre, count(profesor.id) from departamento left join profesor on departamento.id = profesor.id_departamento group by departamento.id;

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. 
-- Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. 
-- El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
select grado.nombre, count(asignatura.id_grado) from grado left join asignatura on asignatura.id_grado = grado.id group by grado.id;

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
select grado.nombre, count(asignatura.id_grado) from grado inner join asignatura on asignatura.id_grado = grado.id group by grado.id having count(asignatura.id_grado)>40;

-- Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura.
-- El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo.
-- Ordene el resultado de mayor a menor por el número total de crédidos.
select grado.nombre, sum(creditos), tipo from asignatura right join grado on asignatura.id_grado = grado.id group by grado.nombre, tipo order by sum(creditos) desc;

-- Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. 
-- El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
select anyo_inicio, count(id_curso_escolar) as cantidad_alumnos from alumno_se_matricula_asignatura inner join curso_escolar on id_curso_escolar = curso_escolar.id group by id_curso_escolar;

-- Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. 
-- El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.	
select profesor.id, profesor.nombre, profesor.apellido1, profesor.apellido2, count(asignatura.id_profesor) from asignatura right join profesor on asignatura.id_profesor = profesor.id group by 1,2,3,4 order by 5 desc;
