-- CREATE DATABASE Jardineria;
Use Jardineria;

CREATE TABLE IF NOT EXISTS Gama_producto(
gama varchar(50) not null,
descripcion_texto text,
descripcion_html text,
imagen varchar(256),
primary key(gama)
);
CREATE TABLE IF NOT EXISTS Producto(
codigo_producto varchar(15),
nombre varchar(70) not null,
gama varchar(50) not null,
dimensiones varchar(50),
proveedor varchar(50),
descripcion text,
cantidad_en_stick smallint not null,
precio_venta decimal not null,
precio_proveedor decimal,
primary key(codigo_producto),
constraint gama foreign key (gama)
	references Gama_producto(gama)
);
CREATE TABLE IF NOT EXISTS Detalle_pedido(
codigo_pedido int,
codigo_producto varchar(15),
cantidad int not null,
precio_unidad decimal not null,
numero_linea smallint,
constraint codigo_pedido foreign key(codigo_pedido)
	references Pedido(codigo_pedido),
constraint codigo_producto foreign key(codigo_producto)
	references Producto(codigo_producto)
);
CREATE TABLE IF NOT EXISTS Pedido(
codigo_pedido int not null,
fecha_pedido date not null,
fecha_esperada date not null,
fecha_entrega date,
estado varchar(15) not null,
comentarios text,
codigo_cliente int not null,
primary key(codigo_pedido),
constraint codigo_cliente foreign key(codigo_cliente)
	references Cliente(codigo_cliente)
);
CREATE TABLE IF NOT EXISTS Cliente(
codigo_cliente int not null,
nombre_cliente varchar(50) not null,
nombre_contacto varchar(30),
apellido_contacto varchar(30),
telefono varchar(15) not null,
fax varchar(15) not null,
linea_direccion1 varchar(50) not null,
linea_direccion2 varchar(50),
ciudad varchar(50) not null,
region varchar(50),
pais varchar(50),
codigo_postal varchar(10),
codigo_empleado_rep_ventas int,
limite_credito decimal,
primary key(codigo_cliente)
);
CREATE TABLE IF NOT EXISTS Pago(
codigo_cliente int,
forma_pago varchar(40),
id_transaccion varchar(50),
fecha_pago date,
total decimal,
primary key(id_transaccion),
constraint codigo_clientes foreign key(codigo_cliente)
	references Cliente(codigo_cliente)
);
CREATE TABLE IF NOT EXISTS Empleado(
codigo_empleado int not null,
nombre varchar(50) not null,	
apellido1 varchar(50) not null,
apellido2 varchar(50),
extension varchar(10),
email varchar(100),
codigo_oficina varchar(10) not null,
codigo_jefe int,
puesto varchar(50),
primary key(codigo_empleado),
constraint codigo_oficina foreign key(codigo_oficina)
	references Oficina(codigo_oficina)
);
CREATE TABLE IF NOT EXISTS Oficina(
codigo_oficina varchar(10) not null,
ciudad varchar(30) not null,
pais varchar(50) not null,
region varchar(50),
codigo_postal varchar(10) not null,
telefono varchar(20),
linea_direccion1 varchar(50),
linea_direccion2 varchar(50),
primary key(codigo_oficina)
)