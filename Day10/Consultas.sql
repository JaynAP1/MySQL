-- 1). Obtener el total de pedidos realizados por un cliente.
select count(pedido.id), cliente.nombre, cliente.apellido1 from pedido inner join cliente on pedido.id_cliente = cliente.id group by 2,3;

-- 2). Calcular la comision total ganada por un comercial.
select sum(total)*comision as Comision_Comercial, id_comercial from pedido inner join comercial on pedido.id_comercial = comercial.id group by 2;

-- 3). Obtener el cliente con mayor cantidad de pedidos.
select count(pedido.id), cliente.nombre, cliente.apellido1 from pedido inner join cliente on pedido.id_cliente = cliente.id group by 2,3 order by 1 desc limit 1;

-- 4). Contar la cantidad de pedidos realizados en un año especifico.
select count(pedido.id), year(fecha) from pedido group by 2;

-- 5). Obtener el promedio de total de pedidos por cliente.
select avg(pedido.id), cliente.nombre, count(cliente.nombre) from pedido inner join cliente on pedido.id_cliente = cliente.id group by 2;

Delimiter //
Create procedure Promedio()
begin
Declare SumTotal int;

set SumTotal = (select count(*) from pedido)


end
Delimiter // ;

select count(*)/3 from pedido