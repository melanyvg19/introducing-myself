CREATE DATABASE edemco;
\c edemco;

CREATE TABLE usuario (
    iduser SERIAL PRIMARY KEY,
    username VARCHAR(45) NOT NULL,
    password VARCHAR(20) NOT NULL,
    email_usuario VARCHAR(50),
    password_email VARCHAR (255)
);

CREATE TABLE operador (
    id_operador SERIAL PRIMARY KEY,
    nombre_operador VARCHAR(45) NOT NULL
);

CREATE TABLE tipo_cliente (
    id_tipo_cliente SERIAL PRIMARY KEY,
    tipo_cliente VARCHAR(30) NOT NULL
);

CREATE TABLE cliente (
    id_cliente BIGSERIAL PRIMARY KEY,
    nombre_cliente VARCHAR(50),
    contrato VARCHAR(50),
    direccion VARCHAR(100),
    nit INT,
    correo VARCHAR(100),
    id_operador INT,
    id_tipo_cliente INT,
    FOREIGN KEY (id_operador) REFERENCES operador(id_operador),
    FOREIGN KEY (id_tipo_cliente) REFERENCES tipo_cliente(id_tipo_cliente)
);

CREATE TABLE planta(
    id_planta VARCHAR(4) PRIMARY KEY,
    nombre_planta VARCHAR(50) NOT NULL,
    centro_costos VARCHAR(50) NOT NULL,
    id_cliente BIGINT,
    asunto VARCHAR(100),
    url_img VARCHAR(255),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE factura (
    id_factura SERIAL PRIMARY KEY,
    fecha_inicial DATE,
    fecha_final DATE,
    dias_facturados INT,
    cufe VARCHAR(255),
    fecha_dian DATE,
    pdf VARCHAR(250),
    numero_factura VARCHAR(30),
    id_planta VARCHAR (4),
    FOREIGN KEY (id_planta) REFERENCES planta (id_planta)
);

CREATE TABLE facturacion_especial (
    id_facturacion_especial BIGSERIAL PRIMARY KEY,
    excedente DOUBLE PRECISION,
    costo_agregado DOUBLE PRECISION,
    valor_exportacion DOUBLE PRECISION,
    id_planta VARCHAR (4),
    FOREIGN KEY (id_planta) REFERENCES planta (id_planta)
);

CREATE TABLE tarifa_operadores (
    id_tarifa_operador BIGSERIAL PRIMARY KEY,
    tarifa_operador DOUBLE PRECISION,
    mes INT,
    anio INT,
    id_operador INT,
    FOREIGN KEY (id_operador) REFERENCES operador(id_operador)
);

CREATE TABLE generacion (
    id_generacion SERIAL PRIMARY KEY,
    generacion_actual DOUBLE PRECISION,
    generacion_acumulado DOUBLE PRECISION,
    valor_unidad DOUBLE PRECISION,
    valor_total DOUBLE PRECISION,
    diferencia_tarifa DOUBLE PRECISION,
    ahorro_actual DOUBLE PRECISION,
    ahorro_acumulado DOUBLE PRECISION,
    ahorro_codos_actual DOUBLE PRECISION,
    ahorro_codos_acumulado DOUBLE PRECISION,
    anio INT,
    mes INT,
    id_tarifa_operador BIGINT,
     id_planta VARCHAR (4),
    FOREIGN KEY (id_planta) REFERENCES planta (id_planta),
    FOREIGN KEY (id_tarifa_operador) REFERENCES tarifa_operadores(id_tarifa_operador)
);

CREATE TABLE email (
    id_email SERIAL PRIMARY KEY,
    email VARCHAR(50) UNIQUE,
    id_planta VARCHAR(4),
    FOREIGN KEY (id_planta) REFERENCES planta(id_planta)
);

CREATE OR REPLACE FUNCTION actualizar_generacion_acumulada()
RETURNS TRIGGER AS $$
BEGIN
   
    UPDATE generacion
    SET generacion_acumulado = (
        SELECT SUM(generacion_actual)
        FROM generacion
        WHERE id_planta = NEW.id_planta
          AND anio = NEW.anio
          AND mes <= NEW.mes
    )
    WHERE id_generacion = NEW.id_generacion;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_generacion_acumulada
AFTER INSERT OR UPDATE ON generacion
FOR EACH ROW
EXECUTE FUNCTION actualizar_generacion_acumulada();



INSERT INTO tipo_cliente (id_tipo_cliente, tipo_cliente) VALUES 
(1, 'Normal'),
(2, 'Especial');

INSERT INTO operador (id_operador, nombre_operador) VALUES 
(1, 'EPM'),
(2, 'Air-e');

INSERT INTO tarifa_operadores (tarifa_operador, mes, anio, id_operador) VALUES 
(98200.23, 10, 2023, 1),
(90521.14, 10, 2023, 2);

INSERT INTO cliente (id_cliente, nombre_cliente, contrato, direccion, nit, correo, id_operador, id_tipo_cliente) VALUES 
(1, 'Ceipa', 'FE13256', 'Carrera 98 #29-72', 1, 'ceipa@ceipa.com.co', 1, 1),
(2, 'Liceo Frances', 'FE578964', 'Calle 38 #19-72', 2, 'liceofrances@liceofrances.com.co', 1, 1),
(3, 'Incubant', 'FE245678', 'Carrera 24 #68-90', 3, 'incubant@incubant.com.co', 1, 1),
(4, 'Punto Clave', 'FE12312', 'Calle 52 #68-24', 4, 'puntoclave@puntoclave.com.co', 2, 2),
(5, 'Lemont', 'FE367431', 'Carrera 21 #35-21', 5, 'lemont@lemont.com.co', 1, 1),
(6, 'Pollocoa', 'FE23448', 'Calle 20 #23-52', 6, 'pollocoa@pollocoa.com.co', 2, 1);

INSERT INTO planta (id_planta, nombre_planta, centro_costos, id_cliente) VALUES
('506', 'Ceipa Barranquilla', 'CEIPABARRANQUIL', 1),
('508', 'Liceo Frances', 'LICEOFRANCESSFV', 2),
('514', 'Incubant', 'INCUBANSSFV', 3),
('505', 'Punto Clave', 'PUNTOCLAVESSFV', 4),
('512', 'Lemont Salon Social', 'LEMONT1SALONSOC', 5), 
('513', 'Pollocoa', 'POLLOCOASSFV', 6),
('507', 'Ceipa Sabaneta', 'CEIPASABANETASS', 1),
('511', 'Lemont Porteria', 'LEMONT1PORTERIA', 5);

INSERT INTO facturacion_especial (id_planta, excedente, costo_agregado, valor_exportacion) VALUES 
('505', 2456534.83, 1253534.32, 15274.26);

INSERT INTO factura (id_factura, fecha_inicial, fecha_final, dias_facturados, cufe, fecha_dian, pdf, numero_factura, id_planta) VALUES 
(1, '2023-01-01', '2023-01-31', 31, 'e82ddc4bf34931e2974b7c8af7ac0cc5d1d06772a0b85228566c8073b21402203', '2023-01-25', 'https://google.com', 'FE10001', '508'),
(2, '2023-01-01', '2023-01-31', 31, 'e82ddc4bf34931e2974b7c8af7aa0f6c3c40ffdcc5d1d06772a0b85228566c8073b21402203', '2023-01-25', 'https://google.com', 'FE10123', '512');

INSERT INTO generacion (id_generacion, generacion_actual, generacion_acumulado, valor_unidad, valor_total, diferencia_tarifa, ahorro_actual, ahorro_acumulado, ahorro_codos_actual, ahorro_codos_acumulado, anio, mes, id_planta, id_tarifa_operador) VALUES 
(1, 2600.99, 8096.45, 580.41, 2501.26, 5236.24, 2657812.65, 523266.25, 1205.61, 3204.35, 2023, 1, '508', 1),
(2, 1354.39, 24566.37, 265.21, 5781.19, 2465.22, 1356.25, 3266.28, 1368.27, 32146.47, 2023, 1, '512', 2);

INSERT INTO usuario (iduser, username, password) VALUES 
(1, 'admin@admin.com', 'admin');
