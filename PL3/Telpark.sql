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


INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia ) VALUES (1, 'Juan', 'García', 949696969, 'email@email.email', 'Guadalajara');
INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes) VALUES (1, '1234ACB', 'Opel', 'Astra', 'gris', 1);

/**
BEGIN;
INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia) 
VALUES (10, 'Luis', 'Pérez', 918856931, 'luis.perez@email.com', 'Madrid');

INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes) 
VALUES (10, '1234MMG', 'Audi', 'A3', 'negro', 10);

SELECT * FROM clientes WHERE clienteid = 10;
SELECT * FROM vehiculos WHERE vehiculoid = 10;


SELECT * FROM pg_stat_activity WHERE state = 'idle in transaction';

SELECT * FROM pg_locks WHERE pid IN (SELECT pid FROM pg_stat_activity WHERE usename = 'usuario1');
*/

/**
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
*/

/**
BEGIN;

INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia) 
VALUES (13, 'Marta', 'Fernández', 937456123, 'marta.fernandez@email.com', 'Barcelona');

INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes) 
VALUES (13, '5678JKL', 'Toyota', 'Corolla', 'rojo', 13);

SELECT * FROM clientes WHERE clienteid = 13;
SELECT * FROM vehiculos WHERE vehiculoid = 13;

SELECT * FROM pg_stat_activity WHERE state = 'idle in transaction';

ROLLBACK;
*/

/**
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


SELECT * FROM Tabla1;
SELECT * FROM Tabla2;
SELECT * FROM Tabla3;

*/