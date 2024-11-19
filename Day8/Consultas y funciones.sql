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

select Alquiler ("2024-11-01", "2024-11-08", "SEDAN")