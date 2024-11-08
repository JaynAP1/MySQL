use universidad_t2;

-- Devuelve todos los datos del alumno más joven.
select * from alumno order by fecha_nacimiento desc limit 1;

-- Devuelve un listado con los profesores que no están asociados a un departamento.
select * from profesor where id_departamento is null;

-- Devuelve un listado con los departamentos que no tienen profesores asociados.
select departamento.* from departamento left join profesor on departamento.id = profesor.id_departamento group by 1,2 having count(profesor.id) = 0;

-- Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.
select profesor.*, count(asignatura.id) from asignatura right join profesor on asignatura.id_profesor = profesor.id group by 1,2 having count(asignatura.id) = 0;

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.
select * from asignatura where id_profesor is null;

-- Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
select  departamento.nombre, asignatura.nombre from departamento left join profesor on departamento.id = profesor.id_departamento
inner join asignatura on profesor.id = asignatura.id_profesor left join alumno_se_matricula_asignatura asma on asignatura.id = asma.id_asignatura
left join curso_escolar on asma.id_curso_escolar != curso_escolar.id;

-- Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
select distinct departamento.* from departamento inner join profesor on departamento.id = profesor.id_departamento inner join asignatura on profesor.id = asignatura.id_profesor inner join grado on asignatura.id_grado = grado.id where grado.nombre = "Grado en Ingeniería Informática (Plan 2015)" ;

-- Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados.
-- El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. 
-- El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.Devuelve un listado con los profesores que no están asociados a un departamento.
select departamento.nombre, profesor.nombre,profesor.apellido1, profesor.apellido2 from profesor left join departamento on profesor.id_departamento = departamento.id;

-- Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar.
-- El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.
select  departamento.nombre, asignatura.nombre from departamento left join profesor on departamento.id = profesor.id_departamento
inner join asignatura on profesor.id = asignatura.id_profesor left join alumno_se_matricula_asignatura asma on asignatura.id = asma.id_asignatura
left join curso_escolar on asma.id_curso_escolar != curso_escolar.id;

select distinct asignatura.nombre, departamento.nombre from asignatura inner join alumno_se_matricula_asignatura asma on asignatura.id = asma.id_asignatura
inner join curso_escolar on asma.id_curso_escolar = curso_escolar.id left join profesor on asignatura.id_profesor = profesor.id
left join departamento on profesor.id_departamento = departamento.id;