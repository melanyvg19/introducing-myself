CREATE DATABASE IF NOT EXISTS diagnostico;

USE diagnostico;

CREATE TABLE IF NOT EXISTS rol(
	id_rol INT NOT NULL,
	nombre_rol char (50) NOT NULL,
	descripcion_rol char (255) NOT NULL,
	PRIMARY KEY(id_rol)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tipo_empresa(
	id_tipo_empresa INT NOT NULL,
	nro_empleados INT NOT NULL,
	es_aliado boolean NOT NULL,
	PRIMARY KEY(id_tipo_empresa)
)ENGINE=INNODB;
alter table tipo_empresa
ADD tamano_empresa char (50) NOT NULL;
SELECT * FROM tipo_empresa;

CREATE TABLE IF NOT EXISTS empresa(
	nit_empresa INT NOT NULL,
    nombre_empresa char (100) NOT NULL,
    direccion_principal char(200) NOT NULL,
    estado_empresa char(30) NOT NULL,
    cantidad_sedes int NOT NULL,
    establecimientos_comerciales boolean NOT NULL,
    sector_economico char(30) NOT NULL,
    alcance_comercial char(100) NOT NULL,
    id_tipo_empresa int NOT NULL,
    PRIMARY KEY(nit_empresa),
    CONSTRAINT fktipo_empresa
    FOREIGN KEY(id_tipo_empresa)
    REFERENCES tipo_empresa(id_tipo_empresa)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS usuario (
	id_usuario int NOT NULL,
	nombre_usuario char(50) NOT NULL,
	apellido_usuario char(50) NOT NULL,
	cargo char(30) NOT NULL,
	correo_usuario char(70) NOT NULL UNIQUE,
	contrasena char(255) NOT NULL,
	fecha_nacimiento date NOT NULL,
	estado_usuario char(20) NOT NULL,
	anios_vinculado int NOT NULL,
	id_rol int NOT NULL,
	nit_empresa int NOT NULL,
    PRIMARY KEY (id_usuario),
    CONSTRAINT fkid_rol
    FOREIGN KEY(id_rol)
    REFERENCES rol(id_rol),
    CONSTRAINT fknit_empresa
    FOREIGN KEY(nit_empresa)
    REFERENCES empresa(nit_empresa)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS categoria(
	id_categoria int NOT NULL,
    nombre_categoria varchar (40) NOT NULL,
    numero_preguntas int NOT NULL,
    PRIMARY KEY (id_categoria)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS aplicacion_prueba(
	cod_aplicacion_prueba int NOT NULL,
    fecha_aplicacion date NOT NULL,
    id_cliente int NOT NULL,
    id_encuestador int NOT NULL,
    id_categoria int NOT NULL,
    PRIMARY KEY (cod_aplicacion_prueba),
    CONSTRAINT fkid_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES usuario (id_usuario),
    CONSTRAINT fkid_encuestador
    FOREIGN KEY (id_encuestador)
    REFERENCES usuario (id_usuario),
    CONSTRAINT fkid_categoria
    FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tipo_pregunta (
	id_tipo_pregunta int NOT NULL,
    nombre_tipo varchar(42)  NOT NULL,
    PRIMARY KEY (id_tipo_pregunta)
)ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS pregunta(
	id_pregunta int NOT NULL,
    id_tipo_pregunta  int NOT NULL,
    id_categoria  int NOT NULL,
    nombre_pregunta varchar(500),
    PRIMARY KEY (id_pregunta),
    CONSTRAINT fkid_tipo_pregunta
    FOREIGN KEY (id_tipo_pregunta)
    REFERENCES tipo_pregunta(id_tipo_pregunta),
    CONSTRAINT fk_id_categoria
    FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria)
)ENGINE=INNODB;
drop database diagnostico; 

CREATE TABLE IF NOT EXISTS opcion (
	id_respuesta int NOT NULL,
	texto_respuesta varchar (500) NOT NULL,
	puntuacion float NOT NULL,
	id_pregunta int NOT NULL,
    PRIMARY KEY (id_respuesta),
    CONSTRAINT fkid_pregunta
    FOREIGN KEY (id_pregunta)
    REFERENCES pregunta(id_pregunta)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS respuestas_aplicacion  (
	cod_form_aplicacion INT NOT NULL,
    id_opcion INT NOT NULL,
    id_pregunta INT NOT NULL,
    puntuacion_total double NOT NULL,
    fecha_aplicacion date NOT NULL,
    cod_aplicacion_prueba int NOT NULL,
	id_categoria int NOT NULL,
    PRIMARY KEY (cod_form_aplicacion),
    CONSTRAINT fk_id_opcion
    FOREIGN KEY (id_opcion)
    REFERENCES opcion(id_respuesta),
    CONSTRAINT fk_id_pregunta
    FOREIGN KEY (id_pregunta)
    REFERENCES pregunta (id_pregunta),
    CONSTRAINT fk_cod_aplicacion_prueba
    FOREIGN KEY (cod_aplicacion_prueba)
    REFERENCES aplicacion_prueba (cod_aplicacion_prueba)
)ENGINE=INNODB;

SELECT 
    pregunta.id_pregunta,
    pregunta.nombre_pregunta AS pregunta,
    tipo_pregunta.nombre_tipo AS tipo_pregunta,
    opcion.id_respuesta,
    opcion.texto_respuesta AS respuesta,
    opcion.puntuacion AS puntaje
FROM 
    pregunta
INNER JOIN 
    tipo_pregunta ON pregunta.id_tipo_pregunta = tipo_pregunta.id_tipo_pregunta
INNER JOIN 
    opcion ON pregunta.id_pregunta = opcion.id_pregunta
WHERE 
    pregunta.id_categoria = 'ID_DE_LA_CATEGORIA_A_CONSULTAR';
    
    
    INSERT INTO categoria (id_categoria, nombre_categoria, numero_preguntas) VALUES
    (100, "Cultura Organizacional", 12 ),
    (101, "Personas", 3 ),
    (102, "Infraestructura", 4 ),
    (103, "Procesos", 14),
    (104, "Marketing Mix", 5),
    (105, "Bases de datos", 7),
    (106, "Tableros", 4 ),
    (107, "Automatizacion", 3),
    (108, "Paginas Web", 7),
    (109, "Aplicaciones", 2);
    SELECT * FROM categoria;
    
    
    INSERT INTO tipo_pregunta (id_tipo_pregunta, nombre_tipo) VALUES
    (200, "Seleccion multiple unica respuesta"),
    (201, "Seleccion multiple multiple respuesta"),
    (202, "Verdadero o Falso");
    
    INSERT INTO pregunta (id_pregunta, id_tipo_pregunta, id_categoria, nombre_pregunta) VALUES
    (300, 202, 100, "¿Tienen claridad dentro de la organización de los conceptos en transformación digital y sus etapas de integración?"),
    (301, 202, 100, "¿Cuentan con correo electrónico institucional?"),
    (302, 202, 100, "¿Cuentan con página web institucional?"),
    (303, 200, 100, "¿Tienen implementada una política de tratamiento de datos con los stakeholders (clientes, proveedores, competencia, colaboradores?)"),
    (304, 202, 100, "¿Tienen un área o colaborador dentro de la organización que lidere el proceso de transformación digital?"),
    (305, 202, 100, "¿Tienen definidas políticas para la transformación digital en la organización?"),
    (306, 202, 100, "¿Tiene asignado un presupuesto para la transformación digital de la organización?"),
    (307, 202, 100," ¿Domina la organización alguna de las siguientes metodología de agilismo para el desarrollo de sus retos internos?: Lean, Scrum, Kanban, XP-Xtreme Programming, OKR"),
    (308, 200, 100, "¿Cómo sabes  identificar el estado actual de tu empresa o área? "),
    (309, 200, 100, "¿En qué criterio te basas para la toma de decisiones?"),
    (310, 201, 100, "¿Puedes identificar cuál de las siguientes variables tienes conocimiento y control?"),
    (311, 202, 100, "¿Aplica alguna de las siguientes tecnologías emergentes dentro de los procesos en la organización?"),
    (312, 201, 101, "Nivel de formación de los colaboradores para la transformación digital"),
    (313, 200, 101, "¿Quién tiene el poder de decisión para inversiones en tecnología?"),
    (314, 200, 101,"¿Cuenta con su empresa con un área encargada en tecnología o transformación digital?");
    
    INSERT INTO pregunta (id_pregunta, id_tipo_pregunta, id_categoria, nombre_pregunta) VALUES
    (315, 201, 102, "Cuenta con empresas aliadas y/o proveedores de tecnología (Hardware , Software- Licencias) para:"),
    (316, 200, 102, "¿Con qué tipo de servidor o infraestructura cuenta?"),
    (317, 201, 102, "¿Aplican alguna herramienta para gestionar el agilismo en la organización?"),
    (318, 200, 102, "¿En caso de ser digital, cuáles son las características del almacenamiento?"),
    (319, 200, 103, "¿Cómo registra y guarda las variables de la empresa?"),
    (320, 200, 103, "¿Quién registra los datos?"),
    (321, 200, 103, "¿Cuántos procesos están involucrados en el registro de los datos?"),
    (322, 200, 103, "¿Cuánto tiempo en promedio gasta cada uno de los encargados en el registro de los datos por cada proceso?"),
    (323, 200, 103, "¿Cómo administra los datos?"),
    (324, 200, 103, "¿Quién administra o consulta los datos?"),
    (325, 201, 103, "¿Cuál de las siguientes áreas percibe usted puede ser la más prioritaria para monitorear a través de una herramienta que integre la información para la toma de decisiones?"),
    (326, 200, 103, "Mapeo de la efectividad de los procesos"),
    (327, 200, 103, "Afectación de los procesos"),
    (328, 200, 103, "Alargamiento de procesos simples"),
    (329, 200, 103, "¿Cuáles de los siguientes son los canales de pago mediante los cuales hoy recauda los cobros de sus clientes?"),
    (330, 200, 103, "¿Qué tan satisfecho se encuentra con la forma de pago anteriormente mencionada para el recaudo de cobro a sus clientes?"),
    (331, 201, 103, "Identifica en su organización algun o algunos procesos que se caractericen por:"),
    (332, 201, 103, "¿Cuál de los siguientes macroprocesos en su organización involucra las características anteriormente mencionadas? ( Puede elegir varias)"),
    (333, 201, 104, "¿Por cuáles de los siguientes canales usted expone sus productos o servicios a sus clientes?"),
    (334, 201, 104, "¿A qué cantidad de público identifica que llega su oferta a través de los canales anteriormente mencionados?"),
    (335, 201, 104, "¿Cuál es la naturaleza de la oferta que mejor describe su portafolio?"),
    (336, 201, 104, "¿A través de cuál de las siguientes estrategias hoy tienen definido el aumento de sus ventas?"),
    (337, 201, 104, "Considerando un canal digital para la venta de sus productos y servicios a su mercado objetivo ¿Cuál de las siguientes funcionalidades esperaría encontrar en un espacio digital corporativo? ( puede elegir vaias),"),
    (338, 200, 105, "¿Cómo registra y guarda las variables de la empresa?"),
    (339, 200, 105, "¿Quién registra los datos?"),
    (340, 200, 105, "¿Cuántos procesos están involucrados en el registro de los datos?"),
    (341, 200, 105,"¿Cuánto tiempo en promedio gasta cada uno de los encargados en el registro de los datos por cada proceso?" ),
    (342, 200, 105, "¿Cómo administra los datos?"),
    (343, 200, 105, "¿Cuenta con su empresa con un área encargada en tecnología o transformación digital?"),
    (344, 200, 105, "¿En caso de ser digital, cuáles son las características del almacenamiento?"),
    (345, 200, 106, "¿Cómo sabes  identificar el estado actual de tu empresa o área?"),
    (346, 200, 106, "¿En qué criterio te basas para la toma de decisiones?"),
    (347, 201, 106, "¿Puedes identificar cuál de las siguientes variables tienes conocimiento y control?"),
    (348, 201, 106, "¿Cuál de las siguientes áreas percibe usted puede ser la más prioritaria para monitorear a través de una herramienta que integre la información para la toma de decisiones?"),
	(349, 200, 107, "Mapeo de la efectividad de los procesos"),
    (350, 200, 107, "Afectación de los procesos"),
    (351, 200, 107, "Alargamiento de procesos simples"),
    (352, 201, 108, "¿Por cuáles de los siguientes canales usted expone sus productos o servicios a sus clientes?"),
    (353, 201, 108, "¿A qué cantidad de público identifica que llega su oferta a través de los canales anteriormente mencionados?"),
    (354, 201, 108, "¿Cuál es la naturaleza de la oferta que mejor describe su portafolio?"),
    (355, 200, 108, "¿A través de cuál de las siguientes estrategias hoy tienen definido el aumento de sus ventas?"),
    (356, 201, 108, "¿Cuáles de los siguientes son los canales de pago mediante los cuales hoy recauda los cobros de sus clientes?"),
    (357, 200, 108, "¿Qué tan satisfecho se encuentra con la forma de pago anteriormente mencionada para el recaudo de cobro a sus clientes?"),
    (358, 201, 108, "Considerando un canal digital para la venta de sus productos y servicios a su mercado objetivo ¿Cuál de las siguientes funcionalidades esperaría encontrar en un espacio digital corporativo? ( puede elegir vaias)"),
	(359, 201, 109, "Identifica en su organización algun o algunos procesos que se caractericen por:"),
	(360, 201, 109, "¿Cuál de los siguientes macroprocesos en su organización involucra las características anteriormente mencionadas? ( Puede elegir varias)");
    
    INSERT INTO rol (id_rol, nombre_rol, descripcion_rol) VALUES
    (001, "Administrador", "Este usuario puede acceder a todas las funcionalidades del sistema"),
    (002, "Cliente", "Este usuario puede acceder solo a su sesión de usuario"),
    (003, "Supervisor", "Este usuario puede acceder a todas las funcionalidades del sistema, que pertenezcan a Comfama"),
    (004, "Encuestador", "Este usuario puede visualizar la información de sus clientes");
    
    INSERT INTO tipo_empresa VALUES
    (800,10, false, "Microempresa"),
    (801, 49,  true, "Pequeña"),
    (802, 249, true, "Mediana"),
    (803, 500, false, "Grande");

    
    INSERT INTO empresa VALUES
    (52489, "Temptech", "calle 25", "Activa", 1 , false, "Tecnológico", "Nacional", 801),
    (41684, "Cortes SAS", "Cr 58", "Activa", 2, true, "Construcción", "Local", 801);
    
    
    SELECT * FROM pregunta;
    SELECT * FROM opcion; 
    