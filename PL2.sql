
CREATE TABLE investigadores (
    codigo_investigador NUMERIC PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    salario NUMERIC NOT NULL
);

CREATE TABLE contratos (
    codigo_contrato NUMERIC PRIMARY KEY,
    nombre TEXT NOT NULL,
    entidad TEXT NOT NULL,
    coste NUMERIC NOT NULL
);

CREATE TABLE investigadores_contratos (
    codigo_investigador NUMERIC,
    codigo_contrato NUMERIC,
    horas NUMERIC NOT NULL,
    PRIMARY KEY (codigo_investigador, codigo_contrato),
    FOREIGN KEY (codigo_investigador) REFERENCES investigadores(codigo_investigador) 
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (codigo_contrato) REFERENCES contratos(codigo_contrato) 
        ON DELETE RESTRICT ON UPDATE RESTRICT
);


--\COPY investigadores FROM ./DATOS/datos_investigadores.csv WITH (FORMAT csv, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
--\COPY contratos FROM ./DATOS/datos_contratos.csv WITH (FORMAT csv, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
--\COPY investigadores_contratos FROM ./DATOS/datos_investigadores_contratos.csv WITH (FORMAT csv, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');


