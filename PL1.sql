



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

\COPY productos FROM ./productos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');
\COPY productos2temp FROM ./productos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');

CREATE TABLE productos2 AS
SELECT producto_id, nombre, stock, precio
FROM productos2temp
ORDER BY precio;

DROP TABLE productos2temp;


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


