SET client_encoding TO 'UTF8';


CREATE TABLE clientes (
    
    clienteid INTEGER PRIMARY KEY,
    nombre TEXT,
    apellido TEXT,
    telefono INT UNIQUE,
    email TEXT UNIQUE,
    provincia TEXT

);


CREATE TABLE plazas (

    plazaid INT PRIMARY KEY,
    numero INT,
    nivel INT,
    seccion TEXT
    
);

CREATE TABLE vehiculos (

    vehiculoid INT PRIMARY KEY,
    matricula TEXT UNIQUE,
    marca TEXT,
    modelo TEXT,
    color TEXT,
    clienteid_clientes INT,

    FOREIGN KEY (clienteid_clientes) REFERENCES clientes(clienteid)

);

CREATE TABLE reservas (

    reservaid INT PRIMARY KEY,
    fechainicio TIMESTAMP,
    fechafin TIMESTAMP,
    vehiculoid_vehiculos INT,
    plazaid_plazas INT,
    clienteid_clientes INT,

    FOREIGN KEY (vehiculoid_vehiculos) REFERENCES vehiculos(vehiculoid),
    FOREIGN KEY (plazaid_plazas) REFERENCES plazas(plazaid),
    FOREIGN KEY (clienteid_clientes) REFERENCES clientes(clienteid)

);

CREATE TABLE pagos (

    pagoid INT PRIMARY KEY,
    cantidad NUMERIC(10,2),
    fechapago TIMESTAMP,
    metodopago TEXT,
    reservaid_reservas INT,

    FOREIGN KEY (reservaid_reservas) REFERENCES reservas(reservaid)

);

CREATE TABLE incidencias (

    incidenciaid INTEGER PRIMARY KEY,
    descripcion TEXT,
    fechaincidencia TIMESTAMP,
    estado TEXT,
    reservaid_reservas INT,

    FOREIGN KEY (reservaid_reservas) REFERENCES reservas(reservaid)  

);


-- CUESTION 2
INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia )
VALUES (1, 'Juan', 'García', 949696969, 'email@email.email', 'Guadalajara');

INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes)
VALUES (1, '1234ACB', 'Opel', 'Astra', 'gris', 1);


-- CUESTION 4
SELECT xmin FROM vehiculos WHERE vehiculoid = 1;


--CUESTION 7
CREATE USER usuario1 WITH PASSWORD 'clave1'; 
CREATE USER usuario2 WITH PASSWORD 'clave2'; 
CREATE USER usuario3 WITH PASSWORD 'clave3';

GRANT CONNECT ON DATABASE telpark TO usuario1, usuario2, usuario3; 
GRANT USAGE ON SCHEMA public TO usuario1, usuario2, usuario3; 
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO usuario1, usuario2, usuario3;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, 
DELETE ON TABLES TO usuario1, usuario2, usuario3;


--CUESTION 8
BEGIN;
INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia) 
VALUES (10, 'Luis', 'Pérez', 918856931, 'luis.perez@email.com', 'Madrid');
INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes)
VALUES (10, '1234MMG', 'Audi', 'A3', 'negro', 10);

SELECT * FROM clientes WHERE clienteid = 10;
SELECT * FROM vehiculos WHERE vehiculoid = 10;
SELECT * FROM pg_stat_activity WHERE state = 'idle in transaction';


--CUESTION 12
BEGIN;
INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia) 
VALUES (11, 'Ana', 'Gómez', 942558741, 'ana.gomez@email.com', 'Cantabria');

INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes) 
VALUES (11, '6789HPT', 'BMW', 'X3', 'azul', 11);

UPDATE vehiculos 
SET matricula = '1234MMG'
WHERE vehiculoid = 11;

INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia) 
VALUES (12, 'Carlos', 'Martínez', 915678934, 'carlos.martinez@email.com', 'Madrid');

INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes) 
VALUES (12, '4567HPG', 'Mercedes', 'C200', 'blanco', 12);

COMMIT;


-- CUESTION 13
BEGIN;

INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia) 
VALUES (13, 'Marta', 'Fernández', 937456123, 'marta.fernandez@email.com', 'Barcelona');

INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes) 
VALUES (13, '5678JKL', 'Toyota', 'Corolla', 'rojo', 13);

SELECT * FROM clientes WHERE clienteid = 13;
SELECT * FROM vehiculos WHERE vehiculoid = 13;

SELECT * FROM pg_stat_activity WHERE state = 'idle in transaction';

ROLLBACK;


-- CUESTION 14
CREATE TABLE Tabla1 (
    X REAL PRIMARY KEY
);

CREATE TABLE Tabla2 (
    Y REAL PRIMARY KEY
);

CREATE TABLE Tabla3 (
    Z REAL PRIMARY KEY
);

INSERT INTO Tabla1 (X) VALUES (30);
INSERT INTO Tabla2 (Y) VALUES (40);
INSERT INTO Tabla3 (Z) VALUES (50);


-- CUESTION 15
SELECT Y FROM tabla2;
SELECT Z FROM Tabla3;
SELECT X FROM tabla1;
UPDATE Tabla1 SET X = 50;
UPDATE Tabla2 SET Y = 0.8;
SELECT Y FROM Tabla2;
UPDATE tabla2 SET Y = 66;
SELECT Z FROM Tabla3;
SELECT Y FROM Tabla2;
UPDATE Tabla3 SET Z = -0.7575;
UPDATE Tabla3 SET Z = 100.8;
SELECT X FROM Tabla1;   
UPDATE Tabla1 SET X = 6652.8;
COMMIT;