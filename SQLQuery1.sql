CREATE DATABASE veterinaria;
ALTER DATABASE veterinaria MODIFY NAME = veterinarias;
USE veterinarias
CREATE TABLE cliente(
	id_cliente NUMERIC(10) PRIMARY KEY,
	nombre_cliente VARCHAR (30) NOT NULL,
	apellido_cliente VARCHAR (40) NOT NULL,
	direccion_cliente VARCHAR (50) NOT NULL,
	tel NUMERIC (15) DEFAULT 000000000,
	clave VARCHAR (15) NOT NULL,
	email VARCHAR (30) NOT NULL,
	CONSTRAINT UQ_email UNIQUE(email)
);
CREATE TABLE mascotas(
	cod_mascota VARCHAR(5),
	constraint PK_cod_mascota PRIMARY KEY (cod_mascota),
	nombre_mascota VARCHAR (15) NOT NULL,
	tipo_mascota VARCHAR (15) NOT NULL,
	genero_mascota VARCHAR (15) NOT NULL,
	raza_mascota VARCHAR (15) NOT NULL,
	id_clienteFK NUMERIC (10),
	constraint FK_id_clienteFK FOREIGN KEY (id_clienteFK) REFERENCES cliente(id_cliente)
);
CREATE TABLE producto(
	cod_producto VARCHAR (10),
	CONSTRAINT PK_cod_producto PRIMARY KEY (cod_producto),
	nombre_producto VARCHAR (15) NOT NULL,
	marca VARCHAR (15) NOT NULL,
	precio INT NOT NULL
);

CREATE TABLE compra(
	cod_compra VARCHAR (10),
	CONSTRAINT PK_cod_compra PRIMARY KEY (cod_compra),
	id_clientesFK NUMERIC (10),
	CONSTRAINT FK_id_clientesFK FOREIGN KEY (id_clientesFK) REFERENCES cliente(id_cliente),
	cod_productoFK VARCHAR (10),
	CONSTRAINT FK_cod_productoFK FOREIGN KEY (cod_productoFK) REFERENCES producto(cod_producto),
	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	valor_compra INT NOT NULL,
	cantidad INT NOT NULL
);
CREATE TABLE vacuna(
	cod_vacuna VARCHAR (15),
	CONSTRAINT PK_cod_vacuna PRIMARY KEY (cod_vacuna),
	nombre_vacuna VARCHAR (15) NOT NULL,
	dosis NUMERIC (10) NOT NULL,
	enfermedad VARCHAR (15)
);
CREATE TABLE veterinario(
	cod_veterinario VARCHAR (10),
	CONSTRAINT PK_cod_veterinario PRIMARY KEY (cod_veterinario)
);
CREATE TABLE vacunacion(
	cod_vacunacion VARCHAR (15),
	CONSTRAINT PK_cod_vacunacion PRIMARY KEY (cod_vacunacion),
	cantidad INT NOT NULL,
	cod_mascotaFK VARCHAR (5),
	CONSTRAINT FK_cod_mascotaFK FOREIGN KEY (cod_mascotaFK) REFERENCES mascotas (cod_mascota),
	cod_vacunaFK VARCHAR (15),
	CONSTRAINT FK_cod_vacunaFK FOREIGN KEY (cod_vacunaFK) REFERENCES vacuna (cod_vacuna),
	fecha_vacunacion DATE,
	hora_vacunacion TIME,
	cod_veterinarioFK VARCHAR (10),
	CONSTRAINT FK_cod_veterinarioFK FOREIGN KEY (cod_veterinarioFK) REFERENCES veterinario (cod_veterinario)
);
