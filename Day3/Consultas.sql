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