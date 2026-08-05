
DROP table  if exists Clientes;
DROP table  if exists Productos;

CREATE TABLE Clientes (
    id_cliente int identity(1,1) not null PRIMARY KEY,
    nombre VARCHAR(100),
    perfilbio TEXT,
    fecha_registro DATE
);

CREATE TABLE Productos (
    id_producto int identity(1,1) not null PRIMARY KEY,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2),
    esta_activo BIT not null
);

INSERT INTO Clientes (nombre, perfilbio, fecha_registro)
VALUES
('Juan Pérez', 'Cliente frecuente', '2026-08-04'),
('María Gómez', 'Le gusta la tecnología', '2026-08-03'),
('Carlos López', 'Compra productos deportivos', '2026-08-01'),
('Ana Fernández', 'Cliente nuevo', '2026-07-28');


INSERT INTO Productos (descripcion, precio, esta_activo)
VALUES
('Auriculares In-Ear', 29999.99, 1),
('Auriculares Vincha', 45999.50, 1),
('Mouse Gamer', 35000.00, 1),
('Teclado Mecánico', 78999.90, 1),
('Webcam HD', 42000.00, 0);

SELECT * from clientes;
SELECT * from Productos;