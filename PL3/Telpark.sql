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
