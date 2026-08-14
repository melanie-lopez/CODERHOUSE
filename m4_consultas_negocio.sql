CREATE database Ventas_Tech_DB;
USE Ventas_Tech_DB;


DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;


CREATE TABLE categorias (
    id_categoria INT not null IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);

CREATE TABLE clientes (
    id_cliente INT not null IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);

CREATE TABLE productos (
    id_producto INT not null IDENTITY(1,1) PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT( 0),
    activo BIT

   
    FOREIGN KEY (id_categoria) 
        REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (
    id_venta INT not null IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),
      FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto),
);

-- =============================================
-- SECCIÓN 2: CARGA INICIAL DE DATOS (DML)
-- =============================================

INSERT INTO categorias VALUES ('Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES ('Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES ('Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES ('Almacenamiento', 'Discos y memorias');

INSERT INTO clientes VALUES ('María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES ('Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES ('Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES ('Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES ('Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

INSERT INTO productos VALUES ('Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos VALUES ('Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos VALUES ('Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO productos VALUES ('Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos VALUES ('SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos VALUES ('Teclado Mecánico',    2,   95.00, 40, 1);

INSERT INTO ventas VALUES ( 1, 1, 2, 1200.00, '2024-01-05');
INSERT INTO ventas VALUES ( 2, 2, 5,   28.00, '2024-02-06');
INSERT INTO ventas VALUES ( 3, 3, 1,  450.00, '2024-02-07');
INSERT INTO ventas VALUES ( 1, 4, 2,  120.00, '2024-02-08');
INSERT INTO ventas VALUES ( 4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES ( 2, 6, 4,   95.00, '2024-04-11');
INSERT INTO ventas VALUES ( 5, 1, 1, 1200.00, '2024-04-12');
INSERT INTO ventas VALUES ( 3, 2, 8,   28.00, '2024-05-13');
INSERT INTO ventas VALUES ( 4, 4, 1,  120.00, '2024-05-14');
INSERT INTO ventas VALUES ( 5, 3, 2,  450.00, '2024-06-15');

-- =============================================
-- CONSULTA 1 — RESUMEN EJECUTIVO MENSUAL
-- =============================================

SELECT
    MONTH (fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH (fecha_venta)
ORDER BY mes;

-- ==============================================
-- CONSULTA 2
-- ==============================================

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- ==============================================
-- CONSULTA 3
-- ==============================================

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


-- ==============================================
-- CONSULTA 4
-- ==============================================


WITH ventas_mensuales AS (
    SELECT
        YEAR(fecha_venta) AS anio,
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
)
SELECT
    anio,
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM ventas_mensuales)
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas_mensuales
ORDER BY anio, mes;


-- =============================================
-- BLOQUE DE CIERRE: HALLAZGOS
-- =============================================

-- 1. El producto 1 (Laptop Pro 15) concentra aproximadamente el 56% de la facturación total.

-- 2. El mes de enero registró la mayor facturación, con $2.400, superando el promedio mensual de aproximadamente $1.104.

-- 3. Los clientes 1, 2, 3, 4 y 5 realizaron más de un pedido, por lo que todos los clientes del período analizado son recurrentes.