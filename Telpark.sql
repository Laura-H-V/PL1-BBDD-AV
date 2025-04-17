SET client_encoding TO 'UTF8';

/*
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



\COPY clientes FROM ./datos/clientes.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
\COPY plazas FROM ./datos/plazas.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
\COPY vehiculos FROM ./datos/vehiculos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
\COPY reservas FROM ./datos/reservas.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
\COPY pagos FROM ./datos/pagos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
\COPY incidencias FROM ./datos/incidencias.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');

-- Crear índices útiles antes del borrado masivo
CREATE INDEX IF NOT EXISTS idx_reservas_clienteid ON reservas(clienteid_clientes);
CREATE INDEX IF NOT EXISTS idx_reservas_vehiculoid ON reservas(vehiculoid_vehiculos);
CREATE INDEX IF NOT EXISTS idx_pagos_reservaid ON pagos(reservaid_reservas);
CREATE INDEX IF NOT EXISTS idx_incidencias_reservaid ON incidencias(reservaid_reservas);
CREATE INDEX IF NOT EXISTS idx_vehiculos_clienteid ON vehiculos(clienteid_clientes);

--Clientes: 3.000.000
--Vehiculos: 5.000.000
--plazas: 200.000
--Reservas: 40.000.000
--Pago: 40.000.000
--Incidencias: 4.000.000
*/
BEGIN;
-- 1. Seleccionar aleatoriamente el 30% de los clientes
CREATE TEMP TABLE clientes_a_borrar AS
SELECT clienteid
FROM clientes
ORDER BY RANDOM()
LIMIT (SELECT ROUND(COUNT(*) * 0.3) FROM clientes);

-- 2. Eliminar pagos relacionados con reservas del cliente
DELETE FROM pagos p
USING reservas r, clientes_a_borrar c
WHERE p.reservaid_reservas = r.reservaid
  AND r.clienteid_clientes = c.clienteid;

-- 3. Eliminar incidencias relacionadas con reservas del cliente
DELETE FROM incidencias i
USING reservas r, clientes_a_borrar c
WHERE i.reservaid_reservas = r.reservaid
  AND r.clienteid_clientes = c.clienteid;

-- 4. Eliminar pagos relacionados con reservas del VEHÍCULO del cliente
DELETE FROM pagos p
USING reservas r, vehiculos v, clientes_a_borrar c
WHERE p.reservaid_reservas = r.reservaid
  AND r.vehiculoid_vehiculos = v.vehiculoid
  AND v.clienteid_clientes = c.clienteid;

-- 5. Eliminar incidencias relacionadas con reservas del VEHÍCULO del cliente
DELETE FROM incidencias i
USING reservas r, vehiculos v, clientes_a_borrar c
WHERE i.reservaid_reservas = r.reservaid
  AND r.vehiculoid_vehiculos = v.vehiculoid
  AND v.clienteid_clientes = c.clienteid;

-- 6. Eliminar reservas del cliente
DELETE FROM reservas r
USING clientes_a_borrar c
WHERE r.clienteid_clientes = c.clienteid;

-- 7. Eliminar reservas asociadas a vehículos del cliente
DELETE FROM reservas r
USING vehiculos v, clientes_a_borrar c
WHERE r.vehiculoid_vehiculos = v.vehiculoid
  AND v.clienteid_clientes = c.clienteid;

-- 8. Eliminar vehículos del cliente
DELETE FROM vehiculos v
USING clientes_a_borrar c
WHERE v.clienteid_clientes = c.clienteid;

-- 9. Eliminar clientes
DELETE FROM clientes
WHERE clienteid IN (SELECT clienteid FROM clientes_a_borrar);
COMMIT;
