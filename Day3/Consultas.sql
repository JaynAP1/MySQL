use jardineria;

-- Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select codigo_oficina, ciudad from oficina;

-- Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select telefono, ciudad from oficina where pais = "España";

-- Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
select nombre, apellido1, apellido2, email from empleado where codigo_jefe = 7; 

-- Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select puesto, nombre, apellido1, apellido2, email from empleado where codigo_empleado = 1;

-- Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
select nombre, apellido1, apellido2, puesto from empleado where puesto != "Representante Ventas";

-- Devuelve un listado con el nombre de los todos los clientes españoles.
select nombre_cliente from cliente where pais = "spain";

-- Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select distinct estado from pedido;

-- Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega
-- ha sido al menos dos días antes de la fecha esperada. 

-- Utilizando la función ADDDATE de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where fecha_entrega <= ADDDATE(fecha_esperada, interval -2 day);

-- Utilizando la función DATEDIFF de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where datediff(fecha_esperada, fecha_entrega) >= 2;

-- ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where fecha_entrega <= fecha_esperada - interval 2 day;

-- Devuelve un listado de todos los pedidos que fueron en 2009.
select * from pedido where year(fecha_pedido) = 2009;

-- Devuelve un listado de todos los pedidos que han sido  en el mes de enero de cualquier año.
select * from pedido where month(fecha_pedido) = 01;

-- Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select * from pago where year(fecha_pago) = 2008 and forma_pago = "PayPal" order by total desc;

-- Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
select distinct forma_pago from pago;

-- Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock.
-- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
select * from producto where gama = "Ornamentales" and cantidad_en_stick > 100 order by precio_venta desc;

-- Devuelve un listado con todos los clientes que sean de la ciudad de Madrid
-- y cuyo representante de ventas tenga el código de empleado 11 o 30.
select * from cliente where ciudad = "Madrid" and codigo_empleado_rep_ventas = 11 or codigo_empleado_rep_ventas = 30;

-- Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
select nombre_cliente, empleado.nombre, empleado.apellido1 from cliente inner join empleado where codigo_empleado_rep_ventas = empleado.codigo_empleado;

-- Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
select nombre_cliente, i.nombre, i.apellido1 from cliente inner join empleado i inner join pago e where e.codigo_cliente = cliente.codigo_cliente;

-- Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select nombre_cliente, i.nombre, i.apellido1, j.ciudad from cliente inner join empleado i inner join pago e inner join oficina j where e.codigo_cliente = cliente.codigo_cliente and i.codigo_oficina = j.codigo_oficina ;

-- Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select distinct oficina.linea_direccion1 ,codigo_oficina, cliente.ciudad from oficina inner join cliente where cliente.ciudad='Fuenlabrada';

-- Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select nombre_cliente, i.nombre, i.apellido1, j.ciudad from cliente inner join empleado i  inner join oficina j where cliente.codigo_empleado_rep_ventas = i.codigo_empleado and i.codigo_oficina = j.codigo_oficina;

-- Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
select empleado.nombre, empleado.apellido1, j.nombre from empleado inner join empleado j where empleado.codigo_jefe = j.codigo_empleado; 

-- Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
select empleado.nombre, empleado.apellido1, j.nombre as jefe, k.nombre as jefe_del_jefe from empleado inner join empleado j inner join empleado k where empleado.codigo_jefe = j.codigo_empleado and  j.codigo_jefe = k.codigo_empleado;

-- Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select nombre_cliente, fecha_entrega, fecha_esperada from cliente inner join pedido where cliente.codigo_cliente = pedido.codigo_cliente and pedido.fecha_entrega > pedido.fecha_esperada; 

-- Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
select nombre_cliente, producto.gama from cliente inner join detalle_pedido inner join pedido inner join producto where cliente.codigo_cliente = pedido.codigo_cliente and pedido.codigo_pedido = detalle_pedido.codigo_pedido and detalle_pedido.codigo_producto = producto.codigo_producto;