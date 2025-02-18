



-- Crear la tabla productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    stock INT CHECK (stock >= 0),
    precio DECIMAL(10,2) CHECK (precio >= 10 AND precio <= 5000)
);



\COPY productos FROM ./productos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');


/*
SELECT blks_read, blks_hit
FROM pg_stat_database
WHERE datname = 'pl1';

SELECT count(*)
FROM productos
WHERE  precio = 3000;


SELECT blks_read, blks_hit
FROM pg_stat_database
WHERE datname = 'pl1';


EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM productos WHERE precio = 3000;
*/