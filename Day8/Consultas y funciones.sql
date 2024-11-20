use autorental;

-- 1). Mostrar la lista de todos los alquileres
select * from alquileres;

-- 2). Mostrar en la tabla alquileres cual fue el valor cotizado mas costoso.
select valor_cotizado from alquileres order by 1 desc limit 1;

-- 3). Mostrar en la tabla alquileres cual fue el valor pagado mas alto.
select valor_pagado from alquileres order by 1 desc limit 1;

-- 4). Mostrar el id del vehiculo mas alquilado.
select vehiculo, count(*) from alquileres group by 1 order by 1 desc limit 1;

-- 5). Obtener el nombre del vehiculo mas alquilado.
select vehiculos.modelo, count(*) from alquileres inner join vehiculos on alquileres.Vehiculo = vehiculos.id group by 1;

-- 6). Obtener el tipo, nombre, placa del vehiculo mas alquilado.
select vehiculos.modelo,Tipo_Vehiculo, count(*) as cantidad_alquilada from alquileres inner join vehiculos on alquileres.Vehiculo = vehiculos.id group by 1,2;

-- 7). Mostrar cual fue el cliente que mas veces alquilo un vehiculo.
select clientes.nombre, clientes.Apellidos, count(*) from alquileres inner join clientes on alquileres.cliente = clientes.id group by 1,2;

-- 8). Mostrar el total de valor cotizado de toda la tabla alquileres.
select sum(valor_cotizado) from alquileres;

-- 9). Mostrar el total del valor pagado de toda la tabla alquileres.
select sum(valor_pagado) from alquileres;

-- 10). Mostrar la fecha en la cual mas alquileres de vehiculos hubieron.
select Fecha_Salida, count(Fecha_Salida) as cantidad_vehiculos_alquilados_dia from alquileres group by 1;

-- 11). Mostrar el id y la ciudad de la sucursal en la que mas vehiculos alquilaron.
select sucursal_salida,gestion_sucursales.ciudad, count(sucursal_salida) from alquileres inner join gestion_sucursales on alquileres.sucursal_salida = gestion_sucursales.id group by 1;

-- 12). Mostrar la ciudad y el empleado de la sucursal en la que mas vehiculos alquilaron.
select gestion_sucursales.ciudad, empleados.nombre , count(sucursal_salida) from alquileres inner join gestion_sucursales on alquileres.sucursal_salida = gestion_sucursales.id inner join empleados
on alquileres.Empleado = empleados.id group by 1,2;

-- 13). Mostrar el id y la ciudad de la sucursal en la que mas vehiculos entregaron.
select sucursal_llegada ,gestion_sucursales.ciudad, count(Sucursal_Llegada) from alquileres inner join gestion_sucursales on alquileres.Sucursal_Llegada = gestion_sucursales.id group by 1,2;

-- 14). Mostrar los descuentos hechos a los vehiculos alquilados.
select  alquileres.*, descuentos.tipo_vehiculo, Porcentaje_Descuento from alquileres inner join descuentos on alquileres.descuento_id = descuentos.id;

-- 15). Mostrar el nombre y apellidos de los empleados.
select nombre, apellidos from empleados;

-- 16). Mostrar el nombre y apellidos de los empleados en una sola columa.
select concat_ws("",nombre," ",apellidos) as nombre_completo from empleados;

-- 17). Listar toda la tabla de empleados.
select * from empleados;

-- 18). Mostrar el nombre y apellidos de los clientes en una sola columna.
select concat_ws("",nombre," ",apellidos) as nombre_completo from clientes;

-- 19). listar la tabla de gestion vehicular.
select * from gestion_vehicular;

-- 20). Mostrar el nombre del vehiculo respecto a su disponibilidad.
select referencia from gestion_vehicular inner join vehiculos on gestion_vehicular.id = vehiculos.id where gestion_vehicular.disponibilidad = 1;

-- 21). Mostrar el nombre de los vehiculos que no estan disponibles.
select referencia from gestion_vehicular inner join vehiculos on gestion_vehicular.id = vehiculos.id where gestion_vehicular.disponibilidad = 0;

-- 22). Mostrar la ciudad de la sucursal actual en la que se encuentran los vehiculo.
select gestion_sucursales.ciudad from gestion_vehicular inner join gestion_sucursales on gestion_vehicular.sucursal_actual_vehiculo = gestion_sucursales.id where Disponibilidad = 1;

