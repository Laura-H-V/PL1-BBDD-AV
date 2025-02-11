

-- Crear la tabla productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    stock INT CHECK (stock >= 0),
    precio DECIMAL(10,2) CHECK (precio >= 10 AND precio <= 5000)
);
