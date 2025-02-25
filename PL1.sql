

/*

-- Crear la tabla productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    stock INT CHECK (stock >= 0),
    precio DECIMAL(10,2) CHECK (precio >= 10 AND precio <= 5000)
);

-- Crear la tabla productos2
CREATE TABLE productos2temp (
    producto_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    stock INT CHECK (stock >= 0),
    precio DECIMAL(10,2) CHECK (precio >= 10 AND precio <= 5000)
);

--\COPY productos FROM ./productos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8'
\COPY productos2temp FROM ./productos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');

CREATE TABLE productos2 AS
SELECT producto_id, nombre, stock, precio
FROM productos2temp
ORDER BY precio;

DROP TABLE productos2temp;
*/

-- Crear la tabla productos3

CREATE TABLE productos3 (
    producto_id SERIAL ,
    nombre TEXT NOT NULL,
    stock INT CHECK (stock >= 0),
    precio DECIMAL(10,2) CHECK (precio >= 10 AND precio <= 5000),
    PRIMARY KEY (producto_id, precio)
) PARTITION BY RANGE(precio);


CREATE TABLE productos3_0 PARTITION OF productos3 FOR VALUES FROM (10) TO (510);

CREATE TABLE productos3_1 PARTITION OF productos3 FOR VALUES FROM (510) TO (1010);

CREATE TABLE productos3_2 PARTITION OF productos3 FOR VALUES FROM (1010) TO (1510);

CREATE TABLE productos3_3 PARTITION OF productos3 FOR VALUES FROM (1510) TO (2010);

CREATE TABLE productos3_4 PARTITION OF productos3 FOR VALUES FROM (2010) TO (2510);

CREATE TABLE productos3_5 PARTITION OF productos3 FOR VALUES FROM (2510) TO (3010);

CREATE TABLE productos3_6 PARTITION OF productos3 FOR VALUES FROM (3010) TO (3510);

CREATE TABLE productos3_7 PARTITION OF productos3 FOR VALUES FROM (3510) TO (4010);

CREATE TABLE productos3_8 PARTITION OF productos3 FOR VALUES FROM (4010) TO (4510);

CREATE TABLE productos3_9 PARTITION OF productos3 FOR VALUES FROM (4510) TO (5010);

\COPY productos3 FROM ./productos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');

-- SELECT relpages FROM pg_class WHERE relname = 'productos';

/*
SELECT blks_read
FROM pg_stat_database
WHERE datname = 'pl1';

SELECT count(*) FROM productos WHERE  precio = 3000;
SELECT blks_read FROM pg_stat_database WHERE datname = 'pl1';


EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM productos WHERE precio = 3000;

SELECT COUNT(*) FROM productos WHERE precio BETWEEN 3000.00 AND 3000.99;
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'productos';

SELECT relname, relpages, reltuples, pg_size_pretty(pg_relation_size(oid)) FROM pg_class WHERE relname = 'productos';
*/


