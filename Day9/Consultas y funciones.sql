use Pruebas;

-- 1. Listar todos los paises:
select * from countries;

-- 2. Obtener todos los departamentos.
select * from departments;

-- 3. Mostrar el titulo y salario minimo de todos los trabajos.
select job_title, min_salary from jobs;

-- 4. Lista de dependientes junto
-- con los datos de los empleados a los que esten asocidados.

select * from employees inner join dependents on employees.employee_id = dependents.employee_id;

-- 5. Salario promedio por departamento y ciudad.
select avg(salary) as Salario_promedio, department_name, city from employees inner join departments on employees.department_id = departments.department_id inner join locations on departments.location_id = locations.location_id group by 2,3;

-- 6. Lista de empleo con su trabajo, departamento y ubicacion. 
select employees.first_name,employees.last_name,jobs.job_title, department_name, city from jobs inner join employees on jobs.job_id = employees.job_id inner join departments on employees.department_id = departments.department_id
inner join locations on departments.location_id = locations.location_id;

-- Funciones

-- 1. Obtenga el nombre de un pais por su ID.

Delimiter //
Create function NombrePais(Pais_id char(2))
returns varchar(50) deterministic
begin
	Declare Country varchar(50);
	
	select country_name into Country from countries where country_id = pais_id;
    return Country;
end //
Delimiter ;

select NombrePais("US");

-- Procedimiento
-- 1. Insertar una nueva region.

insert into regions(region_name) values ("Africa");

Delimiter //
Create procedure InsertRegion( in nombre_regions varchar(50))
begin
 insert into regions(region_name) values (nombre_regions);
end

// Delimiter ;

call InsertRegion("Africa");