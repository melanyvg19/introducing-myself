CREATE DATABASE edemco;
USE edemco;

CREATE TABLE usuario (
    iduser INT PRIMARY KEY,
    username VARCHAR(45) NOT NULL,
    password VARCHAR(20) NOT NULL
);


CREATE TABLE operador (
    id_operador INT PRIMARY KEY,
    nombre_operador VARCHAR(45) NOT NULL
);


CREATE TABLE tipo_cliente (
    id_tipo_cliente INT PRIMARY KEY,
    tipo_cliente VARCHAR(30) NOT NULL
);

CREATE TABLE cliente (
    id_cliente BIGINT PRIMARY KEY,
    nombre_cliente VARCHAR(50),
    contrato VARCHAR(50),
    direccion VARCHAR(100),
    nit INT,
    correo VARCHAR(100),
    id_operador INT,
    id_tipo_cliente INT,
    codigo_planta INT,
    FOREIGN KEY (id_operador) REFERENCES operador(id_operador),
    FOREIGN KEY (id_tipo_cliente) REFERENCES tipo_cliente(id_tipo_cliente)
);
ALTER TABLE cliente
DROP COLUMN codigo_planta;


CREATE TABLE planta(
	codigo_planta INT PRIMARY KEY,
	nombre_planta VARCHAR (50) not null,
	centro_costos varchar (50) NOT NULL,
    id_cliente BIGINT,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
    );
    ALTER TABLE planta
    DROP COLUMN codigo_planta;
    ALTER TABLE planta
    ADD COLUMN id_planta VARCHAR (4) PRIMARY KEY;

CREATE TABLE factura (
    id_factura INT PRIMARY KEY,
    fecha_inicial DATE,
    fecha_final DATE,
    dias_facturados INT,
    cufe VARCHAR(255),
    fecha_dian DATE,
    pdf VARCHAR(250),
    numero_factura VARCHAR(30),
    id_cliente BIGINT,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);


CREATE TABLE facturacion_especial (
    id_facturacion_especial BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_cliente bigint,
    exportacion DOUBLE,
    valor_exportacion DOUBLE,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE tarifa_operadores (
    id_tarifa_operador BIGINT AUTO_INCREMENT PRIMARY KEY,
    tarifa_operador DOUBLE,
    mes INT,
    anio INT,
    id_operador INT,
    FOREIGN KEY (id_operador) REFERENCES operador(id_operador)
);

CREATE TABLE generacion (
    id_generacion INT PRIMARY KEY,
    generacion_actual DOUBLE,
    generacion_acumulado DOUBLE,
    valor_unidad DOUBLE,
    valor_total DOUBLE,
    diferencia_tarifa DOUBLE,
    ahorro_actual DOUBLE,
    ahorro_acumulado DOUBLE,
    ahorro_codos_actual DOUBLE,
    ahorro_codos_acumulado DOUBLE,
    anio INT,
    mes INT,
    id_cliente BIGINT,
    id_tarifa_operador BIGINT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_tarifa_operador) REFERENCES tarifa_operadores(id_tarifa_operador)
);


INSERT INTO tipo_cliente (id_tipo_cliente, tipo_cliente) VALUES 
(1, 'Normal'),
(2, 'Especial');


INSERT INTO operador (id_operador, nombre_operador) VALUES 
(1, 'EPM'),
(2, 'Air-e');


INSERT INTO tarifa_operadores (tarifa_operador, mes, anio, id_operador) VALUES 
(98200.23, 10, 2023, 1),
(90521.14, 10, 2023, 2);


INSERT INTO cliente (id_cliente, nombre_cliente, contrato, direccion, planta, nit, correo, id_operador, id_tipo_cliente) VALUES 
(1, 'Pollocoa', 'FE23448', 'Calle 20 #23-52 La raya', 'Pollocoa Fresco y con Sabor', 1, 'acomerpollo@pollocoa.com.co', 1, 1),
(2, 'Lemont', 'FE367431', 'Carrera 21 #35-21 Planeco', 'Lemont Salón Social', 2, 'lemont@lemont.com.co', 2, 1),
(3, 'Punto Clave', 'FE12312', 'Calle 52 #68-24 Manrique', 'Punto Clave', 3, 'puntoclave@elmejor.com.co', 2, 2);

INSERT INTO planta (id_planta, nombre_planta, centro_costos)  VALUES
("506", "Ceipa Barranquilla", "CEIPABARRANQUIL"),
("508", "Liceo Frances", "LICEOFRANCESSFV"),
("514", "Incubant", "INCUBANSSFV"),
("505", "Punto Clave", "PUNTOCLAVESSFV"),
("512", "Lemont Salon Social", "LEMONT1SALONSOC"), 
("513", "Pollocoa", "POLLOCOASSFV"),
("507", "Ceipa Sabaneta", "CEIPASABANETASS"),
("511", "Lemont Porteria", "LEMONT1PORTERIA");
SELECT * FROM planta;



DELETE FROM cliente WHERE id_cliente = 1;
DELETE FROM cliente WHERE id_cliente = 2;
DELETE FROM cliente WHERE id_cliente = 3;
SELECT * FROM cliente;



INSERT INTO facturacion_especial (id_cliente, exportacion, valor_exportacion) VALUES 
(3, 2456534.83, 1253534.32);


INSERT INTO factura (id_factura, fecha_inicial, fecha_final, dias_facturados, cufe, fecha_dian, pdf, numero_factura, id_cliente) VALUES 
(1, '2023-01-01', '2023-01-31', 31, 'e82ddc4bf34931e2974b7c8af7ac0cc5d1d06772a0b85228566c8073b21402203', '2023-01-25', 'https://google.com', 'FE10001', 1),
(2, '2023-01-01', '2023-01-31', 31, 'e82ddc4bf34931e2974b7c8af7aa0f6c3c40ffdcc5d1d06772a0b85228566c8073b21402203', '2023-01-25', 'https://google.com', 'FE10123', 2);


INSERT INTO generacion (id_generacion, generacion_actual, generacion_acumulado, valor_unidad, valor_total, diferencia_tarifa, ahorro_actual, ahorro_acumulado, ahorro_codos_actual, ahorro_codos_acumulado, anio, mes, id_cliente, id_tarifa_operador) VALUES 
(1, 2600.99, 8096.45, 580.41, 2501.26, 5236.24, 2657812.65, 523266.25, 1205.61, 3204.35, 2023, 1, 1, 1),
(2, 1354.39, 24566.37, 265.21, 5781.19, 2465.22, 1356.25, 3266.28, 1368.27, 32146.47, 2023, 1, 2, 2);


INSERT INTO usuario (iduser, username, password) VALUES 
(1, 'KrlosPK', 'KrlosPK'),
(2, 'Mauro', 'LaRayaLoMejor'),
(3, 'Andres', 'Trans4Ever');