-- 23). Mostrar la ciudad actual y la referencia del vehiculo que no se encuentra disponible.
select gestion_sucursales.ciudad, referencia from gestion_vehicular inner join gestion_sucursales on gestion_vehicular.sucursal_actual_vehiculo = gestion_sucursales.id
inner join vehiculos on gestion_vehicular.id = vehiculos.id where Disponibilidad = 0;

-- 24). Mostrar que vehiculos tienen sunroof. 
select referencia, sunroof, tipo_vehiculo from vehiculos where sunroof = 1;

-- 25). Mostrar que vehiculos no tiene sunroof.
select referencia, sunroof, tipo_vehiculo from vehiculos where sunroof = 0;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 1).Crear una funcion que muestre la diferencia entre el valor pagado y el valor cotizado.
DELIMITER //
Create function Diferencia_ValorPagado()
returns int deterministic
begin
	Declare Diferencia int;
    select sum(valor_cotizado) - sum(valor_pagado) into Diferencia from alquileres;
    return Diferencia;
end //
DELIMITER ;

select Diferencia_valorPagado()

-- 2). Crear una funcion que calcule el valor real a pagar por cliente dependiendo de cuantos dias alquilo el vehiculo, tener en cuenta que en este caso no aplicara descuento.
DELIMITER //
Create function Valor_Pagar(id_alquiler int)
returns int deterministic
begin
	declare Valor_a_pagar int;
	declare Valor_dia int;
    set valor_dia = 50;
    
	Select datediff(Fecha_Lleagada,Fecha_Salida)*Valor_dia into Valor_a_pagar from alquileres where id = id_alquiler;
    
    return Valor_a_pagar;
end //
DELIMITER ;

select Valor_Pagar(100);

Select datediff(Fecha_Lleagada,Fecha_Salida)*50 from alquileres where id = 2;

-- 3). Crear una funcion que calcule el valor a pagar por cliente aplicando el descuento de tipo de vehiculo.
DELIMITER //
Create function Valor_Pagar_Descuentos(id_alquiler int)
returns int deterministic
begin
	declare Valor_a_pagar int;
	declare Valor_dia int;
    set valor_dia = 50;
    
	Select (datediff(Fecha_Lleagada,Fecha_Salida)*valor_dia-(datediff(Fecha_Lleagada,Fecha_Salida)*Valor_dia)*porcentaje_descuento/100) into valor_a_pagar from alquileres inner join descuentos on alquileres.Descuento_id = descuentos.id where alquileres.id = id_alquiler;
    
    return Valor_a_pagar;
end //
DELIMITER ;

select Valor_Pagar_Descuentos(20);

-- 4). Crear una funcion que me calcule un posible alquiler de un vehiculo.
DELIMITER //
Create function Alquiler(Fecha_Salida varchar(30), Fecha_llegada varchar(30), TipoVehiculo varchar(30))
returns int deterministic
begin
	declare Posible_pago int;
	declare Valor_dia int;
    declare Descuento int;
	set valor_dia = 50;
    
    if TipoVehiculo = "SEDAN" then set Descuento = 60;
    elseif TipoVehiculo = "Pickup" then set Descuento = 30;
    elseif TipoVehiculo = "Compacto" then set Descuento = 20;
    end if;
    
    select (datediff(Fecha_llegada,Fecha_salida)*valor_dia-(datediff(Fecha_llegada,Fecha_salida)*Valor_dia)*Descuento/100) into Posible_pago;
    
    return Posible_pago;
end //
DELIMITER ;

select Alquiler ("2024-11-01", "2025-11-30", "Pickup");

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1). Inserte nuevos descuentos.
Delimiter //
Create procedure InsertDescuento( in Porcentaje int, in Inicio varchar(30), in Final varchar(30), in tipo varchar (30))
begin
 insert into descuentos(Porcentaje_Descuento, Inicio_Descuento, Final_Descuento, Tipo_Vehiculo) values (Porcentaje, Inicio, Final, tipo);
end
// Delimiter ;

call InsertDescuento(10,"2024-1-01","2024-6-01","Pesado") 

-- 2). Despedir un empleado.
Delimiter //
Create procedure Despedir(in id_in int)
begin
	delete from empleados where id=id_in;
end
// Delimiter ;

call Despedir (5)

-- 3). Mostrar la cantidad de vehiculos de color rojo.
Delimiter //
create procedure VehiculosR(out Cantidad int)
begin
	select count(color) into Cantidad from vehiculos where color = "Rojo";
