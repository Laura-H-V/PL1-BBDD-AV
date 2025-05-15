SET client_encoding TO 'UTF8';

--en telpark1 (maestro1)
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER telpark2_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5436', dbname 'telpark2');

CREATE USER MAPPING FOR postgres
SERVER telpark2_server
OPTIONS (user 'postgres', password '1234');

CREATE SCHEMA remoto;

IMPORT FOREIGN SCHEMA public 
LIMIT TO (clientes, reservas, vehiculos, pagos, plazas, incidencias)
FROM SERVER telpark2_server
INTO remoto;

CREATE VIEW clientes_remoto AS SELECT * FROM remoto.clientes;
CREATE VIEW reservas_remoto AS SELECT * FROM remoto.reservas;
CREATE VIEW vehiculos_remoto AS SELECT * FROM remoto.vehiculos;
CREATE VIEW pagos_remoto AS SELECT * FROM remoto.pagos;
CREATE VIEW plazas_remoto AS SELECT * FROM remoto.plazas;
CREATE VIEW incidencias_remoto AS SELECT * FROM remoto.incidencias;

--en telpark 2 (maestro2)

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER telpark1_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'localhost', port '5435', dbname 'telpark1');

CREATE USER MAPPING FOR postgres
SERVER telpark1_server
OPTIONS (user 'postgres', password '1234');

CREATE SCHEMA remoto;

IMPORT FOREIGN SCHEMA public 
LIMIT TO (clientes, reservas, vehiculos, pagos, plazas, incidencias)
FROM SERVER telpark1_server
INTO remoto;

CREATE VIEW clientes_remoto AS SELECT * FROM remoto.clientes;
CREATE VIEW reservas_remoto AS SELECT * FROM remoto.reservas;
CREATE VIEW vehiculos_remoto AS SELECT * FROM remoto.vehiculos;
CREATE VIEW pagos_remoto AS SELECT * FROM remoto.pagos;
CREATE VIEW plazas_remoto AS SELECT * FROM remoto.plazas;
CREATE VIEW incidencias_remoto AS SELECT * FROM remoto.incidencias;

--pregunta 2

    --telpark1
    
INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia) VALUES
(1, 'Ana', 'Gómez', 612345678, 'ana.gomez@email.com', 'Madrid'),
(2, 'Luis', 'Pérez', 622345679, 'luis.perez@email.com', 'Barcelona'),
(3, 'María', 'Rodríguez', 633345680, 'maria.rodriguez@email.com', 'Barcelona'),
(4, 'Jorge', 'Martínez', 644345681, 'jorge.martinez@email.com', 'Zaragoza');

INSERT INTO plazas (plazaid, numero, nivel, seccion) VALUES
(1, 101, 1, 'A'),
(2, 102, 1, 'B'),
(3, 103, 2, 'A'),
(4, 104, 2, 'B');

INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes) VALUES
(1, 'ABC123', 'Toyota', 'Corolla', 'Rojo', 1),
(2, 'DEF456', 'Honda', 'Civic', 'Azul', 2),
(3, 'GHI789', 'Ford', 'Focus', 'Negro', 3),
(4, 'JKL012', 'Chevrolet', 'Cruze', 'Blanco', 4);

INSERT INTO reservas (reservaid, fechainicio, fechafin, vehiculoid_vehiculos, plazaid_plazas, clienteid_clientes) VALUES
(1, '2025-05-01 10:00:00', '2025-05-03 10:00:00', 1, 1, 1),
(2, '2025-05-02 11:00:00', '2025-05-04 11:00:00', 2, 2, 2),
(3, '2025-05-03 12:00:00', '2025-05-05 12:00:00', 3, 3, 3),
(4, '2025-05-04 13:00:00', '2025-05-06 13:00:00', 4, 4, 4);


    --telpark2

INSERT INTO clientes (clienteid, nombre, apellido, telefono, email, provincia) VALUES
(5, 'Sofía', 'López', 655345682, 'sofia.lopez@email.com', 'Barcelona'),
(6, 'Carlos', 'Sánchez', 666345683, 'carlos.sanchez@email.com', 'Madrid'),
(7, 'Elena', 'Ramírez', 677345684, 'elena.ramirez@email.com', 'Zaragoza'),
(8, 'David', 'Torres', 688345685, 'david.torres@email.com', 'Madrid');

INSERT INTO plazas (plazaid, numero, nivel, seccion) VALUES
(5, 201, 1, 'C'),
(6, 202, 1, 'D'),
(7, 203, 2, 'C'),
(8, 204, 2, 'D');

INSERT INTO vehiculos (vehiculoid, matricula, marca, modelo, color, clienteid_clientes) VALUES
(5, 'MNO345', 'Volkswagen', 'Golf', 'Gris', 5),
(6, 'PQR678', 'Renault', 'Clio', 'Verde', 6),
(7, 'STU901', 'Peugeot', '208', 'Amarillo', 7),
(8, 'VWX234', 'Fiat', 'Punto', 'Naranja', 8);

INSERT INTO reservas (reservaid, fechainicio, fechafin, vehiculoid_vehiculos, plazaid_plazas, clienteid_clientes) VALUES
(5, '2025-05-05 14:00:00', '2025-05-07 14:00:00', 5, 5, 5),
(6, '2025-05-06 15:00:00', '2025-05-08 15:00:00', 6, 6, 6),
(7, '2025-05-07 16:00:00', '2025-05-09 16:00:00', 7, 7, 7),
(8, '2025-05-08 17:00:00', '2025-05-10 17:00:00', 8, 8, 8);