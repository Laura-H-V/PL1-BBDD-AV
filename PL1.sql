CREATE EXTENSION IF NOT EXISTS pageinspect;
CREATE EXTENSION IF NOT EXISTS pgstattuple;

/*
CREATE INDEX indice_producto_id ON productos (producto_id);
CREATE INDEX indice_precio ON productos (precio);
CREATE INDEX indice_hash_producto_id ON productos USING hash (producto_id);
CREATE INDEX indice_hash_precio ON productos USING HASH (precio);
*/

-- Crear la tabla productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    stock INT CHECK (stock >= 0),
    precio DECIMAL(10,2) CHECK (precio >= 10 AND precio <= 5000)
);


\COPY productos FROM ./productos.csv WITH (FORMAT csv, HEADER, DELIMITER E',', NULL 'NULL', ENCODING 'UTF-8');

/*
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
*/
-- SELECT relpages FROM pg_class WHERE relname = 'productos';

/*
SELECT blks_read
FROM pg_stat_database
WHERE datname = 'pl1';

SELECT count(*) FROM productos WHERE  precio = 3000;
SELECT blks_read FROM pg_stat_database WHERE datname = 'pl1';

-- Obtener estadísticas de lectura de bloques
SELECT
  relname AS table_name,
  heap_blks_read AS heap_blocks_read,
  heap_blks_hit AS heap_blocks_hit,
  idx_blks_read AS index_blocks_read,
  idx_blks_hit AS index_blocks_hit
FROM
  pg_statio_user_tables
WHERE
  relname = 'productos';


EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM productos WHERE precio = 3000;

SELECT COUNT(*) FROM productos WHERE precio BETWEEN 3000.00 AND 3000.99;
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'productos';

SELECT relname, relpages, reltuples, pg_size_pretty(pg_relation_size(oid)) FROM pg_class WHERE relname = 'productos';
*/

/*
SELECT DISTINCT ON (btpo_level) btpo_level, gs.blkno AS block_number
FROM generate_series(1, 68549) AS gs(blkno)
CROSS JOIN LATERAL bt_page_stats('indice_precio', gs.blkno)
WHERE btpo_level IN (0, 1, 2, 3)
ORDER BY btpo_level, gs.blkno;
*/