end //
Delimiter ;

call VehiculosR(@vehiculos);
select @vehiculos as Vehiculos_Rojos;

-- 4). Mostrar la cantidad de vehiculos de un color que el cliente elija.
Delimiter //
create procedure ColorEleccion(in colorE varchar(30),out Cantidad int, out Nombre varchar(30))
begin
	select count(color) into Cantidad from vehiculos where color = ColorE;
    select Referencia into Nombre from vehiculos where color = ColorE;
end //
Delimiter ;

call ColorEleccion("Azul",@Cantidad_color, @Nombre);
select @Cantidad_color as Cantidad, @Nombre;

-- 5). Cerrar una sucursal.
Delimiter //
Create procedure CerrarSucursal(in id_in int)
begin
	delete from gestion_sucursales where id=id_in;
end
// Delimiter ;

call CerrarSucursal(5);

-- 6). Cambiar la disponibilidad de un vehiculo a eleccion.
Delimiter //
Create procedure Disponibilidad(in id_in int, in Disponibilidad_in tinyint)
begin
	declare Dispo tinyint;

	select Disponibilidad into Dispo from gestion_vehicular where id = id_in;
    if Dispo = Disponibilidad_in then
    signal	sqlstate '45000' set message_text = "El estado que intentas cambiar es el mismo que estas entregando.";
    end if;
    
    update gestion_vehicular set disponibilidad = Disponibilidad_in where id = id_in;
    
    commit;	
end
// Delimiter ;

call Disponibilidad(1,0);

-- 7). Cambiar el nombre de un cliente.
Delimiter //
create procedure CambiarNombre (in NuevoNombre varchar(50),in Id_in int)
begin
	Declare Name_N varchar(50);
    
    select Nombre into Name_N from clientes where id = id_in;
    if Name_N = NuevoNombre then
    signal sqlstate '45000' set message_text = "El nombre que ingresaste es el mismo.";
    end if;
    
    update clientes set Nombre = NuevoNombre where id = id_in;
end
// Delimiter ;

call CambiarNombre("Ramon",1)

-- 8). Editar el porcentaje de un descuento.
Delimiter //
Create procedure EditarDescuento(in Id_in int, in Nuevo_descuento int)
begin
	update descuentos set Porcentaje_Descuento = Nuevo_descuento where id = Id_in;
end
// Delimiter ;

call EditarDescuento(1,50);

-- 9). Crear un procedimiento que me calcule un posible alquiler de un vehiculo.
Delimiter //
Create procedure PosibleAlquiler(in Fecha_Salida varchar(30), in Fecha_llegada varchar(30), in TipoVehiculo varchar(30), out Posible_pago int)
begin
	Declare Descuento1 int;
    Declare Descuento2 int;
    Declare Descuento3 int;
    Declare valor_dia int;
    Declare Descuento int;
    
    set valor_dia = 50;
    set Descuento1 = (select distinct porcentaje_Descuento from descuentos where Tipo_Vehiculo = "SEDAN");
    set Descuento2 = (select distinct porcentaje_Descuento from descuentos where Tipo_Vehiculo = "Pickup");
    set Descuento3 = (select distinct porcentaje_Descuento from descuentos where Tipo_Vehiculo = "Compacto");
    
    if TipoVehiculo = "SEDAN" then set Descuento = Descuento1;
    elseif TipoVehiculo = "Pickup" then set Descuento = Descuento2;
    elseif TipoVehiculo = "Compacto" then set Descuento = Descuento3;
    end if;

	select (datediff(Fecha_llegada,Fecha_salida)*valor_dia-(datediff(Fecha_llegada,Fecha_salida)*Valor_dia)*Descuento/100) into Posible_pago;
    
end
// Delimiter ;

call PosibleAlquiler ("2024-11-01", "2025-11-30", "Pickup", @Posible);
select @Posible as Valor_Pagar;

-- 10). Valor adicional a pagar si tiene dias de retraso.
Delimiter //
Create procedure ValorAdicional (in Dias_Retraso int, out Adicional int)
begin
	Declare Valor int;
    Declare Valor_dia int;
    set Valor_dia = 50;
    
    set Valor = (select (Valor_dia+Valor_dia*8/100));
    
    select ((@Posible + Dias_Retraso) + Valor) into Adicional;
    
end
// Delimiter :

call ValorAdicional(0, @Resultado);

select @Resultado as Valor_Con_Retraso;
