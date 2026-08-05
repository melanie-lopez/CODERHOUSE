
DROP table  if exists Clientes;
DROP table  if exists Productos;

--Decidí usar int para id porque es representativo 
-- VARCHAR para nombre porque es una cadena de texto
-- TEXT para perfil_bio porque es un  texto mas largo
-- FECHA REGISTRO tipo date porque importa fecha, no hace falta hora, sino seria timestamp o datetime
CREATE TABLE Clientes (
    id_cliente int identity(1,1) not null PRIMARY KEY,
    nombre VARCHAR(100),
    perfil_bio TEXT,
    fecha_registro DATE
);

--Decidí usar int para id porque es representativo 
-- VARCHAR para descripcion porque es una cadena de texto
-- decimal para precio porque es cómodo para expresar moneda
-- esta activo es del tipo boolean, como no existe acá es BIT 
CREATE TABLE Productos (
    id_producto int identity(1,1) not null PRIMARY KEY,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2),
    esta_activo BIT not null
);

INSERT INTO Clientes (nombre, perfil_bio, fecha_registro)
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