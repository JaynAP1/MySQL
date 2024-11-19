Create database if not exists AutoRental;

Use AutoRental;

Create table if not exists Gestion_Sucursales(
id int auto_increment,
Ciudad varchar (30) not null,
Direccion varchar (50) not null,
Fijo int,
Celular int not null,
Correo_Electronico varchar(60) not null,
primary key(id)
);
Create table if not exists Clientes(
id int auto_increment,
Cedula varchar (30) not null,
Nombre varchar (30) not null,
Apellidos varchar (50) not null,
Direccion varchar (30) not null,
Ciudad_Residencia varchar (50) not null,
Celular int not null,
Correo_Electronico varchar (50),
primary key (id)
);
Create table if not exists Empleados (
id int auto_increment,
Cedula varchar (30) not null,
Nombre varchar (30) not null,
Apellidos varchar (50) not null,
Direccion varchar (30) not null,
Ciudad_Residencia varchar (50) not null,
Celular int not null,
Correo_Electronico varchar(50) not null,
primary key (id)
);
Create table if not exists Vehiculos (
id int auto_increment,
Tipo_Vehiculo varchar (30) not null,
Placa varchar (20) not null,
Referencia varchar (30),
Modelo varchar (20),
Puertas int not null,
Capacidad int not null,
Sunroof tinyint,
Motor varchar (30) not null,
Color varchar(40),
primary key (id)
);
Create table if not exists Descuentos (
id int auto_increment,
Porcentaje_Descuento int not null,
Inicio_Descuento varchar (30) not null,
Final_Descuento varchar (30) not null,
Tipo_Vehiculo varchar (30) not null,
primary key (id)
);
Create table if not exists Gestion_Vehicular (
id int auto_increment,
Sucursal_Actual_Vehiculo int not null,
Disponibilidad tinyint not null,
foreign key (id) references Vehiculos(id)
);
Create table if not exists Alquileres (
id int auto_increment,
Vehiculo int not null,
Cliente int not null,
Empleado int not null,
Sucursal_Salida int not null,
Fecha_Salida varchar(30) not null,
Sucursal_Llegada int not null,
Fecha_Lleagada varchar (30) not null,
Fecha_Esperada_Llegada varchar (30) not null,
Valor_Semana int not null,
Valor_Dia int not null,
Descuento_id int,
Valor_Cotizado int not null,
Valor_Pagado int not null,
primary key (id),
foreign key (Vehiculo) references Gestion_Vehicular(id),
foreign key (Cliente) references Clientes (id),
foreign key (Empleado) references Empleados (id),
foreign key (Sucursal_Salida) references Gestion_Sucursales (id),
foreign key (Sucursal_Llegada) references Gestion_Sucursales (id),
foreign key (Descuento_id) references Descuentos (id)
);


