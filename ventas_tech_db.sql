CREATE DATABASE RetailPro;
USE RetailPro;


DROP TABLE IF EXISTS detalle_venta;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS sucursal;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorio;

CREATE TABLE categorias (
    categoriaID INT not null IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE territorio (
    territorioID INT not null IDENTITY(1,1) PRIMARY KEY,
    region VARCHAR(50) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    zona VARCHAR(50) NOT NULL
);

CREATE TABLE clientes (
    clienteID INT not null IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100),
    segmento VARCHAR(50),
    fecha_registro DATE
);


CREATE TABLE productos (
    productoID INT not null IDENTITY(1,1) PRIMARY KEY,
    categoriaID INT,
    nombre_producto VARCHAR(100) NOT NULL,
    subcategoria VARCHAR(100),
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (categoriaID) 
        REFERENCES categorias(categoriaID)
);

CREATE TABLE sucursal (
    sucursalID INT not null IDENTITY(1,1) PRIMARY KEY,
    territorioID INT NOT NULL,
    provincia VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL,

    FOREIGN KEY (territorioID)
        REFERENCES territorio(territorioID)
);


CREATE TABLE ventas (
    ventaID INT not null IDENTITY(1,1) PRIMARY KEY,
    clienteID INT NOT NULL,
    sucursalID INT NOT NULL,
    fecha_venta DATE NOT NULL,
    canal VARCHAR(100) NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (clienteID)
        REFERENCES clientes(clienteID),

    FOREIGN KEY (sucursalID)
        REFERENCES sucursal(sucursalID)
);


CREATE TABLE detalle_venta (
    detalleDeVentaID INT not null IDENTITY(1,1) PRIMARY KEY,
    ventaID INT NOT NULL,
    productoID INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (ventaID)
        REFERENCES ventas(ventaID),

    FOREIGN KEY (productoID)
        REFERENCES productos(productoID)
);

-- =============================================
-- SECCIÓN 2: CARGA INICIAL DE DATOS (DML)
-- =============================================

INSERT INTO categorias (nombre_categoria)
VALUES
    ('Computación'),
    ('Audio'),
    ('Accesorios');

INSERT INTO territorio (region, pais, zona)
VALUES
    ('Cuyo', 'Argentina', 'Oeste'),
    ('Centro', 'Argentina', 'Centro'),
    ('Patagonia', 'Argentina', 'Sur');

INSERT INTO clientes (
    nombre,
    email,
    ciudad,
    segmento,
    fecha_registro
)
VALUES
    ('Ana García', 'ana.garcia@email.com', 'Mendoza', 'Particular', '2026-01-15'),
    ('Carlos López', 'carlos.lopez@email.com', 'Rio Negro', 'Empresa', '2026-02-10'),
    ('María Rodríguez', 'maria.rodriguez@email.com', 'San Juan', 'Particular', '2026-03-05'),
    ('Juan Martínez', 'juan.martinez@email.com', 'Córdoba', 'Empresa', '2026-04-20'),
    ('Lucía Fernández', 'lucia.fernandez@email.com', 'Mendoza', 'Particular', '2026-05-12');

INSERT INTO productos (
    categoriaID,
    nombre_producto,
    subcategoria,
    precio,
    costo
)
VALUES
    (1, 'Laptop Pro 15', 'Laptops', 1200.00, 850.00),
    (1, 'Notebook Air 14', 'Laptops', 950.00, 680.00),
    (2, 'Auriculares In-Ear Basic', 'Auriculares In-Ear', 45.00, 25.00),
    (2, 'Auriculares In-Ear Pro', 'Auriculares In-Ear', 80.00, 45.00),
    (2, 'Auriculares Bluetooth', 'Auriculares', 120.00, 70.00),
    (3, 'Mouse Inalámbrico', 'Periféricos', 35.00, 18.00);

INSERT INTO sucursal (
    territorioID,
    provincia,
    direccion
)
VALUES
    (1, 'Mendoza', 'Av. San Martín 1250'),
    (1, 'Mendoza', 'Las Heras 850'),
    (2, 'Córdoba', 'Av. Colón 1450');


INSERT INTO ventas ( 
clienteID,
sucursalID, 
fecha_venta,
canal, 
total_venta ) 
VALUES 
(1, 1, '2026-01-10', 'Online', 125.00),
(1, 1, '2026-01-22', 'Presencial', 80.00),
(2, 2, '2026-02-05', 'Online', 160.00), 
(3, 3, '2026-02-18', 'Presencial', 120.00),
(1, 1, '2026-03-12', 'Online', 195.00), 
(2, 2, '2026-04-08', 'Presencial', 45.00), 
(1, 1, '2026-04-21', 'Online', 35.00), 
(3, 3, '2026-05-15', 'Presencial', 120.00),
(4, 1, '2026-06-03', 'Online', 35.00), 
(5, 2, '2026-06-20', 'Presencial', 45.00);

INSERT INTO detalle_venta ( 
ventaID,
productoID,
cantidad,
precio_unitario,
subtotal ) 
VALUES 
-- Venta 1: 1 In-Ear Pro + 1 In-Ear Basic 
(1,4, 1, 80.00, 80.00),
(1,3, 1, 45.00, 45.00),
-- Venta 2: 1 In-Ear Pro 
(2,4, 1, 80.00, 80.00), 
-- Venta 3: 2 In-Ear Pro 
(3,4, 2, 80.00, 160.00), 
-- Venta 4: 1 Auricular Bluetooth 
(4,5, 1, 120.00, 120.00), 
-- Venta 5: 2 In-Ear Pro + 1 Mouse 
(5, 4,2, 80.00, 160.00), 
(5, 6, 1, 35.00, 35.00), 
-- Venta 6: 1 In-Ear Basic 
(6,3, 1, 45.00, 45.00), 
-- Venta 7: 1 Mouse 
(7, 6, 1, 35.00, 35.00), 
-- Venta 8: 1 Auricular Bluetooth 
(8,5, 1, 120.00, 120.00), 
-- Venta 9: 1 Mouse 
(9,6, 1, 35.00, 35.00), 
-- Venta 10: 1 In-Ear Basic 
(10,3, 1, 45.00, 45.00);



-- =============================================
-- SECCIÓN 3: CONSULTAS DE VALIDACIÓN
-- =============================================

SELECT * FROM categorias;

SELECT * FROM territorio;

SELECT * FROM clientes;

SELECT * FROM productos;

SELECT * FROM sucursal;

SELECT * FROM ventas;

SELECT * FROM detalle_venta;