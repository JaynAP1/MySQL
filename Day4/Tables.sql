Create database T2;

CREATE TABLE departamento (
    codigo INT PRIMARY KEY,
    nombre VARCHAR(50),
    presupuesto DECIMAL(10, 2)
);

CREATE TABLE empleado (
    codigo INT PRIMARY KEY,
    nif VARCHAR(10),
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    codigo_departamento INT,
    FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);
