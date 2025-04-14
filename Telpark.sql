SET ENCODING 'UTF-8';

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



--\COPY clientes FROM ./datos/clientes.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
--\COPY plazas FROM ./datos/plazas.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
--\COPY vehiculos FROM ./datos/vehiculos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
--\COPY reservas FROM ./datos/reservas.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
--\COPY pagos FROM ./datos/pagos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
--\COPY incidencias FROM ./datos/incidencias.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');

/*
Clientes: 3.000.000
Vehiculos: 5.000.000
plazas: 200.000
Reservas: 40.000.000
Pago: